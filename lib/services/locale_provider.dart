import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  Locale _locale = const Locale('en'); // Default language is English

  Locale get locale => _locale;

  void setLocale(Locale newLocale) {
    if (_locale == newLocale) return; // Avoid unnecessary rebuilds
    _locale = newLocale;
    notifyListeners(); // Notify widgets to rebuild with the new locale
  }
}

