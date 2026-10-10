import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talex_platform/core/auth/user_role.dart';
import 'package:talex_platform/core/error/failure.dart';
import 'package:talex_platform/features/talent/domain/entities/talent_entities.dart';
import 'package:talex_platform/features/talent/domain/repositories/talent_repository.dart';

part 'talent_event.dart';
part 'talent_state.dart';

class TalentBloc extends Bloc<TalentEvent, TalentState> {
  TalentBloc({required TalentRepository repository})
    : _repository = repository,
      super(const TalentState()) {
    on<TalentLoaded>(_onLoad);
    on<TalentSectionSelected>(_onSection);
    on<TalentProfileSaved>(_onSaveProfile);
    on<TalentVacancyCreated>(_onVacancy);
    on<TalentRespondentCreated>(_onRespondent);
    on<TalentRecruiterInvited>(_onInvite);
    on<TalentCandidateStatusUpdated>(_onStatus);
    on<TalentRespondentSessionLoaded>(_onRespondentSession);
    on<TalentAnswerSaved>(_onAnswer);
    on<TalentEvaluationCompleted>(_onComplete);
    on<TalentPasswordChanged>(_onPassword);
    on<TalentCompanyDnaConfirmed>(_onDnaConfirmed);
    on<TalentFilterChanged>(_onFilter);
    on<TalentAssessmentKindSelected>(_onAssessmentKind);
    on<TalentCandidateOpened>(_onCandidateOpened);
    on<TalentCandidateClosed>(_onCandidateClosed);
    on<TalentCandidateUpdated>(_onCandidateUpdated);
    on<TalentCandidateDeleted>(_onCandidateDeleted);
    on<TalentDnaOptionDeleted>(_onDnaOptionDeleted);
  }

  final TalentRepository _repository;

  Future<void> _onLoad(TalentLoaded event, Emitter<TalentState> emit) async {
    emit(state.copyWith(status: TalentViewStatus.loading, companyId: event.companyId));
    final result = await _repository.loadCompany(event.companyId);
    result.fold(
      (failure) => emit(state.copyWith(status: TalentViewStatus.failure, failure: failure)),
      (snapshot) => emit(
        state.copyWith(
          status: TalentViewStatus.success,
          snapshot: snapshot,
          generatedPin: null,
          respondentInvited: false,
          failure: null,
        ),
      ),
    );
  }

  Future<void> _onSection(
    TalentSectionSelected event,
    Emitter<TalentState> emit,
  ) async {
    emit(state.copyWith(section: event.section));
  }

  Future<void> _onSaveProfile(
    TalentProfileSaved event,
    Emitter<TalentState> emit,
  ) async {
    final result = await _repository.saveCompanyProfile(event.profile);
    await result.fold(
      (failure) async => emit(state.copyWith(failure: failure)),
      (_) async => add(TalentLoaded(event.profile.id)),
    );
  }

  Future<void> _onVacancy(
    TalentVacancyCreated event,
    Emitter<TalentState> emit,
  ) async {
    final result = await _repository.createVacancy(event.vacancy);
    await result.fold(
      (failure) async => emit(state.copyWith(failure: failure)),
      (_) async => add(TalentLoaded(event.vacancy.companyId)),
    );
  }

  Future<void> _onRespondent(
    TalentRespondentCreated event,
    Emitter<TalentState> emit,
  ) async {
    final result = await _repository.createRespondent(
      companyId: event.companyId,
      vacancyId: event.vacancyId,
      email: event.email,
      documentNumber: event.documentNumber,
      displayName: event.displayName,
    );
    await result.fold(
      (failure) async => emit(state.copyWith(failure: failure)),
      (password) async {
        emit(state.copyWith(respondentInvited: true, failure: null));
        add(TalentLoaded(event.companyId));
      },
    );
  }

  Future<void> _onInvite(
    TalentRecruiterInvited event,
    Emitter<TalentState> emit,
  ) async {
    final result = await _repository.inviteRecruiter(
      companyId: event.companyId,
      email: event.email,
      firstName: event.firstName,
      lastName: event.lastName,
      role: event.role,
    );
    await result.fold(
      (failure) async => emit(state.copyWith(failure: failure)),
      (pin) async {
        emit(state.copyWith(generatedPin: pin, failure: null));
        add(TalentLoaded(event.companyId));
      },
    );
  }

  Future<void> _onStatus(
    TalentCandidateStatusUpdated event,
    Emitter<TalentState> emit,
  ) async {
    final result = await _repository.updateCandidateStatus(
      candidateId: event.candidateId,
      status: event.status,
    );
    await result.fold(
      (failure) async => emit(state.copyWith(failure: failure)),
      (_) async {
        if (state.companyId != null) add(TalentLoaded(state.companyId!));
      },
    );
  }

  Future<void> _onRespondentSession(
    TalentRespondentSessionLoaded event,
    Emitter<TalentState> emit,
  ) async {
    emit(state.copyWith(status: TalentViewStatus.loading));
    final result = await _repository.loadRespondentSession();
    result.fold(
      (failure) => emit(state.copyWith(status: TalentViewStatus.failure, failure: failure)),
      (session) => emit(
        state.copyWith(
          status: TalentViewStatus.success,
          respondentSession: session,
          failure: null,
        ),
      ),
    );
  }

  Future<void> _onAnswer(
    TalentAnswerSaved event,
    Emitter<TalentState> emit,
  ) async {
    final current = Map<String, int>.from(state.respondentSession?.answers ?? {});
    current[event.questionId] = event.value;
    final session = state.respondentSession;
    if (session != null) {
      emit(
        state.copyWith(
          respondentSession: RespondentSession(
            candidate: session.candidate,
            answers: current,
            company: session.company,
          ),
        ),
      );
    }
    await _repository.saveAnswer(
      candidateId: event.candidateId,
      questionId: event.questionId,
      value: event.value,
    );
  }

