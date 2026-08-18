import 'package:talex_platform/features/invitations/domain/entities/invitation.dart';

class InvitationModel {
  const InvitationModel({
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

  InvitationModel copyWith({InvitationStatus? status, DateTime? expiresAt}) =>
      InvitationModel(
        id: id,
        personName: personName,
        email: email,
        assessmentName: assessmentName,
        expiresAt: expiresAt ?? this.expiresAt,
        status: status ?? this.status,
        createdAt: createdAt,
        message: message,
      );
}
