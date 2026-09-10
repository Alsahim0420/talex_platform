import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talex_platform/core/auth/user_role.dart';
import 'package:talex_platform/core/constants/app_colors.dart';
import 'package:talex_platform/core/di/injection.dart';
import 'package:talex_platform/core/services/notification_service.dart';
import 'package:talex_platform/core/widgets/affinity_badge.dart';
import 'package:talex_platform/core/widgets/app_select_field.dart';
import 'package:talex_platform/core/widgets/location_picker.dart';
import 'package:talex_platform/features/talent/data/services/invite_email_service.dart';
import 'package:talex_platform/features/talent/domain/entities/talent_entities.dart';
import 'package:talex_platform/features/talent/domain/repositories/talent_repository.dart';
import 'package:talex_platform/features/talent/presentation/bloc/talent_bloc.dart';
import 'package:talex_platform/features/talent/presentation/company_options.dart';
import 'package:talex_platform/features/talent/presentation/talent_error_message.dart';
import 'package:talex_platform/l10n/l10n.dart';

Future<void> showCreateVacancyDialog(
  BuildContext context,
  String companyId, {
  CompanyProfile? company,
}) {
  final talentBloc = context.read<TalentBloc>();
  return showDialog<void>(
    context: context,
    builder: (dialogContext) => BlocProvider.value(
      value: talentBloc,
      child: _CreateVacancyDialog(
        companyId: companyId,
        company: company,
      ),
    ),
  );
}

class _CreateVacancyDialog extends StatefulWidget {
  const _CreateVacancyDialog({required this.companyId, this.company});
  final String companyId;
  final CompanyProfile? company;

  @override
  State<_CreateVacancyDialog> createState() => _CreateVacancyDialogState();
}

class _CreateVacancyDialogState extends State<_CreateVacancyDialog> {
  final _name = TextEditingController();
  final _description = TextEditingController();
  final _profile = TextEditingController();
  String? _area;
  String? _customArea;
  String? _mode;
  String? _contract;
  String? _seniority;
  var _includeRemoteCity = false;
  late LocationValue _location;

