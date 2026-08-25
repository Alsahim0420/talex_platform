import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talex_platform/core/error/failure.dart';
import 'package:talex_platform/features/auth/domain/entities/auth_user.dart';
import 'package:talex_platform/features/auth/domain/usecases/auth_usecases.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.g.dart';

final class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required SignIn signIn,
    required SignInWithGoogle signInWithGoogle,
    required SignUp signUp,
    required SignOut signOut,
    required GetCurrentUser getCurrentUser,
    required SendPasswordResetEmail sendPasswordResetEmail,
  }) : _signIn = signIn,
       _signInWithGoogle = signInWithGoogle,
       _signUp = signUp,
       _signOut = signOut,
       _getCurrentUser = getCurrentUser,
       _sendPasswordResetEmail = sendPasswordResetEmail,
       super(const AuthState()) {
    on<AuthSessionRequested>(_onSessionRequested);
    on<AuthSignInRequested>(_onSignInRequested);
    on<AuthGoogleSignInRequested>(_onGoogleSignInRequested);
    on<AuthSignUpRequested>(_onSignUpRequested);
    on<AuthSignOutRequested>(_onSignOutRequested);
    on<AuthPasswordResetRequested>(_onPasswordResetRequested);
  }

  final SignIn _signIn;
  final SignInWithGoogle _signInWithGoogle;
  final SignUp _signUp;
  final SignOut _signOut;
  final GetCurrentUser _getCurrentUser;
  final SendPasswordResetEmail _sendPasswordResetEmail;

  Future<void> _onSessionRequested(
    AuthSessionRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading, failure: null));
    final result = await _getCurrentUser();
    emit(
      result.fold(
        (failure) => state.copyWith(
          status: AuthStatus.failure,
          failure: failure,
          user: null,
        ),
        (user) => state.copyWith(
          status: user == null
              ? AuthStatus.unauthenticated
              : AuthStatus.authenticated,
          user: user,
          failure: null,
        ),
      ),
    );
  }

  Future<void> _onSignInRequested(
    AuthSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading, failure: null));
    final result = await _signIn(
      SignInParams(email: event.email, password: event.password),
    );
    emit(
      result.fold(
        (failure) => state.copyWith(
          status: AuthStatus.failure,
          failure: failure,
          user: null,
        ),
        (user) => state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
          failure: null,
        ),
      ),
    );
  }

  Future<void> _onSignUpRequested(
    AuthSignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading, failure: null));
    final result = await _signUp(
      SignUpParams(
        email: event.email,
        password: event.password,
        displayName: event.displayName,
        companyName: event.companyName,
      ),
    );
    emit(
      result.fold(
        (failure) => state.copyWith(
          status: AuthStatus.failure,
          failure: failure,
          user: null,
        ),
        (user) => state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
          failure: null,
        ),
      ),
    );
  }

  Future<void> _onGoogleSignInRequested(
    AuthGoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.googleLoading, failure: null));
    final result = await _signInWithGoogle();
    emit(
      result.fold(
        (failure) => state.copyWith(
          status: AuthStatus.googleFailure,
          failure: failure,
          user: null,
        ),
        (user) => state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
          failure: null,
        ),
      ),
    );
  }

  Future<void> _onSignOutRequested(
    AuthSignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading, failure: null));
    final result = await _signOut();
    emit(
      result.fold(
        (failure) =>
            state.copyWith(status: AuthStatus.failure, failure: failure),
        (_) => state.copyWith(
          status: AuthStatus.unauthenticated,
          user: null,
          failure: null,
        ),
      ),
    );
  }

  Future<void> _onPasswordResetRequested(
    AuthPasswordResetRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading, failure: null));
    final result = await _sendPasswordResetEmail(
      SendPasswordResetEmailParams(email: event.email),
    );
    emit(
      result.fold(
        (failure) =>
            state.copyWith(status: AuthStatus.failure, failure: failure),
        (_) =>
            state.copyWith(status: AuthStatus.passwordResetSent, failure: null),
      ),
    );
  }
}
