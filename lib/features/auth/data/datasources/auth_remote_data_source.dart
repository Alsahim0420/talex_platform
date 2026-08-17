import 'package:talex_platform/core/error/exceptions.dart';
import 'package:talex_platform/features/auth/data/models/auth_user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<AuthUserModel?> getCurrentUser();
  Future<AuthUserModel> signIn({
    required String email,
    required String password,
  });
  Future<AuthUserModel> signUp({
    required String email,
    required String password,
    String? displayName,
  });
  Future<void> signOut();
  Future<void> sendPasswordResetEmail(String email);
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
  Future<AuthUserModel> signUp({
    required String email,
    required String password,
    String? displayName,
  }) async {
    _validate(email, password);
    return _currentUser = AuthUserModel(
      id: email,
      email: email,
      displayName: displayName,
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