  @override
  void initState() {
    super.initState();
    final company = widget.company;
    _location = LocationValue(
      country: company?.country ?? 'Colombia',
      region: company?.region,
      city: company?.city,
    );
  }

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    _profile.dispose();
    super.dispose();
  }

  bool get _needsCity => vacancyWorkModeNeedsCity(_mode);
  bool get _showLocation => _needsCity || _includeRemoteCity;

  void _submit() {
    if (_name.text.trim().isEmpty || _mode == null) return;
    if (_needsCity && (_location.city == null || _location.city!.trim().isEmpty)) {
      return;
    }
    final city = _showLocation ? _location.city : null;
    final country = _showLocation ? _location.country : null;
    final region = _showLocation ? _location.region : null;
    final area = _area == VacancyAreaId.other
        ? _customArea?.trim()
        : _area;
    if (_area == VacancyAreaId.other && (area == null || area.isEmpty)) return;
    context.read<TalentBloc>().add(
      TalentVacancyCreated(
        Vacancy(
          id: '',
          companyId: widget.companyId,
          name: _name.text.trim(),
          status: VacancyStatus.active,
          createdAt: DateTime.now(),
          area: area,
          description: _description.text.trim(),
          city: city,
          country: country,
          region: region,
          workMode: _mode,
          contractType: _contract,
          seniority: _seniority,
          roleProfile: _profile.text.trim(),
        ),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final catalogAreas = vacancyAreasForSector(l10n, widget.company?.sector);
    final custom = [
      for (final item in widget.company?.customAreas ?? const <String>[])
        if (catalogAreas.every((option) => option.id != item && option.label != item))
          CatalogOption(item, item),
    ];
    final areas = [...catalogAreas, ...custom];
    return _FormDialog(
      title: l10n.createVacancy,
      submitLabel: l10n.createVacancy,
      onSubmit: _submit,
      children: [
        _input(l10n.vacancyName, _name),
        AppSelectField(
          label: l10n.vacancyArea,
          value: _area,
          options: areas,
          onChanged: (value) => setState(() => _area = value),
        ),
        if (_area == VacancyAreaId.other)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: TextField(
              onChanged: (value) => _customArea = value,
              decoration: InputDecoration(
                labelText: l10n.customAreaLabel,
                border: const OutlineInputBorder(),
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            l10n.vacancyAreaHint,
            style: const TextStyle(color: AppColors.muted, fontSize: 13, height: 1.35),
          ),
        ),
        _input(l10n.description, _description, lines: 3),
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: DropdownButtonFormField<String>(
            initialValue: _mode,
            isExpanded: true,
            alignment: Alignment.center,
            decoration: InputDecoration(
              labelText: l10n.workMode,
              border: const OutlineInputBorder(),
            ),
            items: [
              DropdownMenuItem(
                value: VacancyWorkMode.remote,
                alignment: Alignment.center,
                child: Text(l10n.workModeRemote, textAlign: TextAlign.center),
              ),
              DropdownMenuItem(
                value: VacancyWorkMode.onsite,
                alignment: Alignment.center,
                child: Text(l10n.workModeOnsite, textAlign: TextAlign.center),
              ),
              DropdownMenuItem(
                value: VacancyWorkMode.hybrid,
                alignment: Alignment.center,
                child: Text(l10n.workModeHybrid, textAlign: TextAlign.center),
              ),
            ],
            onChanged: (value) => setState(() {
              _mode = value;
              if (_needsCity) _includeRemoteCity = false;
            }),
          ),
        ),
        Text(
          l10n.workModeHint,
          style: const TextStyle(color: AppColors.muted, fontSize: 13, height: 1.35),
        ),
        const SizedBox(height: 12),
        if (_mode == VacancyWorkMode.remote)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: _includeRemoteCity,
              onChanged: (value) => setState(() => _includeRemoteCity = value ?? false),
              title: Text(l10n.vacancyCityOptional),
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ),
        if (_showLocation)
          LocationPicker(
            key: ValueKey(_mode),
            initial: _location,
            onChanged: (value) => _location = value,
          ),
        AppSelectField(
          label: l10n.contractType,
          value: resolveContractId(_contract, l10n),
          options: vacancyContractTypes(l10n),
          onChanged: (value) => setState(() => _contract = value),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: DropdownButtonFormField<String>(
            initialValue: _seniority,
            isExpanded: true,
            alignment: Alignment.center,
            decoration: InputDecoration(
              labelText: l10n.seniority,
              border: const OutlineInputBorder(),
            ),
            items: [
              DropdownMenuItem(
                value: VacancySeniority.junior,
                alignment: Alignment.center,
                child: Text(l10n.seniorityJunior, textAlign: TextAlign.center),
              ),
              DropdownMenuItem(
                value: VacancySeniority.mid,
                alignment: Alignment.center,
                child: Text(l10n.seniorityMid, textAlign: TextAlign.center),
              ),
              DropdownMenuItem(
                value: VacancySeniority.senior,
                alignment: Alignment.center,
                child: Text(l10n.senioritySenior, textAlign: TextAlign.center),
              ),
              DropdownMenuItem(
                value: VacancySeniority.lead,
                alignment: Alignment.center,
                child: Text(l10n.seniorityLead, textAlign: TextAlign.center),
              ),
            ],
            onChanged: (value) => setState(() => _seniority = value),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            l10n.seniorityHint,
            style: const TextStyle(color: AppColors.muted, fontSize: 13, height: 1.35),
          ),
        ),
        _input(l10n.roleProfile, _profile, lines: 3),
      ],
    );
  }
}

Future<void> showCreateRespondentDialog(BuildContext context, TalentState state) {
  if (state.snapshot.vacancies.isEmpty) return Future.value();
  return showDialog<void>(
    context: context,
    builder: (_) => BlocProvider.value(
      value: context.read<TalentBloc>(),
      child: _CreateRespondentDialog(state: state),
    ),
  );
}

