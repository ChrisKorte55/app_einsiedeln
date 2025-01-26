import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// Import the generated localization files (after running `flutter gen-l10n`).
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/views/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// Holds the current locale. Null means system default.
  Locale? _locale;

  /// Call this method to change the app locale from anywhere in the app.
  void _setLocale(Locale newLocale) {
    setState(() {
      _locale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Set the locale when not null. Otherwise, uses system locale.
      locale: _locale,
      
      // These delegates make sure we have our generated strings + default Flutter localizations
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('de'), // German
      ],

      // Fallback (in case an unsupported locale is selected)
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale == null) {
          return supportedLocales.first;
        }
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },

      home: MainPage(
        onLocaleChange: _setLocale,
      ),
    );
  }
}
