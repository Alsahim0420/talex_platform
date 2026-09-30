import 'package:talex_platform/features/admin/domain/entities/admin_entities.dart';

abstract final class AdminAlertEngine {
  static List<AdminAlert> from({
    required List<Company> companies,
    required List<TalentProcess> processes,
    required List<PersonEvaluation> people,
    required List<Deal> deals,
    DateTime? now,
  }) {
    final clock = now ?? DateTime.now();
    final alerts = <AdminAlert>[];
    for (final company in companies) {
      final last = company.lastActivityAt ?? company.createdAt;
      final idleDays = clock.difference(last).inDays;
      if (company.status == CompanyStatus.atRisk || idleDays >= 14) {
        alerts.add(
          AdminAlert(
            id: 'risk-${company.id}',
            type: AlertType.risk,
            priority: idleDays >= 21 ? AlertPriority.high : AlertPriority.medium,
            title: company.name,
            description:
                '${company.name} lleva $idleDays días sin actividad registrada.',
            suggestedAction: 'Revisar uso y contactar al responsable de cuenta.',
            createdAt: clock,
            entityName: company.name,
          ),
        );
      }
      if (company.startedEvaluations >= 5 &&
          company.completedEvaluations < company.startedEvaluations * 0.4) {
        alerts.add(
          AdminAlert(
            id: 'ops-${company.id}',
            type: AlertType.operational,
            priority: AlertPriority.high,
            title: company.name,
            description:
                'Hay ${company.startedEvaluations} evaluaciones iniciadas y '
                '${company.completedEvaluations} completadas.',
            suggestedAction: 'Revisar fricción de finalización en esta empresa.',
            createdAt: clock,
            entityName: company.name,
          ),
        );
      }
      if (company.status == CompanyStatus.active &&
          idleDays <= 7 &&
          company.completedEvaluations >= 8) {
        alerts.add(
          AdminAlert(
            id: 'opp-${company.id}',
            type: AlertType.opportunity,
            priority: AlertPriority.medium,
            title: company.name,
            description:
                '${company.name} tiene alta utilización reciente y podría expandir procesos.',
            suggestedAction: 'Explorar un proceso adicional o un plan superior.',
            createdAt: clock,
            entityName: company.name,
          ),
        );
      }
    }
    for (final deal in deals) {
      if (deal.stage != DealStage.client &&
          clock.difference(deal.updatedAt).inDays >= 7) {
        alerts.add(
          AdminAlert(
            id: 'deal-${deal.id}',
            type: AlertType.commercial,
            priority: AlertPriority.high,
            title: deal.companyName,
            description:
                'Oportunidad en ${_stage(deal.stage)} sin seguimiento reciente.',
            suggestedAction: deal.nextAction ?? 'Registrar la próxima acción comercial.',
            createdAt: clock,
            entityName: deal.companyName,
          ),
        );
      }
    }
    final started = people
        .where(
          (item) =>
              item.status == EvaluationStatus.started ||
              item.status == EvaluationStatus.inProgress,
        )
        .length;
    final completed = people
        .where((item) => item.status == EvaluationStatus.completed)
        .length;
    if (started >= 8 && completed < started * 0.35) {
      alerts.add(
        AdminAlert(
          id: 'global-completion',
          type: AlertType.operational,
          priority: AlertPriority.medium,
          title: 'Finalización global',
          description:
              'TaleX tiene $started evaluaciones abiertas y solo $completed completadas.',
          suggestedAction: 'Revisar el embudo de evaluaciones en Analytics.',
          createdAt: clock,
        ),
      );
    }
    alerts.sort((a, b) => b.priority.index.compareTo(a.priority.index));
    return alerts;
  }

  static String _stage(DealStage stage) => switch (stage) {
    DealStage.prospect => 'prospecto',
    DealStage.contacted => 'contactado',
    DealStage.meeting => 'reunión',
    DealStage.proposal => 'propuesta',
    DealStage.negotiation => 'negociación',
    DealStage.client => 'cliente',
  };
}
