import 'package:flutter/material.dart';

class LocaleProvider with ChangeNotifier {
  Locale _locale = const Locale('fr');

  Locale get locale => _locale;

  set locale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  void toggleLocale() {
    if (_locale == const Locale('en')) {
      locale = const Locale('fr');
    } else {
      locale = const Locale('en');
    }
  }
}
