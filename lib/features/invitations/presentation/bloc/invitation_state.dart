part of 'invitation_bloc.dart';

enum InvitationViewStatus { initial, loading, submitting, success, failure }

enum InvitationOperation { created, resent, cancelled }

@CopyWith()
class InvitationState extends Equatable {
  const InvitationState({
    this.status = InvitationViewStatus.initial,
    this.invitations = const [],
    this.failure,
    this.operation,
  });
  final InvitationViewStatus status;
  final List<Invitation> invitations;
  final Failure? failure;
  final InvitationOperation? operation;
  @override
  List<Object?> get props => [status, invitations, failure, operation];
}
