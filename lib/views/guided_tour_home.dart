import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TourLangHome extends StatelessWidget {
  const TourLangHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!; // Fetch localized strings

    return Scaffold(
      appBar: AppBar(
        title: Text(appLoc.tourHomeText), // Use localized title
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Text(appLoc.tourHomeText), // Use localized body text
      ),
    );
  }
}
