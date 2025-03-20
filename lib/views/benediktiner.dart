import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Benediktiner extends StatelessWidget {
  final Color primaryColor = Color.fromRGBO(176, 148, 60, 1);

  // List of image asset paths.
  final List<String> images = [
    'assets/images/25_kloster_history_present_future.webp',
    'assets/images/07_kloster_workshops.webp',
    'assets/images/kloster_engelweihe.jpg',
    'assets/images/kloster_profess.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    final textStyle = TextStyle(fontSize: 18.0, height: 1.5);

    return Scaffold(
      appBar: AppBar(
        title: Text(appLoc.benediktiner),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // First paragraph card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    appLoc.benediktinerIntro,
                    style: textStyle,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              // Horizontal scrollable card with images
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: EdgeInsets.only(bottom: 16),
                child: Container(
                  height: 200,
                  padding: EdgeInsets.all(16),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(width: 16),
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          images[index],
                          width: 150,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
              ),
              // Second paragraph card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    appLoc.benediktinerPar1,
                    style: textStyle,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              // Third paragraph card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    appLoc.benediktinerPar2,
                    style: textStyle,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              // Fourth paragraph card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    appLoc.benediktinerPar3,
                    style: textStyle,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              // Fifth paragraph card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    appLoc.benediktinerPar4,
                    style: textStyle,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
