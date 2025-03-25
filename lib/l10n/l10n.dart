import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

export 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// An extension to provide localized wording
extension AppLocalizationsX on BuildContext {
  /// Use this to access the localized words and phrases
  AppLocalizations get l10n => AppLocalizations.of(this);
}
