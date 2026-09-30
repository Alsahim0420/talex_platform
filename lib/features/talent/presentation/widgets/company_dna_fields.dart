import 'package:flutter/material.dart';
import 'package:talex_platform/core/widgets/searchable_select.dart';
import 'package:talex_platform/features/talent/domain/entities/talent_entities.dart';
import 'package:talex_platform/features/talent/domain/services/dna_catalog.dart';
import 'package:talex_platform/features/talent/presentation/company_options.dart';
import 'package:talex_platform/l10n/l10n.dart';

class CompanyDnaFields extends StatelessWidget {
  const CompanyDnaFields({
    super.key,
    required this.values,
    required this.culture,
    required this.standout,
    required this.catalog,
    required this.onValuesChanged,
    required this.onCultureChanged,
    required this.onStandoutChanged,
    this.onDeleteCustom,
    this.enabled = true,
  });

  final List<String> values;
  final List<String> culture;
  final List<String> standout;
  final List<DnaCatalogEntry> catalog;
  final ValueChanged<List<String>> onValuesChanged;
  final ValueChanged<List<String>> onCultureChanged;
  final ValueChanged<List<String>> onStandoutChanged;
  final void Function(String type, String label)? onDeleteCustom;
  final bool enabled;

  Set<String> _custom(String type, List<String> selected) {
    return {
      for (final item in selected)
        if (!isDnaPresetLabel(type, item)) item,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final language = Localizations.localeOf(context).languageCode;
    if (!enabled) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.dnaSelectSeveral,
          style: const TextStyle(height: 1.35),
        ),
        const SizedBox(height: 12),
        SearchableMultiSelect(
          label: l10n.companyValues,
          values: values,
          options: dnaValueOptions(
            languageCode: language,
            catalog: catalog,
            extra: values,
          ),
          searchHint: l10n.searchOrAdd,
          allowCustom: true,
          removableValues: _custom(DnaCatalogType.values, values),
          onChanged: onValuesChanged,
          onRemoveOption: (label) {
            onValuesChanged(values.where((item) => item != label).toList());
            onDeleteCustom?.call(DnaCatalogType.values, label);
          },
        ),
        SearchableMultiSelect(
          label: l10n.companyCulture,
          values: culture,
          options: dnaCultureOptions(
            languageCode: language,
            catalog: catalog,
            extra: culture,
          ),
          searchHint: l10n.searchOrAdd,
          allowCustom: true,
          removableValues: _custom(DnaCatalogType.culture, culture),
          onChanged: onCultureChanged,
          onRemoveOption: (label) {
            onCultureChanged(culture.where((item) => item != label).toList());
            onDeleteCustom?.call(DnaCatalogType.culture, label);
          },
        ),
        SearchableMultiSelect(
          label: l10n.standoutPeople,
          values: standout,
          options: dnaStandoutOptions(
            languageCode: language,
            catalog: catalog,
            extra: standout,
          ),
          searchHint: l10n.searchOrAdd,
          allowCustom: true,
          removableValues: _custom(DnaCatalogType.standout, standout),
          onChanged: onStandoutChanged,
          onRemoveOption: (label) {
            onStandoutChanged(standout.where((item) => item != label).toList());
            onDeleteCustom?.call(DnaCatalogType.standout, label);
          },
        ),
      ],
    );
  }
}
