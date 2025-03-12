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
        child: Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.8,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                Text(location.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                const SizedBox(height: 10),
                Image.asset('assets/images/${location.mainImageName}', fit: BoxFit.cover),
                const SizedBox(height: 20),
                Text(
                  isHistorical
                      ? (isGerman ? location.descriptionGermanHistorical : location.descriptionEnglishHistorical)
                      : (isGerman ? location.descriptionGermanSpiritual : location.descriptionEnglishSpiritual),
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                if (location.otherImageNames.isNotEmpty)
                  CarouselSlider(
                    options: CarouselOptions(height: 200, enableInfiniteScroll: false, enlargeCenterPage: true),
                    items: location.otherImageNames.map((imageName) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                            ),
                            child: Image.asset('assets/images/$imageName', fit: BoxFit.cover),
                          );
                        },
                      );
                    }).toList(),
                  ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    launchUrl(Uri.parse(donationUrl));
                  },
                  icon: const Icon(Icons.favorite, color: Colors.white),
                  label: const Text("Donate", style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
