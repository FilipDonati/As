// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Multilingual App';

  @override
  String get welcome => 'Welcome!';

  @override
  String hello(String name) {
    return 'Hello $name!';
  }

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
      zero: 'No items',
    );
    return '$_temp0';
  }

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get changeLanguage => 'Change Language';

  @override
  String currentLanguage(String language) {
    return 'Current Language: $language';
  }

  @override
  String get translate => 'Translate';

  @override
  String get autoTranslate => 'Auto Translate';

  @override
  String get enterText => 'Enter text to translate';
}
