// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'App Multilingua';

  @override
  String get welcome => 'Benvenuto!';

  @override
  String hello(String name) {
    return 'Ciao $name!';
  }

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count elementi',
      one: '1 elemento',
      zero: 'Nessun elemento',
    );
    return '$_temp0';
  }

  @override
  String get selectLanguage => 'Seleziona Lingua';

  @override
  String get changeLanguage => 'Cambia Lingua';

  @override
  String currentLanguage(String language) {
    return 'Lingua Corrente: $language';
  }

  @override
  String get translate => 'Traduci';

  @override
  String get autoTranslate => 'Traduzione Automatica';

  @override
  String get enterText => 'Inserisci testo da tradurre';
}
