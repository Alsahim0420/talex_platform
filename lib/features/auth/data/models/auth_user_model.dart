import 'package:talex_platform/core/auth/user_role.dart';

class AuthUserModel {
  const AuthUserModel({
    required this.id,
    required this.email,
    this.displayName,
    this.companyName,
    this.role = UserRole.user,
    this.companyId,
    this.documentNumber,
    this.mustChangePassword = false,
    this.mustReviewCompanyDna = false,
  });
  final String id;
  final String email;
  final String? displayName;
  final String? companyName;
  final UserRole role;
  final String? companyId;
  final String? documentNumber;
  final bool mustChangePassword;
  final bool mustReviewCompanyDna;
}
