import 'package:equatable/equatable.dart';

enum AffinityLevel { high, medium, low, unknown }

enum VacancyStatus { active, closed }

enum CandidateProcessStatus {
  pending,
  inProgress,
  completed,
  inReview,
  shortlisted,
  interview,
  finalist,
  hired,
  rejected,
}

enum InviteKind { recruiter, respondent }

enum AssessmentKind { affinity, fit }

bool isCompanyStaffInvite({String? kind, String? role}) =>
    kind != InviteKind.respondent.name && role != 'respondent';

AffinityLevel affinityLevelFromAverage(double? average) {
  if (average == null) return AffinityLevel.unknown;
  if (average >= 4) return AffinityLevel.high;
  if (average >= 3) return AffinityLevel.medium;
  return AffinityLevel.low;
}

abstract final class AssessmentCatalog {
  static const companyQuestionIds = ['c1', 'c2', 'c3', 'c4', 'c5'];
  static const vacancyQuestionIds = ['v1', 'v2', 'v3', 'v4', 'v5'];
  static List<String> get allIds => [...companyQuestionIds, ...vacancyQuestionIds];
}

class CompanyProfile extends Equatable {
  const CompanyProfile({
    required this.id,
    required this.name,
    this.nit,
    this.logoUrl,
    this.sector,
    this.size,
    this.city,
    this.country,
    this.region,
    this.website,
    this.description,
    this.values,
    this.culture,
    this.standoutPeople,
    this.soughtCharacteristics,
    this.customValues = const [],
    this.customCulture = const [],
    this.customStandout = const [],
    this.customAreas = const [],
  });
  final String id, name;
  final String? nit, logoUrl, sector, size, city, country, region, website, description;
  final String? values, culture, standoutPeople, soughtCharacteristics;
  final List<String> customValues, customCulture, customStandout, customAreas;
  bool get hasCompanyDna =>
      _filled(values) && _filled(culture) && _filled(standoutPeople);
  static bool _filled(String? value) => value != null && value.trim().isNotEmpty;
  @override
  List<Object?> get props => [
    id,
    name,
    nit,
    city,
    country,
    region,
    values,
    culture,
    standoutPeople,
    customValues,
    customCulture,
    customStandout,
    customAreas,
  ];
}

class Vacancy extends Equatable {
  const Vacancy({
    required this.id,
    required this.companyId,
    required this.name,
    required this.status,
    required this.createdAt,
    this.area,
    this.description,
    this.city,
    this.country,
    this.region,
    this.workMode,
    this.contractType,
    this.seniority,
    this.roleProfile,
  });
  final String id, companyId, name;
  final VacancyStatus status;
  final DateTime createdAt;
  final String? area, description, city, country, region, workMode, contractType, seniority, roleProfile;
  @override
  List<Object?> get props => [id, companyId, name, status];
}

class TalentCandidate extends Equatable {
  const TalentCandidate({
    required this.id,
    required this.companyId,
    required this.vacancyId,
    required this.vacancyName,
    required this.email,
    required this.documentNumber,
    required this.processStatus,
    required this.updatedAt,
    this.displayName,
    this.companyAffinity = AffinityLevel.unknown,
    this.vacancyAffinity = AffinityLevel.unknown,
    this.evaluationCompleted = false,
    this.assessmentKind,
  });
  final String id, companyId, vacancyId, vacancyName, email, documentNumber;
  final String? displayName;
  final CandidateProcessStatus processStatus;
  final AffinityLevel companyAffinity, vacancyAffinity;
  final bool evaluationCompleted;
  final AssessmentKind? assessmentKind;
  final DateTime updatedAt;
  @override
  List<Object?> get props => [id, email, processStatus, companyAffinity, vacancyAffinity];
}

class TeamMember extends Equatable {
  const TeamMember({
    required this.email,
    required this.role,
    required this.inviteUsed,
    this.displayName,
    this.isActive = true,
  });
  final String email, role;
  final String? displayName;
  final bool inviteUsed, isActive;
  @override
  List<Object?> get props => [email, role, inviteUsed];
}

class DnaCatalogEntry extends Equatable {
  const DnaCatalogEntry({
    required this.type,
    required this.labelEs,
    this.labelEn,
  });
  final String type;
  final String labelEs;
  final String? labelEn;
  String labelFor(String languageCode) {
    final english = labelEn?.trim();
    if (languageCode == 'en' && english != null && english.isNotEmpty) {
      return english;
    }
    return labelEs;
  }

  @override
  List<Object?> get props => [type, labelEs, labelEn];
}

class TalentSnapshot extends Equatable {
  const TalentSnapshot({
    this.profile,
    this.vacancies = const [],
    this.candidates = const [],
    this.team = const [],
    this.dnaCatalog = const [],
  });
  final CompanyProfile? profile;
  final List<Vacancy> vacancies;
  final List<TalentCandidate> candidates;
  final List<TeamMember> team;
  final List<DnaCatalogEntry> dnaCatalog;
  int get activeVacancies =>
      vacancies.where((item) => item.status == VacancyStatus.active).length;
  int get closedVacancies =>
      vacancies.where((item) => item.status == VacancyStatus.closed).length;
  int get pendingAssessments => candidates
      .where(
        (item) =>
            item.processStatus == CandidateProcessStatus.pending ||
            item.processStatus == CandidateProcessStatus.inProgress,
      )
      .length;
  int get completedAssessments =>
      candidates.where((item) => item.evaluationCompleted).length;
  int get highCount =>
      candidates.where((item) => item.companyAffinity == AffinityLevel.high).length;
  int get mediumCount =>
      candidates.where((item) => item.companyAffinity == AffinityLevel.medium).length;
  int get lowCount =>
      candidates.where((item) => item.companyAffinity == AffinityLevel.low).length;
  @override
  List<Object?> get props => [profile, vacancies, candidates, team, dnaCatalog];
}

class RespondentSession extends Equatable {
  const RespondentSession({
    required this.candidate,
    this.answers = const {},
    this.company,
  });
  final TalentCandidate candidate;
  final Map<String, int> answers;
  final CompanyProfile? company;
  bool get isComplete =>
      AssessmentCatalog.allIds.every((id) => answers.containsKey(id));
  @override
  List<Object?> get props => [candidate, answers, company];
}

class CandidateReport extends Equatable {
  const CandidateReport({
    required this.candidate,
    this.answers = const {},
    this.company,
    this.vacancy,
  });
  final TalentCandidate candidate;
  final Map<String, int> answers;
  final CompanyProfile? company;
  final Vacancy? vacancy;
  @override
  List<Object?> get props => [candidate, answers, company, vacancy];
}
