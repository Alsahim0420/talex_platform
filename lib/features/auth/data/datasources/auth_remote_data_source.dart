import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:talex_platform/core/error/exceptions.dart';
import 'package:talex_platform/features/auth/data/datasources/google_popup_monitor.dart';
import 'package:talex_platform/features/auth/data/models/auth_user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<AuthUserModel?> getCurrentUser();
  Future<AuthUserModel> signIn({
    required String email,
    required String password,
  });
  Future<AuthUserModel> signInWithGoogle();
  Future<AuthUserModel> signUp({
    required String email,
    required String password,
    String? displayName,
    String? companyName,
  });
  Future<void> signOut();
  Future<void> sendPasswordResetEmail(String email);
}

final class FirebaseAuthRemoteDataSource implements AuthRemoteDataSource {
  FirebaseAuthRemoteDataSource(this._firebaseAuth, this._googleSignIn);

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  Future<void>? _googleInitialization;

  Future<T> _handleFirebaseErrors<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on FirebaseAuthException catch (error) {
      throw ServerException(_firebaseErrorMessage(error.code));
    }
  }

  String _firebaseErrorMessage(String code) => switch (code) {
    'user-not-found' =>
      'No existe una cuenta registrada con este correo electrónico.',
    'wrong-password' || 'invalid-credential' =>
      'El correo electrónico o la contraseña son incorrectos.',
    'invalid-email' => 'El correo electrónico no es válido.',
    'user-disabled' =>
      'Esta cuenta está deshabilitada. Comunícate con soporte.',
    'email-already-in-use' =>
      'Ya existe una cuenta registrada con este correo electrónico.',
    'weak-password' => 'La contraseña es muy débil. Usa al menos 6 caracteres.',
    'operation-not-allowed' =>
      'Este método de acceso no está habilitado en Firebase.',
    'too-many-requests' =>
      'Se realizaron demasiados intentos. Espera un momento e inténtalo nuevamente.',
    'network-request-failed' =>
      'No se pudo conectar con Firebase. Revisa tu conexión a internet.',
    'account-exists-with-different-credential' =>
      'Ya existe una cuenta con este correo usando otro método de acceso.',
    'requires-recent-login' =>
      'Por seguridad, vuelve a iniciar sesión antes de continuar.',
    _ => 'No se pudo completar la operación. Inténtalo nuevamente.',
  };

  AuthUserModel _mapUser(User? user) {
    if (user == null) {
      throw const ServerException('No se pudo obtener el usuario autenticado.');
    }
    return AuthUserModel(
      id: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
    );
  }

  @override
  Future<AuthUserModel?> getCurrentUser() async {
    final user = _firebaseAuth.currentUser;
    return user == null ? null : _mapUser(user);
  }

  @override
  Future<AuthUserModel> signIn({
    required String email,
    required String password,
  }) => _handleFirebaseErrors(
    () async => _mapUser(
      (await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      )).user,
    ),
  );

  @override
  Future<AuthUserModel> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        final provider = GoogleAuthProvider()
          ..addScope('email')
          ..setCustomParameters({'prompt': 'select_account'});
        final credential = await monitorGooglePopup(
          () => _firebaseAuth.signInWithPopup(provider),
        );
        return _mapUser(credential.user);
      }

      await (_googleInitialization ??= _googleSignIn.initialize());
      final googleUser = await _googleSignIn.authenticate();
      final googleAuth = googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      return _mapUser(
        (await _firebaseAuth.signInWithCredential(credential)).user,
      );
    } on FirebaseAuthException catch (error) {
      if (error.code == 'popup-closed-by-user' ||
          error.code == 'cancelled-popup-request') {
        throw const ServerException(
          'Cerraste la ventana de Google antes de completar el inicio de sesión.',
        );
      }
      if (error.code == 'popup-blocked') {
        throw const ServerException(
          'El navegador bloqueó la ventana de Google. Habilita las ventanas emergentes e inténtalo nuevamente.',
        );
      }
      throw const ServerException(
        'No se pudo iniciar sesión con Google. Inténtalo nuevamente.',
      );
    } on GoogleSignInException catch (error) {
      if (error.code == GoogleSignInExceptionCode.canceled) {
        throw const ServerException(
          'Cancelaste el inicio de sesión con Google.',
        );
      }
      throw const ServerException(
        'No se pudo iniciar sesión con Google. Inténtalo nuevamente.',
      );
    } catch (_) {
      throw const ServerException(
        'No se pudo iniciar sesión con Google. Inténtalo nuevamente.',
      );
    }
  }

  @override
  Future<AuthUserModel> signUp({
    required String email,
    required String password,
    String? displayName,
    String? companyName,
  }) => _handleFirebaseErrors(() async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (displayName != null && displayName.trim().isNotEmpty) {
      await credential.user?.updateDisplayName(displayName.trim());
    }
    return _mapUser(_firebaseAuth.currentUser);
  });

  @override
  Future<void> signOut() => _handleFirebaseErrors(() async {
    await _firebaseAuth.signOut();
    if (!kIsWeb) await _googleSignIn.signOut();
  });

  @override
  Future<void> sendPasswordResetEmail(String email) => _handleFirebaseErrors(
    () => _firebaseAuth.sendPasswordResetEmail(email: email),
  );
}

/// Implementación temporal reemplazable por Firebase o una API.
final class InMemoryAuthRemoteDataSource implements AuthRemoteDataSource {
  AuthUserModel? _currentUser;

  @override
  Future<AuthUserModel?> getCurrentUser() async => _currentUser;

  @override
  Future<AuthUserModel> signIn({
    required String email,
    required String password,
  }) async {
    _validate(email, password);
    return _currentUser = AuthUserModel(id: email, email: email);
  }

  @override
  Future<AuthUserModel> signInWithGoogle() async => throw const ServerException(
    'Google Sign-In no está disponible en el modo de memoria.',
  );

  @override
  Future<AuthUserModel> signUp({
    required String email,
    required String password,
    String? displayName,
    String? companyName,
  }) async {
    _validate(email, password);
    return _currentUser = AuthUserModel(
      id: email,
      email: email,
      displayName: displayName,
      companyName: companyName,
    );
  }

  @override
  Future<void> signOut() async => _currentUser = null;

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    if (!_isValidEmail(email)) {
      throw const ServerException('Ingresa un correo válido.');
    }
  }

  void _validate(String email, String password) {
    if (!_isValidEmail(email) || password.length < 6) {
      throw const ServerException(
        'Usa un correo válido y una contraseña de al menos 6 caracteres.',
      );
    }
  }

  bool _isValidEmail(String value) =>
      RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value);
}
