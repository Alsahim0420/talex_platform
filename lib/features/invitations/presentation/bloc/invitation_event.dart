part of 'invitation_bloc.dart';

sealed class InvitationEvent extends Equatable {
  const InvitationEvent();
}

class InvitationsRequested extends InvitationEvent {
  const InvitationsRequested();
  @override
  List<Object?> get props => [];
}

class InvitationCreated extends InvitationEvent {
  const InvitationCreated({
    required this.personName,
    required this.email,
    required this.assessmentName,
    required this.expiresAt,
    this.message,
  });
  final String personName, email, assessmentName;
  final DateTime expiresAt;
  final String? message;
  @override
  List<Object?> get props => [
    personName,
    email,
    assessmentName,
    expiresAt,
    message,
  ];
}

class InvitationResent extends InvitationEvent {
  const InvitationResent(this.id);
  final String id;
  @override
  List<Object> get props => [id];
}

class InvitationCancelled extends InvitationEvent {
  const InvitationCancelled(this.id);
  final String id;
  @override
  List<Object> get props => [id];
}
