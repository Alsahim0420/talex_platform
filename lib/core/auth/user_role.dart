enum UserRole { user, superadmin }

extension UserRoleX on UserRole {
  String get value => switch (this) {
    UserRole.user => 'user',
    UserRole.superadmin => 'superadmin',
  };

  static UserRole parse(Object? raw) =>
      raw == 'superadmin' ? UserRole.superadmin : UserRole.user;
}

abstract final class SuperAdminConfig {
  /// Email autorizado para elevar a SuperAdmin (debug y coincidencia con
  /// `config/superadmin` en Firestore). No sustituye las reglas de backend.
  static const email = String.fromEnvironment('SUPERADMIN_EMAIL');

  /// Prefijo de contraseña solo para rellenar el login en debug. El usuario
  /// real vive en Firebase Auth y se cambia con "Olvidaste tu contraseña".
  static const password = String.fromEnvironment('SUPERADMIN_PASSWORD');

  static bool get hasEmail => email.trim().isNotEmpty;

  static bool matches(String? candidate) {
    final expected = email.trim().toLowerCase();
    final actual = candidate?.trim().toLowerCase() ?? '';
    return expected.isNotEmpty && actual == expected;
  }
}
