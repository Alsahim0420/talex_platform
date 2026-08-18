import 'package:equatable/equatable.dart';

enum InvitationStatus {
  pending,
  inProgress,
  completed,
  expired,
  cancelled,
  interrupted,
}

class Invitation extends Equatable {
  const Invitation({
    required this.id,
    required this.personName,
    required this.email,
    required this.assessmentName,
    required this.expiresAt,
    required this.status,
    required this.createdAt,
    this.message,
  });
  final String id, personName, email, assessmentName;
  final DateTime expiresAt, createdAt;
  final InvitationStatus status;
  final String? message;
  @override
  List<Object?> get props => [
    id,
    personName,
    email,
    assessmentName,
    expiresAt,
    status,
    createdAt,
    message,
  ];
}
