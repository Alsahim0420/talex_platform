// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_bloc.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthStateCWProxy {
  AuthState status(AuthStatus status);

  AuthState failure(Failure? failure);

  AuthState user(AuthUser? user);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AuthState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuthState(...).copyWith(id: 12, name: "My name")
  /// ```
  AuthState call({AuthStatus status, Failure? failure, AuthUser? user});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAuthState.copyWith(...)` or call `instanceOfAuthState.copyWith.fieldName(value)` for a single field.
class _$AuthStateCWProxyImpl implements _$AuthStateCWProxy {
  const _$AuthStateCWProxyImpl(this._value);

  final AuthState _value;

  @override
  AuthState status(AuthStatus status) => call(status: status);

  @override
  AuthState failure(Failure? failure) => call(failure: failure);

  @override
  AuthState user(AuthUser? user) => call(user: user);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AuthState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuthState(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  AuthState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? failure = const $CopyWithPlaceholder(),
    Object? user = const $CopyWithPlaceholder(),
  }) {
    return AuthState(
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as AuthStatus,
      failure: failure == const $CopyWithPlaceholder()
          ? _value.failure
          // ignore: cast_nullable_to_non_nullable
          : failure as Failure?,
      user: user == const $CopyWithPlaceholder()
          ? _value.user
          // ignore: cast_nullable_to_non_nullable
          : user as AuthUser?,
    );
  }
}

extension $AuthStateCopyWith on AuthState {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAuthState.copyWith(...)` or `instanceOfAuthState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuthStateCWProxy get copyWith => _$AuthStateCWProxyImpl(this);
}
