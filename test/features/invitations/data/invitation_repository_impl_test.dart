import 'package:flutter_test/flutter_test.dart';
import 'package:talex_platform/features/invitations/data/datasources/invitation_data_source.dart';
import 'package:talex_platform/features/invitations/data/repositories/invitation_repository_impl.dart';
import 'package:talex_platform/features/invitations/domain/entities/invitation.dart';

void main() {
  late InvitationRepositoryImpl repository;

  setUp(
    () => repository = InvitationRepositoryImpl(InMemoryInvitationDataSource()),
  );

  test('creates and lists an invitation', () async {
    final result = await repository.createInvitation(
      personName: 'Ana Pérez',
      email: 'ana@empresa.com',
      assessmentName: 'Razonamiento lógico',
      expiresAt: DateTime.now().add(const Duration(days: 7)),
    );
    expect(result.isRight(), isTrue);
    final list = await repository.getInvitations();
    list.fold((failure) => fail(failure.message), (items) {
      expect(items, hasLength(1));
      expect(items.first.status, InvitationStatus.pending);
    });
  });

  test('prevents duplicate pending invitations', () async {
    final expiry = DateTime.now().add(const Duration(days: 7));
    await repository.createInvitation(
      personName: 'Ana',
      email: 'ana@empresa.com',
      assessmentName: 'Evaluación',
      expiresAt: expiry,
    );
    final duplicate = await repository.createInvitation(
      personName: 'Ana',
      email: 'ana@empresa.com',
      assessmentName: 'Evaluación',
      expiresAt: expiry,
    );
    expect(duplicate.isLeft(), isTrue);
  });

  test('cancels an invitation', () async {
    final created = await repository.createInvitation(
      personName: 'Ana',
      email: 'ana@empresa.com',
      assessmentName: 'Evaluación',
      expiresAt: DateTime.now().add(const Duration(days: 7)),
    );
    final id = created.fold(
      (failure) => throw StateError(failure.message),
      (item) => item.id,
    );
    final cancelled = await repository.cancelInvitation(id);
    cancelled.fold(
      (failure) => fail(failure.message),
      (item) => expect(item.status, InvitationStatus.cancelled),
    );
  });
}