class _CreateRespondentDialog extends StatefulWidget {
  const _CreateRespondentDialog({required this.state});
  final TalentState state;

  @override
  State<_CreateRespondentDialog> createState() => _CreateRespondentDialogState();
}

class _CreateRespondentDialogState extends State<_CreateRespondentDialog> {
  late String _vacancyId;
  final _email = TextEditingController();
  final _document = TextEditingController();
  final _name = TextEditingController();
  var _submitting = false;

  @override
  void initState() {
    super.initState();
    _vacancyId = widget.state.snapshot.vacancies.first.id;
  }

  @override
  void dispose() {
    _email.dispose();
    _document.dispose();
    _name.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_submitting) return;
    final email = _email.text.trim();
    final document = _document.text.trim();
    if (!email.contains('@') || document.length < 6 || _name.text.trim().isEmpty) {
      return;
    }
    setState(() => _submitting = true);
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).languageCode;
    final vacancy = widget.state.snapshot.vacancies.firstWhere(
      (item) => item.id == _vacancyId,
    );
    final result = await getIt<TalentRepository>().createRespondent(
      companyId: widget.state.companyId!,
      vacancyId: _vacancyId,
      email: email,
      documentNumber: document,
      displayName: _name.text.trim(),
    );
    if (!mounted) return;
    await result.fold(
      (failure) async {
        setState(() => _submitting = false);
        getIt<NotificationService>().error(talentErrorMessage(l10n, failure.message));
      },
      (pin) async {
        final mail = await getIt<InviteEmailService>().sendRespondentPin(
          to: email,
          firstName: _name.text.trim().split(' ').first,
          companyName: widget.state.snapshot.profile?.name ?? '',
          pin: pin,
          locale: locale,
          vacancyName: vacancy.name,
        );
        final notifications = getIt<NotificationService>();
        notifications.success(l10n.invitePinReady(pin));
        mail.fold(
          (failure) => notifications.error(talentErrorMessage(l10n, failure.message)),
          (_) => notifications.success(l10n.emailSent),
        );
        if (!mounted) return;
        context.read<TalentBloc>().add(TalentLoaded(widget.state.companyId!));
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final vacancies = widget.state.snapshot.vacancies;
    return _FormDialog(
      title: l10n.createRespondent,
      submitLabel: l10n.createRespondent,
      onSubmit: _submitting ? () {} : _submit,
      children: [
        Text(
          l10n.respondentInviteHint,
          style: const TextStyle(color: AppColors.muted, height: 1.4),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: DropdownButtonFormField<String>(
            initialValue: _vacancyId,
            isExpanded: true,
            alignment: Alignment.center,
            decoration: InputDecoration(
              labelText: l10n.vacancy,
              border: const OutlineInputBorder(),
            ),
            items: vacancies
                .map(
                  (item) => DropdownMenuItem(
                    value: item.id,
                    alignment: Alignment.center,
                    child: Text(item.name, textAlign: TextAlign.center),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) setState(() => _vacancyId = value);
            },
          ),
        ),
        _input(l10n.fullName, _name),
        _input(l10n.emailAddress, _email),
        _input(l10n.documentNumber, _document),
      ],
    );
  }
}

Future<void> showInviteRecruiterDialog(
  BuildContext context,
  String companyId, {
  String? companyName,
}) {
  return showDialog<void>(
    context: context,
    builder: (_) => BlocProvider.value(
      value: context.read<TalentBloc>(),
      child: _InviteTeamDialog(companyId: companyId, companyName: companyName),
    ),
  );
}

class _InviteTeamDialog extends StatefulWidget {
  const _InviteTeamDialog({required this.companyId, this.companyName});
  final String companyId;
  final String? companyName;

  @override
  State<_InviteTeamDialog> createState() => _InviteTeamDialogState();
}

class _InviteTeamDialogState extends State<_InviteTeamDialog> {
  final _email = TextEditingController();
  final _first = TextEditingController();
  final _last = TextEditingController();
  var _role = UserRole.recruiter;
  var _submitting = false;

