import 'package:equatable/equatable.dart';
import 'package:talex_platform/core/auth/user_role.dart';

class AuthUser extends Equatable {
  const AuthUser({
    required this.id,
    required this.email,
    this.displayName,
    this.companyName,
    this.role = UserRole.user,
  });
  final String id;
  final String email;
  final String? displayName;
  final String? companyName;
  final UserRole role;
  bool get isSuperAdmin => role == UserRole.superadmin;
  @override
  List<Object?> get props => [id, email, displayName, companyName, role];
}
