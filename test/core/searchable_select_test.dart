import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talex_platform/core/widgets/searchable_select.dart';
import 'package:talex_platform/l10n/app_localizations.dart';

void main() {
  testWidgets('country can be searched and selected', (tester) async {
    String? selected;
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('es'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: SearchableSelect(
            label: 'País',
            options: const ['Colombia', 'México', 'Estados Unidos'],
            searchHint: 'Buscar país...',
            onSelected: (value) => selected = value,
          ),
        ),
      ),
    );

    await tester.tap(find.byType(SearchableSelect));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'col');
    await tester.pumpAndSettle();
    expect(find.text('Colombia'), findsWidgets);
    await tester.tap(find.text('Colombia').last);
    await tester.pumpAndSettle();
    expect(selected, 'Colombia');
  });
}
