import 'package:arquitectura_universales/main.dart';
import 'package:arquitectura_universales/util/app_string.dart';
import 'package:arquitectura_universales/util/app_string_en.dart';
import 'package:arquitectura_universales/util/app_string_es.dart';
import 'package:flutter/cupertino.dart';

class AppLocalizations {
  Locale localeName;

  AppLocalizations(this.localeName);

  static final Map<String, Map<Strings, String>> _localizedvalues = {
    'es': dictionary_es,
    'en': dictionary_en,
  };

  String dictionary(Strings label) => MyApp.idioma == "Español"
      ? _localizedvalues['es']![label] ?? ""
      : MyApp.idioma == "English"
          ? _localizedvalues['en']![label] ?? ""
          : _localizedvalues[localeName.languageCode]![label] ??
              ""; //EN ESTA LINEA ES QUE SE CAMBIA EL IDIOMA

  static const LocalizationsDelegate<AppLocalizations> delegate =
      AppLocalizationsDelegate();
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    print("IS SUPORTED = ${locale.languageCode}");
    return ['es', 'en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    print("EL LOCALE ES: ${locale.languageCode}");
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
