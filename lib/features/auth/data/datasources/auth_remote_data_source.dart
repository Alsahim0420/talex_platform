import 'package:cloud_firestore/cloud_firestore.dart';
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
  FirebaseAuthRemoteDataSource(
    this._firebaseAuth,
    this._googleSignIn,
    this._firestore,
  );

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FirebaseFirestore _firestore;
  Future<void>? _googleInitialization;

  Future<T> _handleFirebaseErrors<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on FirebaseAuthException catch (error) {
      throw ServerException(_firebaseErrorMessage(error.code));
    } on FirebaseException catch (error) {
      throw ServerException(_firestoreErrorMessage(error.code));
    }
  }

  String _firestoreErrorMessage(String code) => switch (code) {
    'permission-denied' =>
      'No tienes permiso para guardar la información del usuario en Firestore.',
    'unavailable' =>
      'Firestore no está disponible temporalmente. Inténtalo nuevamente.',
    'deadline-exceeded' =>
      'Firestore tardó demasiado en responder. Inténtalo nuevamente.',
    'not-found' =>
      'No se encontró la base de datos de Firestore. Verifica su configuración.',
    _ => 'No se pudo guardar la información del usuario. Inténtalo nuevamente.',
  };

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
    'configuration-not-found' =>
      'Firebase Authentication no está configurado correctamente para este método de registro.',
    'app-not-authorized' =>
      'Esta aplicación no está autorizada para usar Firebase Authentication.',
    'internal-error' =>
      'Firebase Authentication tuvo un error interno. Inténtalo nuevamente.',
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

  Future<void> _saveUserDocument(
    UserCredential credential, {
    String? displayName,
    String? companyName,
  }) async {
    final user = credential.user;
    if (user == null) {
      throw const ServerException('No se pudo obtener el usuario autenticado.');
    }
    final providers = user.providerData
        .map((provider) => provider.providerId)
        .toSet()
        .toList();
    final createdAt = user.metadata.creationTime;
    final data = <String, Object?>{
      'uid': user.uid,
      'email': user.email,
      'displayName': displayName ?? user.displayName,
      'photoUrl': user.photoURL,
      'phoneNumber': user.phoneNumber,
      'emailVerified': user.emailVerified,
      'isAnonymous': user.isAnonymous,
      'isActive': true,
      'role': 'user',
      'providers': providers,
      'primaryProvider':
          credential.credential?.providerId ??
          (providers.isEmpty ? null : providers.first),
      'createdAt': createdAt == null
          ? FieldValue.serverTimestamp()
          : Timestamp.fromDate(createdAt),
      'updatedAt': FieldValue.serverTimestamp(),
      'lastLoginAt': FieldValue.serverTimestamp(),
    };
    if (companyName != null) {
      data['companyName'] = companyName.trim().isEmpty
          ? null
          : companyName.trim();
    }
    await _firestore
        .collection('users')
        .doc(user.uid)
        .set(data, SetOptions(merge: true));
  }

  Future<void> _saveUserDocumentWithRetry(
    UserCredential credential, {
    String? displayName,
    String? companyName,
  }) async {
    Object? lastError;
    for (var attempt = 0; attempt < 3; attempt++) {
      try {
        await _saveUserDocument(
          credential,
          displayName: displayName,
          companyName: companyName,
        );
        return;
      } catch (error) {
        lastError = error;
        if (attempt < 2) {
          await Future<void>.delayed(
            Duration(milliseconds: 250 * (attempt + 1)),
          );
        }
      }
    }
    if (lastError is FirebaseException) {
      throw ServerException(_firestoreErrorMessage(lastError.code));
    }
    if (lastError is ServerException) throw lastError;
    throw const ServerException(
      'La cuenta se creó en Authentication, pero no se pudo guardar el perfil en Firestore. Inicia sesión para reintentarlo.',
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
  }) => _handleFirebaseErrors(() async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    await _saveUserDocumentWithRetry(credential);
    return _mapUser(credential.user);
  });

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
        await _saveUserDocumentWithRetry(credential);
        return _mapUser(credential.user);
      }

      await (_googleInitialization ??= _googleSignIn.initialize());
      final googleUser = await _googleSignIn.authenticate();
      final googleAuth = googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );
      await _saveUserDocumentWithRetry(userCredential);
      return _mapUser(userCredential.user);
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
    } on FirebaseException catch (error) {
      throw ServerException(_firestoreErrorMessage(error.code));
    } on GoogleSignInException catch (error) {
      if (error.code == GoogleSignInExceptionCode.canceled) {
        throw const ServerException(
          'Cancelaste el inicio de sesión con Google.',
        );
      }
      throw const ServerException(
        'No se pudo iniciar sesión con Google. Inténtalo nuevamente.',
      );
    } on ServerException {
      rethrow;
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
      try {
        await credential.user?.updateDisplayName(displayName.trim());
      } on FirebaseAuthException {
        // El nombre también se guarda en Firestore; no se elimina la cuenta
        // si Firebase Auth no puede actualizar este dato opcional.
      }
    }
    await _saveUserDocumentWithRetry(
      credential,
      displayName: displayName?.trim(),
      companyName: companyName?.trim(),
    );
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
