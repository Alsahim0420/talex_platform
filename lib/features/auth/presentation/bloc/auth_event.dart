part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
}

final class AuthSessionRequested extends AuthEvent {
  const AuthSessionRequested();
  @override
  List<Object?> get props => [];
}

final class AuthSignInRequested extends AuthEvent {
  const AuthSignInRequested({required this.email, required this.password});
  final String email;
  final String password;
  @override
  List<Object> get props => [email, password];
}

final class AuthSignUpRequested extends AuthEvent {
  const AuthSignUpRequested({
    required this.email,
    required this.password,
    this.displayName,
    this.companyName,
  });
  final String email;
  final String password;
  final String? displayName;
  final String? companyName;
  @override
  List<Object?> get props => [email, password, displayName, companyName];
}

final class AuthSignOutRequested extends AuthEvent {
  const AuthSignOutRequested();
  @override
  List<Object?> get props => [];
}

final class AuthPasswordResetRequested extends AuthEvent {
  const AuthPasswordResetRequested({required this.email});
  final String email;
  @override
  List<Object> get props => [email];
}
