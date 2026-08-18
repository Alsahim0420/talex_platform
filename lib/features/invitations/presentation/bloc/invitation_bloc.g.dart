// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invitation_bloc.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InvitationStateCWProxy {
  InvitationState status(InvitationViewStatus status);

  InvitationState invitations(List<Invitation> invitations);

  InvitationState failure(Failure? failure);

  InvitationState operation(InvitationOperation? operation);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `InvitationState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InvitationState(...).copyWith(id: 12, name: "My name")
  /// ```
  InvitationState call({
    InvitationViewStatus status,
    List<Invitation> invitations,
    Failure? failure,
    InvitationOperation? operation,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfInvitationState.copyWith(...)` or call `instanceOfInvitationState.copyWith.fieldName(value)` for a single field.
class _$InvitationStateCWProxyImpl implements _$InvitationStateCWProxy {
  const _$InvitationStateCWProxyImpl(this._value);

  final InvitationState _value;

  @override
  InvitationState status(InvitationViewStatus status) => call(status: status);

  @override
  InvitationState invitations(List<Invitation> invitations) =>
      call(invitations: invitations);

  @override
  InvitationState failure(Failure? failure) => call(failure: failure);

  @override
  InvitationState operation(InvitationOperation? operation) =>
      call(operation: operation);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `InvitationState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InvitationState(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  InvitationState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? invitations = const $CopyWithPlaceholder(),
    Object? failure = const $CopyWithPlaceholder(),
    Object? operation = const $CopyWithPlaceholder(),
  }) {
    return InvitationState(
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as InvitationViewStatus,
      invitations:
          invitations == const $CopyWithPlaceholder() || invitations == null
          ? _value.invitations
          // ignore: cast_nullable_to_non_nullable
          : invitations as List<Invitation>,
      failure: failure == const $CopyWithPlaceholder()
          ? _value.failure
          // ignore: cast_nullable_to_non_nullable
          : failure as Failure?,
      operation: operation == const $CopyWithPlaceholder()
          ? _value.operation
          // ignore: cast_nullable_to_non_nullable
          : operation as InvitationOperation?,
    );
  }
}

extension $InvitationStateCopyWith on InvitationState {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfInvitationState.copyWith(...)` or `instanceOfInvitationState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InvitationStateCWProxy get copyWith => _$InvitationStateCWProxyImpl(this);
}
