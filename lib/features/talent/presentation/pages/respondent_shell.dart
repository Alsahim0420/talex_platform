import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talex_platform/core/constants/app_assets.dart';
import 'package:talex_platform/core/constants/app_colors.dart';
import 'package:talex_platform/core/constants/app_radii.dart';
import 'package:talex_platform/core/di/injection.dart';
import 'package:talex_platform/core/services/notification_service.dart';
import 'package:talex_platform/core/widgets/content_width.dart';
import 'package:talex_platform/core/widgets/language_selector.dart';
import 'package:talex_platform/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:talex_platform/features/talent/domain/entities/talent_entities.dart';
import 'package:talex_platform/features/talent/presentation/bloc/talent_bloc.dart';
import 'package:talex_platform/features/talent/presentation/company_options.dart';
import 'package:talex_platform/features/talent/presentation/pages/talent_password_page.dart';
import 'package:talex_platform/features/talent/presentation/talent_error_message.dart';
import 'package:talex_platform/l10n/l10n.dart';

class RespondentShell extends StatelessWidget {
  const RespondentShell({super.key, required this.mustChangePassword});
  final bool mustChangePassword;

  @override
  Widget build(BuildContext context) {
    if (mustChangePassword) return const TalentPasswordPage();
    return BlocListener<TalentBloc, TalentState>(
      listenWhen: (previous, current) => previous.failure != current.failure,
      listener: (context, state) {
        if (state.failure != null) {
          getIt<NotificationService>().error(
            talentErrorMessage(context.l10n, state.failure!.message),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.dashboardBackground,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          title: Image.asset(AppAssets.talexLogoHorizontal, height: 28),
          actions: [
            const LanguageSelector(compact: true),
            TextButton(
              onPressed: () => context.read<AuthBloc>().add(
                const AuthSignOutRequested(),
              ),
              child: Text(context.l10n.signOut),
            ),
          ],
        ),
        body: const RespondentSurveyView(),
      ),
    );
  }
}

class RespondentSurveyView extends StatefulWidget {
  const RespondentSurveyView({super.key});
  @override
  State<RespondentSurveyView> createState() => _RespondentSurveyViewState();
}

class _RespondentSurveyViewState extends State<RespondentSurveyView> {
  var _started = false;
  var _index = 0;
  final _picks = <String, int>{};

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final options = [
      l10n.likertStronglyDisagree,
      l10n.likertDisagree,
      l10n.likertNeutral,
      l10n.likertAgree,
      l10n.likertStronglyAgree,
    ];
    return BlocBuilder<TalentBloc, TalentState>(
      builder: (context, state) {
        if (state.status == TalentViewStatus.failure &&
            state.respondentSession == null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    talentErrorMessage(
                      l10n,
                      state.failure?.message ?? 'errorUnexpected',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () => context.read<TalentBloc>().add(
                      const TalentRespondentSessionLoaded(),
                    ),
                    child: Text(l10n.retry),
                  ),
                ],
              ),
            ),
          );
        }
        if (state.status == TalentViewStatus.loading ||
            state.respondentSession == null) {
          return const Center(child: CircularProgressIndicator());
        }
        final session = state.respondentSession!;
        if (session.candidate.evaluationCompleted) {
          return const _FinishedView();
        }
        if (!_started) {
          return _LandingView(
            session: session,
            onStart: () {
              setState(() => _started = true);
            },
          );
        }
        final ids = AssessmentCatalog.allIds;
        final questionId = ids[_index.clamp(0, ids.length - 1)];
        final selected = _picks[questionId] ?? session.answers[questionId];
        final complete = ids.every(
          (id) => (_picks[id] ?? session.answers[id]) != null,
        );
        return ContentWidth(
          maxWidth: 760,
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.questionProgress(_index + 1, ids.length),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.subtitle),
                ),
                const SizedBox(height: 12),
                LinearProgressIndicator(value: (_index + 1) / ids.length),
                const SizedBox(height: 24),
                Text(
                  assessmentQuestionLabel(l10n, questionId),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: ListView.separated(
                    itemCount: options.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 8),
                    itemBuilder: (context, optionIndex) {
                      final value = optionIndex + 1;
                      final active = selected == value;
                      return Material(
                        color: active
                            ? const Color(0xFFF0F6FF)
                            : Colors.white,
                        borderRadius: AppRadii.border,
                        child: InkWell(
                          borderRadius: AppRadii.border,
                          onTap: () {
                            setState(() => _picks[questionId] = value);
                            context.read<TalentBloc>().add(
                              TalentAnswerSaved(
                                candidateId: session.candidate.id,
                                questionId: questionId,
                                value: value,
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: AppRadii.border,
                              border: Border.all(
                                color: active
                                    ? AppColors.primaryButton
                                    : const Color(0xFFD1D1D6),
                              ),
                            ),
                            child: Text(
                              options[optionIndex],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: active
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                color: AppColors.ink,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: _index == 0
                          ? null
                          : () => setState(() => _index -= 1),
                      child: Text(l10n.goBack),
                    ),
                    const Spacer(),
                    if (_index == ids.length - 1)
                      FilledButton(
                        onPressed: complete
                            ? () => context.read<TalentBloc>().add(
                                TalentEvaluationCompleted(
                                  session.candidate.id,
                                  locale: Localizations.localeOf(
                                    context,
                                  ).languageCode,
                                ),
                              )
                            : null,
                        child: Text(l10n.finish),
                      )
                    else
                      FilledButton(
                        onPressed: selected == null
                            ? null
                            : () => setState(() => _index += 1),
                        child: Text(l10n.next),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _LandingView extends StatelessWidget {
  const _LandingView({required this.session, required this.onStart});
  final RespondentSession session;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final name = session.candidate.displayName?.trim().isNotEmpty == true
        ? session.candidate.displayName!
        : session.candidate.email;
    final company = session.company;
    final kind = session.candidate.assessmentKind;
    final total = AssessmentCatalog.allIds.length;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: ContentWidth(
        maxWidth: 720,
        child: Column(
          children: [
            Text(
              l10n.respondentHello(name.split(' ').first),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppRadii.border,
                border: Border.all(color: const Color(0xFFD1D1D6)),
              ),
              child: Column(
                children: [
                  Text(
                    l10n.assessmentKindLabel,
                    style: const TextStyle(color: AppColors.muted),
                  ),
                  const SizedBox(height: 8),
                  Chip(label: Text(l10n.assessmentKindAffinity)),
                  const SizedBox(height: 20),
                  if (company != null) ...[
                    Text(
                      l10n.sentByCompany,
                      style: const TextStyle(color: AppColors.muted),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      company.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.ink,
                      ),
                    ),
                    if (company.description?.trim().isNotEmpty == true) ...[
                      const SizedBox(height: 8),
                      Text(
                        company.description!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          height: 1.45,
                          color: AppColors.subtitle,
                        ),
                      ),
                    ],
                    const SizedBox(height: 16),
                  ],
                  Text(
                    session.candidate.vacancyName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.ink,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.respondentLikertHint,
                    textAlign: TextAlign.center,
                    style: const TextStyle(height: 1.45, color: AppColors.ink),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l10n.respondentDuration,
                    textAlign: TextAlign.center,
                    style: const TextStyle(height: 1.45, color: AppColors.ink),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.respondentQuestionCount(total),
                    textAlign: TextAlign.center,
                    style: const TextStyle(height: 1.45, color: AppColors.ink),
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: () {
                      if (kind != AssessmentKind.affinity) {
                        context.read<TalentBloc>().add(
                          TalentAssessmentKindSelected(
                            candidateId: session.candidate.id,
                            kind: AssessmentKind.affinity,
                          ),
                        );
                      }
                      onStart();
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primaryButton,
                      minimumSize: const Size.fromHeight(48),
                    ),
                    child: Text(l10n.startAssessment),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Image.asset(AppAssets.talexMarca, fit: BoxFit.fitWidth),
          ],
        ),
      ),
    );
  }
}

class _FinishedView extends StatelessWidget {
  const _FinishedView();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ContentWidth(
      maxWidth: 640,
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              l10n.assessmentFinishedTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 28),
            Image.asset(AppAssets.talexMarca, fit: BoxFit.fitWidth),
          ],
        ),
      ),
    );
  }
}
