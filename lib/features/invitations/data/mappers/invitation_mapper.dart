import 'package:talex_platform/features/invitations/data/models/invitation_model.dart';
import 'package:talex_platform/features/invitations/domain/entities/invitation.dart';

extension InvitationModelMapper on InvitationModel {
  Invitation toEntity() => Invitation(
    id: id,
    personName: personName,
    email: email,
    assessmentName: assessmentName,
    expiresAt: expiresAt,
    status: status,
    createdAt: createdAt,
    message: message,
  );
}
