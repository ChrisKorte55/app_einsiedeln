import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '/views/main_page.dart';
import '/views/events_calendar_page.dart';
import '/views/about_us_page.dart';
import '/views/live_stream_page.dart';
import '/views/online_shop_page.dart';
import '/views/self_guided_tour_page.dart';

void main() {
  runApp(const MyApp());
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

      // Define the initial route
      initialRoute: '/',

      // Define the routes table
      routes: {
        '/': (context) => MainPage(onLocaleChange: _setLocale),
        '/events_calendar_page': (context) => const EventsPage(),
        '/about_us_page': (context) => const AboutUsPage(),
        '/live_stream_page': (context) => const LiveStreamPage(),
        '/online_shop_page': (context) => const OnlineShopPage(),
        '/self_guided_tour_page': (context) => const TourLocation()
      },
    );
  }
}
