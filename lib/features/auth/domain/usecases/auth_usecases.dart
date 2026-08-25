import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:talex_platform/core/error/failure.dart';
import 'package:talex_platform/features/auth/domain/entities/auth_user.dart';
import 'package:talex_platform/features/auth/domain/repositories/auth_repository.dart';

final class GetCurrentUser {
  const GetCurrentUser(this._repository);
  final AuthRepository _repository;
  Future<Either<Failure, AuthUser?>> call() => _repository.getCurrentUser();
}

final class SignIn {
  const SignIn(this._repository);
  final AuthRepository _repository;
  Future<Either<Failure, AuthUser>> call(SignInParams params) =>
      _repository.signIn(email: params.email, password: params.password);
}

final class SignInParams extends Equatable {
  const SignInParams({required this.email, required this.password});
  final String email;
  final String password;
  @override
  List<Object> get props => [email, password];
}

final class SignInWithGoogle {
  const SignInWithGoogle(this._repository);
  final AuthRepository _repository;
  Future<Either<Failure, AuthUser>> call() => _repository.signInWithGoogle();
}

final class SignUp {
  const SignUp(this._repository);
  final AuthRepository _repository;
  Future<Either<Failure, AuthUser>> call(SignUpParams params) =>
      _repository.signUp(
        email: params.email,
        password: params.password,
        displayName: params.displayName,
        companyName: params.companyName,
      );
}

final class SignUpParams extends Equatable {
  const SignUpParams({
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

final class SignOut {
  const SignOut(this._repository);
  final AuthRepository _repository;
  Future<Either<Failure, Unit>> call() => _repository.signOut();
}

final class SendPasswordResetEmail {
  const SendPasswordResetEmail(this._repository);
  final AuthRepository _repository;
  Future<Either<Failure, Unit>> call(SendPasswordResetEmailParams params) =>
      _repository.sendPasswordResetEmail(params.email);
}

final class SendPasswordResetEmailParams extends Equatable {
  const SendPasswordResetEmailParams({required this.email});
  final String email;
  @override
  List<Object> get props => [email];
}