  Future<void> _onComplete(
    TalentEvaluationCompleted event,
    Emitter<TalentState> emit,
  ) async {
    final result = await _repository.completeEvaluation(
      event.candidateId,
      locale: event.locale,
    );
    await result.fold(
      (failure) async => emit(state.copyWith(failure: failure)),
      (_) async => add(const TalentRespondentSessionLoaded()),
    );
  }

  Future<void> _onPassword(
    TalentPasswordChanged event,
    Emitter<TalentState> emit,
  ) async {
    final result = await _repository.changePassword(event.password);
    result.fold(
      (failure) => emit(state.copyWith(failure: failure)),
      (_) => emit(state.copyWith(passwordChanged: true, failure: null)),
    );
  }

  Future<void> _onDnaConfirmed(
    TalentCompanyDnaConfirmed event,
    Emitter<TalentState> emit,
  ) async {
    final result = await _repository.saveCompanyProfile(event.profile);
    result.fold(
      (failure) => emit(state.copyWith(failure: failure)),
      (_) => emit(state.copyWith(dnaConfirmed: true, failure: null)),
    );
  }

  Future<void> _onFilter(
    TalentFilterChanged event,
    Emitter<TalentState> emit,
  ) async {
    emit(
      TalentState(
        status: state.status,
        section: state.section,
        companyId: state.companyId,
        snapshot: state.snapshot,
        respondentSession: state.respondentSession,
        generatedPin: state.generatedPin,
        respondentInvited: state.respondentInvited,
        failure: state.failure,
        passwordChanged: state.passwordChanged,
        dnaConfirmed: state.dnaConfirmed,
        vacancyFilterId: event.clearVacancy
            ? null
            : (event.vacancyId ?? state.vacancyFilterId),
        processFilter: event.clearProcess
            ? null
            : (event.processStatus ?? state.processFilter),
        affinityFilter: event.clearAffinity
            ? null
            : (event.affinity ?? state.affinityFilter),
        candidateReport: state.candidateReport,
      ),
    );
  }

  Future<void> _onAssessmentKind(
    TalentAssessmentKindSelected event,
    Emitter<TalentState> emit,
  ) async {
    final session = state.respondentSession;
    if (session != null) {
      emit(
        state.copyWith(
          respondentSession: RespondentSession(
            candidate: TalentCandidate(
              id: session.candidate.id,
              companyId: session.candidate.companyId,
              vacancyId: session.candidate.vacancyId,
              vacancyName: session.candidate.vacancyName,
              email: session.candidate.email,
              documentNumber: session.candidate.documentNumber,
              displayName: session.candidate.displayName,
              processStatus: session.candidate.processStatus,
              companyAffinity: session.candidate.companyAffinity,
              vacancyAffinity: session.candidate.vacancyAffinity,
              evaluationCompleted: session.candidate.evaluationCompleted,
              assessmentKind: event.kind,
              updatedAt: session.candidate.updatedAt,
            ),
            answers: session.answers,
            company: session.company,
          ),
        ),
      );
    }
    await _repository.saveAssessmentKind(
      candidateId: event.candidateId,
      kind: event.kind,
    );
  }

  Future<void> _onCandidateOpened(
    TalentCandidateOpened event,
    Emitter<TalentState> emit,
  ) async {
    final result = await _repository.loadCandidateReport(event.candidateId);
    result.fold(
      (failure) => emit(state.copyWith(failure: failure)),
      (report) => emit(state.copyWith(candidateReport: report, failure: null)),
    );
  }

  Future<void> _onCandidateClosed(
    TalentCandidateClosed event,
    Emitter<TalentState> emit,
  ) async {
    emit(state.copyWith(clearCandidateReport: true));
  }

  Future<void> _onCandidateUpdated(
    TalentCandidateUpdated event,
    Emitter<TalentState> emit,
  ) async {
    final result = await _repository.updateCandidate(
      candidateId: event.candidateId,
      displayName: event.displayName,
      documentNumber: event.documentNumber,
      vacancyId: event.vacancyId,
    );
    await result.fold(
      (failure) async => emit(state.copyWith(failure: failure)),
      (_) async {
        final report = await _repository.loadCandidateReport(event.candidateId);
        report.fold(
          (failure) => emit(state.copyWith(failure: failure)),
          (value) => emit(
            state.copyWith(
              candidateReport: value,
              candidateNotice: TalentCandidateNotice.updated,
              failure: null,
            ),
          ),
        );
        if (state.companyId != null) add(TalentLoaded(state.companyId!));
      },
    );
  }

  Future<void> _onCandidateDeleted(
    TalentCandidateDeleted event,
    Emitter<TalentState> emit,
  ) async {
    final result = await _repository.deleteCandidate(event.candidateId);
    await result.fold(
      (failure) async => emit(state.copyWith(failure: failure)),
      (_) async {
        emit(
          state.copyWith(
            clearCandidateReport: true,
            candidateNotice: TalentCandidateNotice.deleted,
            failure: null,
          ),
        );
        if (state.companyId != null) add(TalentLoaded(state.companyId!));
      },
    );
  }

  Future<void> _onDnaOptionDeleted(
    TalentDnaOptionDeleted event,
    Emitter<TalentState> emit,
  ) async {
    final result = await _repository.deleteDnaCatalogOption(
      type: event.type,
      label: event.label,
    );
    await result.fold(
      (failure) async => emit(state.copyWith(failure: failure)),
      (_) async {
        if (state.companyId != null) add(TalentLoaded(state.companyId!));
      },
    );
  }
}
