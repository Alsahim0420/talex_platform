import 'package:dartz/dartz.dart';
import 'package:talex_platform/core/error/failure.dart';
import 'package:talex_platform/features/invitations/domain/entities/invitation.dart';

abstract interface class InvitationRepository {
  Future<Either<Failure, List<Invitation>>> getInvitations();
  Future<Either<Failure, Invitation>> createInvitation({
    required String personName,
    required String email,
    required String assessmentName,
    required DateTime expiresAt,
    String? message,
  });
  Future<Either<Failure, Invitation>> resendInvitation(String id);
  Future<Either<Failure, Invitation>> cancelInvitation(String id);
}
