import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:talex_platform/core/error/failure.dart';
import 'package:talex_platform/features/invitations/domain/entities/invitation.dart';
import 'package:talex_platform/features/invitations/domain/repositories/invitation_repository.dart';

final class GetInvitations {
  const GetInvitations(this._repository);
  final InvitationRepository _repository;
  Future<Either<Failure, List<Invitation>>> call() =>
      _repository.getInvitations();
}

final class CreateInvitation {
  const CreateInvitation(this._repository);
  final InvitationRepository _repository;
  Future<Either<Failure, Invitation>> call(CreateInvitationParams params) =>
      _repository.createInvitation(
        personName: params.personName,
        email: params.email,
        assessmentName: params.assessmentName,
        expiresAt: params.expiresAt,
        message: params.message,
      );
}

class CreateInvitationParams extends Equatable {
  const CreateInvitationParams({
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

final class ResendInvitation {
  const ResendInvitation(this._repository);
  final InvitationRepository _repository;
  Future<Either<Failure, Invitation>> call(String id) =>
      _repository.resendInvitation(id);
}

final class CancelInvitation {
  const CancelInvitation(this._repository);
  final InvitationRepository _repository;
  Future<Either<Failure, Invitation>> call(String id) =>
      _repository.cancelInvitation(id);
}
