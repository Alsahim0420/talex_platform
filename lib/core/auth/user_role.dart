enum UserRole {
  user,
  superadmin,
  companyAdmin,
  companyLead,
  peopleOps,
  recruiter,
  hiringManager,
  respondent,
}

extension UserRoleX on UserRole {
  String get value => switch (this) {
    UserRole.user => 'user',
    UserRole.superadmin => 'superadmin',
    UserRole.companyAdmin => 'company_admin',
    UserRole.companyLead => 'company_lead',
    UserRole.peopleOps => 'people_ops',
    UserRole.recruiter => 'recruiter',
    UserRole.hiringManager => 'hiring_manager',
    UserRole.respondent => 'respondent',
  };

  bool get isCompanyStaffRole => switch (this) {
    UserRole.companyAdmin ||
    UserRole.companyLead ||
    UserRole.peopleOps ||
    UserRole.recruiter ||
    UserRole.hiringManager => true,
    _ => false,
  };

  static UserRole parse(Object? raw) => switch (raw) {
    'superadmin' => UserRole.superadmin,
    'company_admin' => UserRole.companyAdmin,
    'company_lead' || 'ceo' => UserRole.companyLead,
    'people_ops' || 'hr' => UserRole.peopleOps,
    'recruiter' => UserRole.recruiter,
    'hiring_manager' => UserRole.hiringManager,
    'respondent' => UserRole.respondent,
    _ => UserRole.user,
  };
}

abstract final class SuperAdminConfig {
  static const email = String.fromEnvironment('SUPERADMIN_EMAIL');
  static const password = String.fromEnvironment('SUPERADMIN_PASSWORD');
  static bool get hasEmail => email.trim().isNotEmpty;
  static bool matches(String? candidate) {
    final expected = email.trim().toLowerCase();
    final actual = candidate?.trim().toLowerCase() ?? '';
    return expected.isNotEmpty && actual == expected;
  }
}
