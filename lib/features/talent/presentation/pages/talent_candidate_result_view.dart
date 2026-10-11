import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talex_platform/core/constants/app_colors.dart';
import 'package:talex_platform/core/di/injection.dart';
import 'package:talex_platform/core/services/notification_service.dart';
import 'package:talex_platform/core/services/pdf_saver.dart';
import 'package:talex_platform/core/widgets/affinity_badge.dart';
import 'package:talex_platform/core/widgets/content_width.dart';
import 'package:talex_platform/features/admin/presentation/widgets/admin_widgets.dart';
import 'package:talex_platform/features/talent/data/services/candidate_report_pdf.dart';
import 'package:talex_platform/features/talent/domain/entities/talent_entities.dart';
import 'package:talex_platform/features/talent/presentation/bloc/talent_bloc.dart';
import 'package:talex_platform/features/talent/presentation/company_options.dart';
import 'package:talex_platform/features/talent/presentation/pages/talent_views.dart';
import 'package:talex_platform/features/talent/presentation/widgets/talent_dialogs.dart';
import 'package:talex_platform/l10n/l10n.dart';

class TalentCandidateResultView extends StatelessWidget {
  const TalentCandidateResultView({super.key, required this.report});
  final CandidateReport report;

  Future<void> _download(BuildContext context) async {
    final l10n = context.l10n;
    final bytes = await const CandidateReportPdf().build(
      l10n: l10n,
      report: report,
      processLabel: processStatusLabel(context, report.candidate.processStatus),
      affinityLabel: (level) => affinityWord(context, level),
    );
    final name = report.candidate.displayName?.trim().isNotEmpty == true
        ? report.candidate.displayName!
        : report.candidate.email;
    savePdfBytes(bytes, 'talex-${name.replaceAll(' ', '_')}.pdf');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final candidate = report.candidate;
    final labels = AdminLabels(context);
    final document = candidate.documentNumber.trim();
    final masked = document.length <= 4
        ? '••••'
        : '••••${document.substring(document.length - 4)}';
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: ContentWidth(
        maxWidth: 760,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () => context.read<TalentBloc>().add(
                  const TalentCandidateClosed(),
                ),
                icon: const Icon(Icons.arrow_back),
                label: Text(l10n.backToResults),
              ),
            ),
            AdminPageHeader(
              title: candidate.displayName?.trim().isNotEmpty == true
                  ? candidate.displayName!
                  : candidate.email,
              subtitle: l10n.candidateResultTitle,
              actions: [
                OutlinedButton.icon(
                  onPressed: () => showEditCandidateDialog(context, candidate),
                  icon: const Icon(Icons.edit_outlined),
                  label: Text(l10n.editCandidate),
                ),
                OutlinedButton.icon(
                  onPressed: () => showDeleteCandidateDialog(context, candidate),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red.shade700,
                  ),
                  icon: const Icon(Icons.delete_outline),
                  label: Text(l10n.deleteCandidate),
                ),
                FilledButton.icon(
                  onPressed: () async {
                    try {
                      await _download(context);
                    } catch (_) {
                      if (context.mounted) {
                        getIt<NotificationService>().error(l10n.errorUnexpected);
                      }
                    }
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primaryButton,
                  ),
                  icon: const Icon(Icons.picture_as_pdf_outlined),
                  label: Text(l10n.downloadPdf),
                ),
              ],
            ),
            const SizedBox(height: 20),
            AdminPanel(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                children: [
                  Text('${l10n.emailAddress}: ${candidate.email}'),
                  const SizedBox(height: 8),
                  Text('${l10n.documentNumber}: $masked'),
                  const SizedBox(height: 8),
                  Text('${l10n.vacancy}: ${candidate.vacancyName}'),
                  if (report.company != null) ...[
                    const SizedBox(height: 8),
                    Text('${l10n.companyName}: ${report.company!.name}'),
                  ],
                  const SizedBox(height: 8),
                  Text(
                    '${l10n.lastActivity}: ${labels.date(candidate.updatedAt)}',
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${l10n.candidateProcessStatus}: ${processStatusLabel(context, candidate.processStatus)}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            _AffinityCard(
              title: l10n.affinityWithCompany,
              level: candidate.companyAffinity,
              explanation: affinityMockExplanation(
                l10n,
                candidate.companyAffinity,
                forCompany: true,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.affinityMockNote,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.muted,
                fontSize: 13,
                height: 1.4,
              ),
            ),
            if (report.answers.isNotEmpty) ...[
              const SizedBox(height: 24),
              Text(
                l10n.fullSummaryTitle,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              for (final id in AssessmentCatalog.allIds)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: AdminPanel(
                    child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          assessmentQuestionLabel(l10n, id),
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          report.answers[id] == null
                              ? l10n.noData
                              : assessmentAnswerLabel(l10n, id, report.answers[id]!),
                        ),
                      ],
                    ),
                    ),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class _AffinityCard extends StatelessWidget {
  const _AffinityCard({
    required this.title,
    required this.level,
    required this.explanation,
  });
  final String title;
  final AffinityLevel level;
  final String explanation;

  @override
  Widget build(BuildContext context) {
    return AdminPanel(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            AffinityBadge(level),
            const SizedBox(height: 8),
            Text(
              explanation,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.subtitle, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
