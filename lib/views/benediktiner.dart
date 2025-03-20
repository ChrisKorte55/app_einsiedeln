import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Benediktiner extends StatelessWidget {
  final Color primaryColor = Color.fromRGBO(176, 148, 60, 1);

  final List<String> images = [
    'assets/images/25_kloster_history_present_future.webp',
    'assets/images/07_kloster_workshops.webp',
    'assets/images/kloster_engelweihe.jpg',
    'assets/images/kloster_profess.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    final textStyle = TextStyle(fontSize: 18.0, height: 1.5, color: Colors.grey[800]);
    final titleStyle = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: primaryColor);

    return Scaffold(
      appBar: AppBar(
        title: Text(appLoc.benediktiner, style: titleStyle),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    appLoc.benediktinerIntro,
                    style: textStyle,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              SizedBox(height: 20),
              CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 16/9,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                  autoPlay: true,
                ),
                items: images.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          child: Image.asset(i, fit: BoxFit.cover),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    appLoc.benediktinerPar1,
                    style: textStyle,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    appLoc.benediktinerPar2,
                    style: textStyle,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    appLoc.benediktinerPar3,
                    style: textStyle,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
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
