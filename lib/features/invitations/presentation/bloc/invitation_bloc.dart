import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talex_platform/core/error/failure.dart';
import 'package:talex_platform/features/invitations/domain/entities/invitation.dart';
import 'package:talex_platform/features/invitations/domain/usecases/invitation_usecases.dart';

part 'invitation_event.dart';
part 'invitation_state.dart';
part 'invitation_bloc.g.dart';

class InvitationBloc extends Bloc<InvitationEvent, InvitationState> {
  InvitationBloc({
    required GetInvitations getInvitations,
    required CreateInvitation createInvitation,
    required ResendInvitation resendInvitation,
    required CancelInvitation cancelInvitation,
  }) : _getInvitations = getInvitations,
       _createInvitation = createInvitation,
       _resendInvitation = resendInvitation,
       _cancelInvitation = cancelInvitation,
       super(const InvitationState()) {
    on<InvitationsRequested>(_load);
    on<InvitationCreated>(_create);
    on<InvitationResent>(_resend);
    on<InvitationCancelled>(_cancel);
  }
  final GetInvitations _getInvitations;
  final CreateInvitation _createInvitation;
  final ResendInvitation _resendInvitation;
  final CancelInvitation _cancelInvitation;

  Future<void> _load(
    InvitationsRequested event,
    Emitter<InvitationState> emit,
  ) async {
    emit(
      state.copyWith(
        status: InvitationViewStatus.loading,
        failure: null,
        operation: null,
      ),
    );
    final result = await _getInvitations();
    emit(
      result.fold(
        (failure) => state.copyWith(
          status: InvitationViewStatus.failure,
          failure: failure,
        ),
        (items) => state.copyWith(
          status: InvitationViewStatus.success,
          invitations: items,
          failure: null,
        ),
      ),
    );
  }

  Future<void> _create(
    InvitationCreated event,
    Emitter<InvitationState> emit,
  ) async {
    emit(
      state.copyWith(
        status: InvitationViewStatus.submitting,
        failure: null,
        operation: null,
      ),
    );
    final result = await _createInvitation(
      CreateInvitationParams(
        personName: event.personName,
        email: event.email,
        assessmentName: event.assessmentName,
        expiresAt: event.expiresAt,
        message: event.message,
      ),
    );
    await result.fold(
      (failure) async => emit(
        state.copyWith(status: InvitationViewStatus.failure, failure: failure),
      ),
      (_) async {
        final refreshed = await _getInvitations();
        emit(
          refreshed.fold(
            (failure) => state.copyWith(
              status: InvitationViewStatus.failure,
              failure: failure,
            ),
            (items) => state.copyWith(
              status: InvitationViewStatus.success,
              invitations: items,
              operation: InvitationOperation.created,
              failure: null,
            ),
          ),
        );
      },
    );
  }

  Future<void> _resend(
    InvitationResent event,
    Emitter<InvitationState> emit,
  ) async => _mutate(
    () => _resendInvitation(event.id),
    InvitationOperation.resent,
    emit,
  );
  Future<void> _cancel(
    InvitationCancelled event,
    Emitter<InvitationState> emit,
  ) async => _mutate(
    () => _cancelInvitation(event.id),
    InvitationOperation.cancelled,
    emit,
  );

  Future<void> _mutate(
    Future<dynamic> Function() action,
    InvitationOperation operation,
    Emitter<InvitationState> emit,
  ) async {
    emit(
      state.copyWith(
        status: InvitationViewStatus.submitting,
        failure: null,
        operation: null,
      ),
    );
    final result = await action();
    await result.fold(
      (Failure failure) async => emit(
        state.copyWith(status: InvitationViewStatus.failure, failure: failure),
      ),
      (_) async {
        final refreshed = await _getInvitations();
        emit(
          refreshed.fold(
            (failure) => state.copyWith(
              status: InvitationViewStatus.failure,
              failure: failure,
            ),
            (items) => state.copyWith(
              status: InvitationViewStatus.success,
              invitations: items,
              operation: operation,
              failure: null,
            ),
          ),
        );
      },
    );
  }
}
