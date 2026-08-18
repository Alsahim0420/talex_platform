import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  const AuthUser({
    required this.id,
    required this.email,
    this.displayName,
    this.companyName,
  });
  final String id;
  final String email;
  final String? displayName;
  final String? companyName;
  @override
  List<Object?> get props => [id, email, displayName, companyName];
}
