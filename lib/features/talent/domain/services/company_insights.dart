import 'package:talex_platform/features/talent/domain/entities/talent_entities.dart';

class CompanyInsights {
  CompanyInsights(this.snapshot, {DateTime? now}) : now = now ?? DateTime.now();

  final TalentSnapshot snapshot;
  final DateTime now;

  List<TalentCandidate> get recent {
    final items = [...snapshot.candidates]
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return items.take(5).toList();
  }

  List<TalentCandidate> get readyToReview => snapshot.candidates
      .where(
        (item) =>
            item.evaluationCompleted &&
            (item.processStatus == CandidateProcessStatus.pending ||
                item.processStatus == CandidateProcessStatus.inReview ||
                item.processStatus == CandidateProcessStatus.completed),
      )
      .toList();

  int get pendingToStart => snapshot.candidates
      .where((item) => item.processStatus == CandidateProcessStatus.pending)
      .length;

  List<TalentCandidate> get stalled => snapshot.candidates
      .where(
        (item) =>
            item.processStatus == CandidateProcessStatus.inProgress &&
            now.difference(item.updatedAt) >= const Duration(hours: 24),
      )
      .toList();
}
