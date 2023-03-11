import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class Localization {
  Localization(this.locale);

  static List<String> availableLocales = ["en"];

  static Localization? of(BuildContext context) {
    return Localizations.of<Localization>(context, Localization);
  }

  final Locale locale;

  late Map<String, String> _localizationMap;

  Future<void> init() async {
    final String jsonString = await rootBundle.loadString('lib/data/resources/strings.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizationMap = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
  }

  String getString(String key) {
    if(!_localizationMap.containsKey(key)) return "";
    return _localizationMap[key]!;
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<Localization> {
  @override
  bool isSupported(Locale locale) =>
      Localization.availableLocales.contains(locale.languageCode);

  @override
  Future<Localization> load(Locale locale) async {
    Localization localizations = Localization(locale);
    await localizations.init();
    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<Localization> old) {
    return false;
  }
}