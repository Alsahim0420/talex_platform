import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talex_platform/core/constants/app_colors.dart';
import 'package:talex_platform/features/admin/domain/entities/admin_entities.dart';
import 'package:talex_platform/features/admin/presentation/bloc/admin_bloc.dart';
import 'package:talex_platform/features/admin/presentation/widgets/admin_widgets.dart';
import 'package:talex_platform/l10n/l10n.dart';

Future<void> showAdminCreateCompany(BuildContext context) {
  final name = TextEditingController();
  final plan = TextEditingController();
  var status = CompanyStatus.onboarding;
  final labels = AdminLabels(context);
  return showDialog<void>(
    context: context,
    builder: (dialogContext) => _AdminFormDialog(
      title: context.l10n.newCompany,
      onSubmit: () {
        if (name.text.trim().isEmpty) return;
        context.read<AdminBloc>().add(
          AdminCompanyCreated(
            name: name.text.trim(),
            status: status,
            plan: plan.text.trim().isEmpty ? null : plan.text.trim(),
          ),
        );
        Navigator.pop(dialogContext);
      },
      children: [
        TextFormField(
          controller: name,
          decoration: InputDecoration(
            labelText: context.l10n.companyName,
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14),
        DropdownButtonFormField<CompanyStatus>(
          initialValue: status,
          decoration: InputDecoration(
            labelText: context.l10n.statusLabel,
            border: const OutlineInputBorder(),
          ),
          items: CompanyStatus.values
              .map(
                (item) => DropdownMenuItem(
                  value: item,
                  child: Text(labels.companyStatus(item)),
                ),
              )
              .toList(),
          onChanged: (value) => status = value ?? status,
        ),
        const SizedBox(height: 14),
        TextFormField(
          controller: plan,
          decoration: InputDecoration(
            labelText: context.l10n.plan,
            border: const OutlineInputBorder(),
          ),
        ),
      ],
    ),
  );
}

Future<void> showAdminCreateProcess(BuildContext context, List<Company> companies) {
  if (companies.isEmpty) return Future.value();
  final name = TextEditingController();
  var companyId = companies.first.id;
  return showDialog<void>(
    context: context,
    builder: (dialogContext) => _AdminFormDialog(
      title: context.l10n.newProcess,
      onSubmit: () {
        if (name.text.trim().isEmpty) return;
        context.read<AdminBloc>().add(
          AdminProcessCreated(companyId: companyId, name: name.text.trim()),
        );
        Navigator.pop(dialogContext);
      },
      children: [
        DropdownButtonFormField<String>(
          initialValue: companyId,
          decoration: InputDecoration(
            labelText: context.l10n.adminCompanies,
            border: const OutlineInputBorder(),
          ),
          items: companies
              .map(
                (item) => DropdownMenuItem(value: item.id, child: Text(item.name)),
              )
              .toList(),
          onChanged: (value) => companyId = value ?? companyId,
        ),
        const SizedBox(height: 14),
        TextFormField(
          controller: name,
          decoration: InputDecoration(
            labelText: context.l10n.adminProcesses,
            border: const OutlineInputBorder(),
          ),
        ),
      ],
    ),
  );
}

Future<void> showAdminCreatePerson(
  BuildContext context, {
  required List<Company> companies,
  required List<TalentProcess> processes,
}) {
  if (companies.isEmpty || processes.isEmpty) return Future.value();
  final name = TextEditingController();
  final score = TextEditingController();
  var companyId = companies.first.id;
  var processId = processes.first.id;
  var status = EvaluationStatus.invited;
  final labels = AdminLabels(context);
  return showDialog<void>(
    context: context,
    builder: (dialogContext) => _AdminFormDialog(
      title: context.l10n.newPerson,
      onSubmit: () {
        if (name.text.trim().isEmpty) return;
        context.read<AdminBloc>().add(
          AdminPersonCreated(
            companyId: companyId,
            processId: processId,
            displayName: name.text.trim(),
            status: status,
            affinityScore: double.tryParse(score.text.trim()),
          ),
        );
        Navigator.pop(dialogContext);
      },
      children: [
        DropdownButtonFormField<String>(
          initialValue: companyId,
          decoration: InputDecoration(
            labelText: context.l10n.adminCompanies,
            border: const OutlineInputBorder(),
          ),
          items: companies
              .map(
                (item) => DropdownMenuItem(value: item.id, child: Text(item.name)),
              )
              .toList(),
          onChanged: (value) => companyId = value ?? companyId,
        ),
        const SizedBox(height: 14),
        DropdownButtonFormField<String>(
          initialValue: processId,
          decoration: InputDecoration(
            labelText: context.l10n.adminProcesses,
            border: const OutlineInputBorder(),
          ),
          items: processes
              .map(
                (item) => DropdownMenuItem(value: item.id, child: Text(item.name)),
              )
              .toList(),
          onChanged: (value) => processId = value ?? processId,
        ),
        const SizedBox(height: 14),
        TextFormField(
          controller: name,
          decoration: InputDecoration(
            labelText: context.l10n.personName,
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14),
        DropdownButtonFormField<EvaluationStatus>(
          initialValue: status,
          decoration: InputDecoration(
            labelText: context.l10n.statusLabel,
            border: const OutlineInputBorder(),
          ),
          items: EvaluationStatus.values
              .map(
                (item) =>
                    DropdownMenuItem(value: item, child: Text(labels.evaluation(item))),
              )
              .toList(),
          onChanged: (value) => status = value ?? status,
        ),
        const SizedBox(height: 14),
        TextFormField(
          controller: score,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: context.l10n.affinityScore,
            border: const OutlineInputBorder(),
          ),
        ),
      ],
    ),
  );
}

Future<void> showAdminCreateDeal(BuildContext context, List<Company> companies) {
  if (companies.isEmpty) return Future.value();
  var companyId = companies.first.id;
  var stage = DealStage.prospect;
  final value = TextEditingController();
  final owner = TextEditingController();
  final next = TextEditingController();
  final labels = AdminLabels(context);
  return showDialog<void>(
    context: context,
    builder: (dialogContext) => _AdminFormDialog(
      title: context.l10n.newDeal,
      onSubmit: () {
        context.read<AdminBloc>().add(
          AdminDealCreated(
            companyId: companyId,
            stage: stage,
            estimatedValue: double.tryParse(value.text.trim()),
            ownerName: owner.text.trim().isEmpty ? null : owner.text.trim(),
            nextAction: next.text.trim().isEmpty ? null : next.text.trim(),
          ),
        );
        Navigator.pop(dialogContext);
      },
      children: [
        DropdownButtonFormField<String>(
          initialValue: companyId,
          decoration: InputDecoration(
            labelText: context.l10n.adminCompanies,
            border: const OutlineInputBorder(),
          ),
          items: companies
              .map(
                (item) => DropdownMenuItem(value: item.id, child: Text(item.name)),
              )
              .toList(),
          onChanged: (value) => companyId = value ?? companyId,
        ),
        const SizedBox(height: 14),
        DropdownButtonFormField<DealStage>(
          initialValue: stage,
          decoration: InputDecoration(
            labelText: context.l10n.statusLabel,
            border: const OutlineInputBorder(),
          ),
          items: DealStage.values
              .map((item) => DropdownMenuItem(value: item, child: Text(labels.deal(item))))
              .toList(),
          onChanged: (value) => stage = value ?? stage,
        ),
        const SizedBox(height: 14),
        TextFormField(
          controller: value,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: context.l10n.estimatedValue,
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14),
        TextFormField(
          controller: owner,
          decoration: InputDecoration(
            labelText: context.l10n.owner,
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14),
        TextFormField(
          controller: next,
          decoration: InputDecoration(
            labelText: context.l10n.nextAction,
            border: const OutlineInputBorder(),
          ),
        ),
      ],
    ),
  );
}

Future<void> showAdminCreateSale(BuildContext context, List<Company> companies) {
  if (companies.isEmpty) return Future.value();
  var companyId = companies.first.id;
  final amount = TextEditingController();
  final product = TextEditingController();
  var recurring = false;
  return showDialog<void>(
    context: context,
    builder: (dialogContext) => StatefulBuilder(
      builder: (context, setState) => _AdminFormDialog(
        title: context.l10n.newSale,
        onSubmit: () {
          final parsed = double.tryParse(amount.text.trim());
          if (parsed == null) return;
          context.read<AdminBloc>().add(
            AdminSaleCreated(
              companyId: companyId,
              amount: parsed,
              product: product.text.trim().isEmpty ? null : product.text.trim(),
              recurring: recurring,
            ),
          );
          Navigator.pop(dialogContext);
        },
        children: [
          DropdownButtonFormField<String>(
            initialValue: companyId,
            decoration: InputDecoration(
              labelText: context.l10n.adminCompanies,
              border: const OutlineInputBorder(),
            ),
            items: companies
                .map(
                  (item) => DropdownMenuItem(value: item.id, child: Text(item.name)),
                )
                .toList(),
            onChanged: (value) => companyId = value ?? companyId,
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: amount,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: context.l10n.amount,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: product,
            decoration: InputDecoration(
              labelText: context.l10n.product,
              border: const OutlineInputBorder(),
            ),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(context.l10n.recurring),
            value: recurring,
            onChanged: (value) => setState(() => recurring = value),
          ),
        ],
      ),
    ),
  );
}

class _AdminFormDialog extends StatelessWidget {
  const _AdminFormDialog({
    required this.title,
    required this.children,
    required this.onSubmit,
  });
  final String title;
  final List<Widget> children;
  final VoidCallback onSubmit;
  @override
  Widget build(BuildContext context) => Dialog(
    insetPadding: const EdgeInsets.all(20),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 520),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: AppColors.ink,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 22),
            ...children,
            const SizedBox(height: 22),
            FilledButton(
              onPressed: onSubmit,
              style: FilledButton.styleFrom(backgroundColor: AppColors.primaryButton),
              child: Text(context.l10n.saveChanges),
            ),
          ],
        ),
      ),
    ),
  );
}
