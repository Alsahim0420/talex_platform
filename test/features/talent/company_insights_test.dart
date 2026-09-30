import 'package:flutter_test/flutter_test.dart';
import 'package:talex_platform/features/talent/domain/entities/talent_entities.dart';
import 'package:talex_platform/features/talent/domain/services/company_insights.dart';

TalentCandidate candidate({
  required String id,
  required CandidateProcessStatus status,
  required DateTime updatedAt,
  bool evaluationCompleted = false,
  String name = '',
}) => TalentCandidate(
  id: id,
  companyId: 'c1',
  vacancyId: 'v1',
  vacancyName: 'Analista',
  email: '$id@empresa.com',
  documentNumber: id,
  processStatus: status,
  updatedAt: updatedAt,
  displayName: name,
  evaluationCompleted: evaluationCompleted,
);

void main() {
  final now = DateTime(2026, 9, 1, 12);

  test('recent returns the five latest candidates', () {
    final items = [
      for (var i = 0; i < 7; i++)
        candidate(
          id: '$i',
          status: CandidateProcessStatus.pending,
          updatedAt: now.subtract(Duration(hours: i)),
        ),
    ];
    final insights = CompanyInsights(
      TalentSnapshot(candidates: items),
      now: now,
    );
    expect(insights.recent.map((item) => item.id), ['0', '1', '2', '3', '4']);
  });

  test('readyToReview includes completed evaluations awaiting follow-up', () {
    final insights = CompanyInsights(
      TalentSnapshot(
        candidates: [
          candidate(
            id: 'ready',
            status: CandidateProcessStatus.inReview,
            updatedAt: now,
            evaluationCompleted: true,
            name: 'Ana',
          ),
          candidate(
            id: 'open',
            status: CandidateProcessStatus.pending,
            updatedAt: now,
          ),
        ],
      ),
      now: now,
    );
    expect(insights.readyToReview.map((item) => item.id), ['ready']);
    expect(insights.pendingToStart, 1);
  });

  test('stalled flags in-progress assessments older than 24 hours', () {
    final insights = CompanyInsights(
      TalentSnapshot(
        candidates: [
          candidate(
            id: 'stalled',
            status: CandidateProcessStatus.inProgress,
            updatedAt: now.subtract(const Duration(hours: 25)),
          ),
          candidate(
            id: 'fresh',
            status: CandidateProcessStatus.inProgress,
            updatedAt: now.subtract(const Duration(hours: 2)),
          ),
        ],
      ),
      now: now,
    );
    expect(insights.stalled.map((item) => item.id), ['stalled']);
  });
}
