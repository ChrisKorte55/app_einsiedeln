/*
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'tour_location_detail_views.dart'; 
import 'package:app_einsiedeln/models/tour_location_csv.dart'; 
import 'package:app_einsiedeln/services/csv_loader.dart'; 

class TourLocation extends StatefulWidget {
  final String tourType; // "religious" or "spiritual"

  const TourLocation({Key? key, required this.tourType}) : super(key: key);

  @override
  TourLocationState createState() => TourLocationState();
}

class TourLocationState extends State<TourLocation> {
  late Future<List<TourLocation>> tourLocations;

  @override
  void initState() {
    super.initState();
    loadTourData();
  }

  void loadTourData() {
    // Future loading is now handled properly
    tourLocations = TourDataLoader().loadTourData(widget.tourType, Localizations.localeOf(context).languageCode == 'de');
  }

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tourType == 'religious' ? appLoc.spiritualTour : appLoc.spiritualTour),
      ),
      body: FutureBuilder<List<TourLocation>>(
        future: tourLocations,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error.toString()}'));
          }
          if (snapshot.hasData) {
            return InteractiveBlueprint(
              locations: snapshot.data!,
              imagePath: 'assets/floorplanwithtrees2.png',
            );
          }
          return const Center(child: Text("No data available"));
        },
      ),
    );
  }
}

class InteractiveBlueprint extends StatelessWidget {
  final String imagePath;
  final List<TourLocation> locations;

  const InteractiveBlueprint({Key? key, required this.imagePath, required this.locations}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double screenHeight = screenWidth; // Assumes the image is square for simplicity

        return Stack(
          children: [
            Image.asset(imagePath, width: screenWidth, height: screenHeight, fit: BoxFit.cover),
            ...locations.map((location) {
              double scaledX = location.x * screenWidth;
              double scaledY = location.y * screenHeight;
              return Positioned(
                left: scaledX,
                top: scaledY,
                child: GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(
                    builder: (context) => LocationDetailPage(
                      locationName: location.name,
                      description: Localizations.localeOf(context).languageCode == 'de' ?
                        (widget.tourType == 'religious' ? location.descriptionGermanHistorical : location.descriptionGermanSpiritual) :
                        (widget.tourType == 'religious' ? location.descriptionEnglishHistorical : location.descriptionEnglishSpiritual),
                      imageName: location.mainImageName,
                    ),
                  )),
                  child: const Icon(Icons.location_on, color: Colors.red, size: 40),
                ),
              );
            }).toList(),
          ],
        );
      },
    );
  }
}
*/