  @override
  void dispose() {
    _email.dispose();
    _first.dispose();
    _last.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_submitting) return;
    final email = _email.text.trim();
    if (!email.contains('@') || _first.text.trim().isEmpty) return;
    setState(() => _submitting = true);
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).languageCode;
    final result = await getIt<TalentRepository>().inviteRecruiter(
      companyId: widget.companyId,
      email: email,
      firstName: _first.text.trim(),
      lastName: _last.text.trim(),
      role: _role,
    );
    if (!mounted) return;
    await result.fold(
      (failure) async {
        setState(() => _submitting = false);
        getIt<NotificationService>().error(talentErrorMessage(l10n, failure.message));
      },
      (pin) async {
        final mail = await getIt<InviteEmailService>().sendRecruiterPin(
          to: email,
          firstName: _first.text.trim(),
          companyName: widget.companyName ?? '',
          pin: pin,
          locale: locale,
          situation: 'company_new_user',
        );
        final notifications = getIt<NotificationService>();
        notifications.success(l10n.invitePinReady(pin));
        mail.fold(
          (failure) => notifications.error(talentErrorMessage(l10n, failure.message)),
          (_) => notifications.success(l10n.emailSent),
        );
        if (!mounted) return;
        context.read<TalentBloc>().add(TalentLoaded(widget.companyId));
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return _FormDialog(
      title: l10n.inviteRecruiter,
      submitLabel: l10n.inviteRecruiter,
      onSubmit: _submitting ? () {} : _submit,
      children: [
        Text(
          l10n.inviteTeamSubtitle,
          style: const TextStyle(color: AppColors.muted, height: 1.4),
        ),
        const SizedBox(height: 16),
        _input(l10n.firstName, _first),
        _input(l10n.lastName, _last),
        _input(l10n.emailAddress, _email),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: DropdownButtonFormField<UserRole>(
            initialValue: _role,
            isExpanded: true,
            alignment: Alignment.center,
            decoration: InputDecoration(
              labelText: l10n.teamRole,
              border: const OutlineInputBorder(),
            ),
            items: companyInviteRoles()
                .map(
                  (role) => DropdownMenuItem(
                    value: role,
                    alignment: Alignment.center,
                    child: Text(teamRoleLabel(l10n, role), textAlign: TextAlign.center),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) setState(() => _role = value);
            },
          ),
        ),
        Text(
          l10n.teamRoleHint,
          style: const TextStyle(color: AppColors.muted, fontSize: 13, height: 1.35),
        ),
      ],
    );
  }
}

Future<void> showComparisonDialog(
  BuildContext context,
  List<TalentCandidate> candidates,
) {
  return showDialog<void>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(context.l10n.compare),
      content: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(label: Text(context.l10n.characteristic)),
            ...candidates.map(
              (item) => DataColumn(label: Text(item.displayName ?? item.email)),
            ),
          ],
          rows: [
            DataRow(
              cells: [
                DataCell(Text(context.l10n.affinityWithCompany)),
                ...candidates.map((item) => DataCell(AffinityBadge(item.companyAffinity))),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text(context.l10n.affinityWithVacancy)),
                ...candidates.map((item) => DataCell(AffinityBadge(item.vacancyAffinity))),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: Text(context.l10n.close),
        ),
      ],
    ),
  );
}

class _FormDialog extends StatelessWidget {
  const _FormDialog({
    required this.title,
    required this.children,
    required this.onSubmit,
    this.submitLabel,
  });
  final String title;
  final List<Widget> children;
  final VoidCallback onSubmit;
  final String? submitLabel;
  @override
  Widget build(BuildContext context) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 720),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 18),
            ...children,
            const SizedBox(height: 18),
            Row(
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(context.l10n.cancel),
                ),
                const Spacer(),
                FilledButton(
                  onPressed: onSubmit,
                  style: FilledButton.styleFrom(backgroundColor: AppColors.primaryButton),
                  child: Text(submitLabel ?? context.l10n.saveChanges),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _input(String label, TextEditingController controller, {int lines = 1}) =>
    Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        maxLines: lines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
