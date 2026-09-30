import 'package:flutter/widgets.dart';
import 'package:talex_platform/l10n/app_localizations.dart';

extension AppLocalizationsContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
