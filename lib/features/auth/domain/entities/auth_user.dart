import 'package:equatable/equatable.dart';
import 'package:talex_platform/core/auth/user_role.dart';

class AuthUser extends Equatable {
  const AuthUser({
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
  bool get isSuperAdmin => role == UserRole.superadmin;
  bool get isRespondent => role == UserRole.respondent;
  bool get isCompanyStaff =>
      !isSuperAdmin &&
      !isRespondent &&
      (role.isCompanyStaffRole ||
          (companyId != null && companyId!.trim().isNotEmpty));
  @override
  List<Object?> get props => [
    id,
    email,
    displayName,
    companyName,
    role,
    companyId,
    documentNumber,
    mustChangePassword,
    mustReviewCompanyDna,
  ];
}
