part of 'admin_bloc.dart';

sealed class AdminEvent extends Equatable {
  const AdminEvent();
  @override
  List<Object?> get props => [];
}

class AdminSectionSelected extends AdminEvent {
  const AdminSectionSelected(this.section);
  final AdminSection section;
  @override
  List<Object?> get props => [section];
}

class AdminDashboardRequested extends AdminEvent {
  const AdminDashboardRequested();
}

class AdminCompaniesRequested extends AdminEvent {
  const AdminCompaniesRequested({this.query = '', this.status});
  final String query;
  final CompanyStatus? status;
  @override
  List<Object?> get props => [query, status];
}

class AdminCompanyOpened extends AdminEvent {
  const AdminCompanyOpened(this.id);
  final String id;
  @override
  List<Object?> get props => [id];
}

class AdminCompanyClosed extends AdminEvent {
  const AdminCompanyClosed();
}

class AdminProcessesRequested extends AdminEvent {
  const AdminProcessesRequested({this.query = '', this.companyId, this.status});
  final String query;
  final String? companyId;
  final ProcessStatus? status;
  @override
  List<Object?> get props => [query, companyId, status];
}

class AdminPeopleRequested extends AdminEvent {
  const AdminPeopleRequested({this.query = '', this.companyId, this.status});
  final String query;
  final String? companyId;
  final EvaluationStatus? status;
  @override
  List<Object?> get props => [query, companyId, status];
}

class AdminAffinityRequested extends AdminEvent {
  const AdminAffinityRequested({this.companyId});
  final String? companyId;
  @override
  List<Object?> get props => [companyId];
}

class AdminDealsRequested extends AdminEvent {
  const AdminDealsRequested({this.query = '', this.stage});
  final String query;
  final DealStage? stage;
  @override
  List<Object?> get props => [query, stage];
}

class AdminSalesRequested extends AdminEvent {
  const AdminSalesRequested({this.period});
  final AnalyticsPeriod? period;
  @override
  List<Object?> get props => [period];
}

class AdminAnalyticsRequested extends AdminEvent {
  const AdminAnalyticsRequested({this.period, this.from, this.to});
  final AnalyticsPeriod? period;
  final DateTime? from, to;
  @override
  List<Object?> get props => [period, from, to];
}

class AdminAlertsRequested extends AdminEvent {
  const AdminAlertsRequested();
}

class AdminUsersRequested extends AdminEvent {
  const AdminUsersRequested();
}

class AdminXebecAsked extends AdminEvent {
  const AdminXebecAsked(this.question);
  final String question;
  @override
  List<Object?> get props => [question];
}

class AdminCompanyCreated extends AdminEvent {
  const AdminCompanyCreated({
    required this.name,
    required this.status,
    this.plan,
  });
  final String name;
  final CompanyStatus status;
  final String? plan;
  @override
  List<Object?> get props => [name, status, plan];
}

class AdminProcessCreated extends AdminEvent {
  const AdminProcessCreated({required this.companyId, required this.name});
  final String companyId, name;
  @override
  List<Object?> get props => [companyId, name];
}

class AdminPersonCreated extends AdminEvent {
  const AdminPersonCreated({
    required this.companyId,
    required this.processId,
    required this.displayName,
    required this.status,
    this.affinityScore,
  });
  final String companyId, processId, displayName;
  final EvaluationStatus status;
  final double? affinityScore;
  @override
  List<Object?> get props => [companyId, processId, displayName, status, affinityScore];
}

class AdminDealCreated extends AdminEvent {
  const AdminDealCreated({
    required this.companyId,
    required this.stage,
    this.estimatedValue,
    this.ownerName,
    this.nextAction,
  });
  final String companyId;
  final DealStage stage;
  final double? estimatedValue;
  final String? ownerName, nextAction;
  @override
  List<Object?> get props => [companyId, stage, estimatedValue, ownerName, nextAction];
}

class AdminSaleCreated extends AdminEvent {
  const AdminSaleCreated({
    required this.companyId,
    required this.amount,
    this.product,
    this.recurring = false,
  });
  final String companyId;
  final double amount;
  final String? product;
  final bool recurring;
  @override
  List<Object?> get props => [companyId, amount, product, recurring];
}

class AdminUserRoleUpdated extends AdminEvent {
  const AdminUserRoleUpdated({required this.userId, required this.role});
  final String userId, role;
  @override
  List<Object?> get props => [userId, role];
}
