import 'package:dartz/dartz.dart';
import 'package:talex_platform/core/error/exceptions.dart';
import 'package:talex_platform/core/error/failure.dart';
import 'package:talex_platform/features/invitations/data/datasources/invitation_data_source.dart';
import 'package:talex_platform/features/invitations/data/mappers/invitation_mapper.dart';
import 'package:talex_platform/features/invitations/domain/entities/invitation.dart';
import 'package:talex_platform/features/invitations/domain/repositories/invitation_repository.dart';

final class InvitationRepositoryImpl implements InvitationRepository {
  const InvitationRepositoryImpl(this._source);
  final InvitationDataSource _source;
  Future<Either<Failure, T>> _guard<T>(Future<T> Function() action) async {
    try {
      return Right(await action());
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    } catch (_) {
      return const Left(UnexpectedFailure('Ocurrió un error inesperado.'));
    }
  }

  @override
  Future<Either<Failure, List<Invitation>>> getInvitations() => _guard(
    () async => (await _source.getInvitations())
        .map((item) => item.toEntity())
        .toList(),
  );
  @override
  Future<Either<Failure, Invitation>> createInvitation({
    required String personName,
    required String email,
    required String assessmentName,
    required DateTime expiresAt,
    String? message,
  }) => _guard(
    () async => (await _source.createInvitation(
      personName: personName,
      email: email,
      assessmentName: assessmentName,
      expiresAt: expiresAt,
      message: message,
    )).toEntity(),
  );
  @override
  Future<Either<Failure, Invitation>> resendInvitation(String id) =>
      _guard(() async => (await _source.resendInvitation(id)).toEntity());
  @override
  Future<Either<Failure, Invitation>> cancelInvitation(String id) =>
      _guard(() async => (await _source.cancelInvitation(id)).toEntity());
}
