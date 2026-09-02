import 'package:flutter_test/flutter_test.dart';
import 'package:talex_platform/features/admin/data/datasources/admin_data_source.dart';
import 'package:talex_platform/features/admin/data/repositories/admin_repository_impl.dart';
import 'package:talex_platform/features/admin/domain/entities/admin_entities.dart';
import 'package:talex_platform/features/admin/domain/services/admin_alert_engine.dart';
import 'package:talex_platform/features/admin/domain/services/xebec_interpreter.dart';

void main() {
  test('alert engine stays silent without companies', () {
    expect(
      AdminAlertEngine.from(
        companies: const [],
        processes: const [],
        people: const [],
        deals: const [],
      ),
      isEmpty,
    );
  });

  test('alert engine flags idle companies from real dates', () {
    final company = Company(
      id: '1',
      name: 'Nexus',
      status: CompanyStatus.active,
      createdAt: DateTime(2026, 1, 1),
      lastActivityAt: DateTime(2026, 1, 1),
    );
    final alerts = AdminAlertEngine.from(
      companies: [company],
      processes: const [],
      people: const [],
      deals: const [],
      now: DateTime(2026, 1, 20),
    );
    expect(alerts.any((item) => item.type == AlertType.risk), isTrue);
    expect(alerts.first.description, contains('19'));
  });

  test('xebec does not invent companies', () {
    final answer = XebecInterpreter.answer(
      question: '¿Cómo está TaleX?',
      metrics: const AdminMetrics(),
      companies: const [],
      deals: const [],
      activity: const [],
      alerts: const [],
    );
    expect(answer.toLowerCase(), contains('todavía no'));
  });

  test('admin repository reads empty in-memory data as zeros', () async {
    final repository = AdminRepositoryImpl(InMemoryAdminDataSource());
    final dashboard = await repository.getDashboard();
    dashboard.fold((failure) => fail(failure.message), (data) {
      expect(data.metrics.totalCompanies, 0);
      expect(data.activity, isEmpty);
      expect(data.alerts, isEmpty);
    });
  });

  test('creating a company is reflected in dashboard metrics', () async {
    final source = InMemoryAdminDataSource();
    final repository = AdminRepositoryImpl(source);
    await repository.createCompany(name: 'Acme', status: CompanyStatus.active);
    final dashboard = await repository.getDashboard();
    dashboard.fold((failure) => fail(failure.message), (data) {
      expect(data.metrics.totalCompanies, 1);
      expect(data.metrics.activeCompanies, 1);
    });
  });
}
