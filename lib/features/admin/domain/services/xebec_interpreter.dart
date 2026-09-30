import 'package:talex_platform/features/admin/domain/entities/admin_entities.dart';

abstract final class XebecInterpreter {
  static String answer({
    required String question,
    required AdminMetrics metrics,
    required List<Company> companies,
    required List<Deal> deals,
    required List<ActivityEvent> activity,
    required List<AdminAlert> alerts,
    DateTime? now,
  }) {
    final query = question.trim().toLowerCase();
    if (query.isEmpty) {
      return 'Pregúntame por el estado de TaleX, empresas en riesgo u oportunidades.';
    }
    final clock = now ?? DateTime.now();
    if (_matches(query, ['cómo está', 'como esta', 'estado', 'resumen'])) {
      return _overview(metrics, alerts);
    }
    if (_matches(query, ['atención', 'atencion', 'requieren', 'prioriz'])) {
      return _attention(alerts);
    }
    if (_matches(query, ['más activa', 'mas activa', 'más activa', 'activa'])) {
      return _mostActive(companies);
    }
    if (_matches(query, ['evaluaciones', 'semana', 'complet'])) {
      return 'Se completaron ${metrics.completedEvaluations} evaluaciones en el periodo visible. '
          'Las afinidades detectadas son ${metrics.affinitiesDetected}.';
    }
    if (_matches(query, ['riesgo', 'inactiv'])) {
      return _risk(companies, clock);
    }
    if (_matches(query, ['oportun', 'pipeline', 'comercial'])) {
      return _pipeline(deals);
    }
    if (_matches(query, ['expandir', 'expansión', 'expansion'])) {
      final expansion = alerts.where((item) => item.type == AlertType.opportunity);
      if (expansion.isEmpty) {
        return 'Aún no hay señales de expansión calculadas con la actividad actual.';
      }
      return expansion.map((item) => item.description).join(' ');
    }
    if (_matches(query, ['hoy', 'ocurrió', 'ocurrio'])) {
      return _today(activity, clock);
    }
    if (_matches(query, ['vend', 'mrr', 'ingreso'])) {
      return 'Ventas del periodo: ${_money(metrics.periodSales)}. '
          'MRR recurrente registrado: ${_money(metrics.mrr)}. '
          'Empresas totales: ${metrics.totalCompanies}.';
    }
    return _overview(metrics, alerts);
  }

  static bool _matches(String query, List<String> keys) =>
      keys.any(query.contains);

  static String _overview(AdminMetrics metrics, List<AdminAlert> alerts) {
    if (metrics.totalCompanies == 0) {
      return 'TaleX todavía no tiene empresas registradas en el centro de mando. '
          'Cuando existan compañías, procesos y evaluaciones, podré resumir el estado real.';
    }
    final attention = alerts.where((item) => item.priority == AlertPriority.high);
    return 'TaleX tiene ${metrics.totalCompanies} empresas '
        '(${metrics.activeCompanies} activas). '
        '${metrics.evaluatedPeople} personas fueron evaluadas y '
        '${metrics.completedEvaluations} evaluaciones están completadas. '
        '${attention.isEmpty ? 'No hay alertas de alta prioridad.' : 'Hay ${attention.length} alertas de alta prioridad.'}';
  }

  static String _attention(List<AdminAlert> alerts) {
    if (alerts.isEmpty) {
      return 'No hay empresas que requieran atención según la actividad registrada.';
    }
    return 'Prioriza: ${alerts.take(3).map((item) => item.title).join(', ')}.';
  }

  static String _mostActive(List<Company> companies) {
    if (companies.isEmpty) {
      return 'Todavía no hay empresas para comparar actividad.';
    }
    final ranked = [...companies]..sort(
      (a, b) => b.completedEvaluations.compareTo(a.completedEvaluations),
    );
    final top = ranked.first;
    if (top.completedEvaluations == 0) {
      return 'Ninguna empresa tiene evaluaciones completadas todavía.';
    }
    return 'La empresa más activa por evaluaciones completadas es ${top.name} '
        '(${top.completedEvaluations}).';
  }

  static String _risk(List<Company> companies, DateTime clock) {
    final risky = companies.where((company) {
      final last = company.lastActivityAt ?? company.createdAt;
      return company.status == CompanyStatus.atRisk ||
          clock.difference(last).inDays >= 14;
    }).toList();
    if (risky.isEmpty) {
      return 'No hay clientes en riesgo con los criterios actuales de inactividad.';
    }
    return 'En riesgo: ${risky.map((item) => item.name).join(', ')}.';
  }

  static String _pipeline(List<Deal> deals) {
    final open = deals.where((deal) => deal.stage != DealStage.client).toList();
    if (open.isEmpty) {
      return 'No hay oportunidades abiertas en el pipeline.';
    }
    final value = open.fold<double>(0, (acc, deal) => acc + (deal.estimatedValue ?? 0));
    return 'Hay ${open.length} oportunidades abiertas'
        '${value <= 0 ? '.' : ' por ${_money(value)} estimados.'}';
  }

  static String _today(List<ActivityEvent> activity, DateTime clock) {
    final today = activity.where(
      (item) =>
          item.createdAt.year == clock.year &&
          item.createdAt.month == clock.month &&
          item.createdAt.day == clock.day,
    );
    if (today.isEmpty) {
      return 'Hoy no hay actividad registrada todavía.';
    }
    return 'Hoy: ${today.map((item) => item.entityName).take(5).join(', ')}.';
  }

  static String _money(double value) => '\$${value.toStringAsFixed(0)}';
}
