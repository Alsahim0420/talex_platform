import 'package:flutter_test/flutter_test.dart';
import 'package:talex_platform/features/admin/data/datasources/assessment_question_data_source.dart';
import 'package:talex_platform/features/admin/domain/entities/assessment_question.dart';
import 'package:talex_platform/features/admin/domain/services/assessment_question_defaults.dart';
import 'package:talex_platform/features/admin/presentation/widgets/admin_question_dialogs.dart';

void main() {
  const all = AssessmentQuestionDefaults.all;

  test('base catalog holds the 48 questions of the three fronts', () {
    int count(AssessmentFront front) =>
        all.where((item) => item.front == front).length;
    expect(all, hasLength(48));
    expect(count(AssessmentFront.coreValues), 28);
    expect(count(AssessmentFront.needs), 12);
    expect(count(AssessmentFront.capabilities), 8);
    expect(all.map((item) => item.code).toSet(), hasLength(48));
    expect(all.map((item) => item.order), List.generate(48, (i) => i + 1));
  });

  test('pairs carry two statements and a time limit, experience does not', () {
    for (final question in all) {
      expect(question.options, hasLength(5));
      expect(question.statementA, isNotEmpty);
      expect(question.statementB.isNotEmpty, question.isPair);
      expect(question.dimensionB.isNotEmpty, question.isPair);
      expect(question.timeLimitSeconds, question.isPair ? 20 : null);
    }
  });

  test('questions survive the Firestore map round trip', () {
    for (final question in all) {
      expect(
        assessmentQuestionFromMap(
          question.code,
          assessmentQuestionToMap(question),
        ),
        question,
      );
    }
  });

  test('new codes continue the numbering of their front', () {
    expect(suggestQuestionCode(AssessmentFront.coreValues, all), 'V29');
    expect(suggestQuestionCode(AssessmentFront.needs, all), 'N13');
    expect(suggestQuestionCode(AssessmentFront.capabilities, const []), 'C01');
  });
}
