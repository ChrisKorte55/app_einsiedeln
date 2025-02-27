import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_einsiedeln/services/tour_type_provider.dart';
import 'package:app_einsiedeln/services/csv_loader.dart';
import 'package:app_einsiedeln/models/tour_location_csv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TourLocationDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tourType = Provider.of<TourTypeProvider>(context).tourType;
    final isGerman = Localizations.localeOf(context).languageCode == 'de';

    return Scaffold(
      appBar: AppBar(
        title: Text(tourType == 'historical' ? 'Historical Tour' : 'Spiritual Tour'),
      ),
      body: FutureBuilder<List<TourLocation>>(
        future: TourDataLoader().loadTourData(tourType, isGerman),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            return InteractiveBlueprint(locations: snapshot.data!);
          }
          return const Center(child: Text("No data available"));
        },
      ),
    );
  }
}

class InteractiveBlueprint extends StatelessWidget {
  final List<TourLocation> locations;

  const InteractiveBlueprint({Key? key, required this.locations}) : super(key: key);

  // Define the original image dimensions
  final double originalImageWidth = 824.0;
  final double originalImageHeight = 1077.0;

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      panEnabled: true, // Enable panning
      scaleEnabled: true, // Enable scaling
      minScale: 0.5,
      maxScale: 2.5,
      child: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = screenWidth * (originalImageHeight / originalImageWidth);

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/floorplanwithtrees2.png',
                    width: screenWidth,
                    height: screenHeight,
                    fit: BoxFit.contain,
                  ),
                  ...locations.map((location) {
                    // Calculate fractional positions
                    double xFraction = location.x / originalImageWidth;
                    double yFraction = location.y / originalImageHeight;

                    return Positioned(
                      left: xFraction * screenWidth,
                      top: yFraction * screenHeight,
                      child: GestureDetector(
                        onTap: () => _showLocationDetails(context, location),
                        child: const Icon(Icons.location_on, color: Colors.red, size: 40),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showLocationDetails(BuildContext context, TourLocation location) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var appLoc = AppLocalizations.of(context)!;
        bool isGerman = appLoc.localeName == 'de';
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            padding: const EdgeInsets.all(20),
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
                  Text(
                    location.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    isGerman ? location.descriptionGermanHistorical : location.descriptionEnglishHistorical,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    'assets/images/${location.mainImageName}',
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
