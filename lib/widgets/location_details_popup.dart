//lib/widgets/location_details_popup.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_einsiedeln/models/tour_location_csv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:app_einsiedeln/services/tour_type_provider.dart';

void showLocationDetails(BuildContext context, TourLocation location) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      var appLoc = AppLocalizations.of(context)!;
      bool isGerman = appLoc.localeName == 'de';
      bool isHistorical = Provider.of<TourTypeProvider>(context, listen: false).tourType == 'historical';

      String donationUrl =
          "https://donate.raisenow.io/khgfh?lng=en&supporter.message.value=${Uri.encodeComponent(location.name)}";

      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        backgroundColor: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        location.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Color.fromRGBO(176, 148, 60, 1),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          'assets/images/${location.mainImageName}',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        isHistorical
                            ? (isGerman ? location.descriptionGermanHistorical : location.descriptionEnglishHistorical)
                            : (isGerman ? location.descriptionGermanSpiritual : location.descriptionEnglishSpiritual),
                        style: const TextStyle(fontSize: 16, height: 1.5),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        appLoc.donationText,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: () {
                          launchUrl(Uri.parse(donationUrl));
                        },
                        icon: const Icon(Icons.favorite, color: Colors.white),
                        label: const Text("Donate", style: TextStyle(fontSize: 18, color: Colors.black)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(176, 148, 60, 1),
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (location.otherImageNames.isNotEmpty)
                        CarouselSlider(
                          options: CarouselOptions(
                            height: 250,  // Adjusted height for better aspect ratio maintenance
                            enableInfiniteScroll: true,
                            enlargeCenterPage: true,
                            viewportFraction: 0.8,  // Adjusted for maintaining aspect ratio
                            aspectRatio: 16 / 9,  // Specify an aspect ratio for image display
                            initialPage: 0,
                          ),
                          items: location.otherImageNames.map((imageName) {
                            return Builder(
                              builder: (BuildContext context) {
                                return GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          backgroundColor: Colors.transparent,
                                          child: GestureDetector(
                                            onTap: () => Navigator.of(context).pop(),
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(15),
                                                child: Image.asset(
                                                  'assets/images/$imageName',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.asset(
                                        'assets/images/$imageName',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
