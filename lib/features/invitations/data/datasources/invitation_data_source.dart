import 'package:talex_platform/core/error/exceptions.dart';
import 'package:talex_platform/features/invitations/data/models/invitation_model.dart';
import 'package:talex_platform/features/invitations/domain/entities/invitation.dart';

abstract interface class InvitationDataSource {
  Future<List<InvitationModel>> getInvitations();
  Future<InvitationModel> createInvitation({
    required String personName,
    required String email,
    required String assessmentName,
    required DateTime expiresAt,
    String? message,
  });
  Future<InvitationModel> resendInvitation(String id);
  Future<InvitationModel> cancelInvitation(String id);
}

final class InMemoryInvitationDataSource implements InvitationDataSource {
  final List<InvitationModel> _items = [];

  @override
  Future<List<InvitationModel>> getInvitations() async =>
      List.unmodifiable(_items.reversed);

  @override
  Future<InvitationModel> createInvitation({
    required String personName,
    required String email,
    required String assessmentName,
    required DateTime expiresAt,
    String? message,
  }) async {
    if (_items.any(
      (item) =>
          item.email.toLowerCase() == email.toLowerCase() &&
          item.status == InvitationStatus.pending,
    )) {
      throw const ServerException(
        'Ya existe una invitación pendiente para este correo.',
      );
    }
    final now = DateTime.now();
    final item = InvitationModel(
      id: now.microsecondsSinceEpoch.toString(),
      personName: personName,
      email: email,
      assessmentName: assessmentName,
      expiresAt: expiresAt,
      status: InvitationStatus.pending,
      createdAt: now,
      message: message,
    );
    _items.add(item);
    return item;
  }

  @override
  Future<InvitationModel> resendInvitation(String id) async => _replace(
    id,
    (item) => item.copyWith(
      status: InvitationStatus.pending,
      expiresAt: DateTime.now().add(const Duration(days: 7)),
    ),
  );

  @override
  Future<InvitationModel> cancelInvitation(String id) async =>
      _replace(id, (item) => item.copyWith(status: InvitationStatus.cancelled));

  InvitationModel _replace(
    String id,
    InvitationModel Function(InvitationModel) update,
  ) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index < 0) throw const ServerException('No se encontró la invitación.');
    final updated = update(_items[index]);
    _items[index] = updated;
    return updated;
  }
}
