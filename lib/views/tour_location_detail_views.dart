import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
    return Center(
      child: InteractiveViewer(
        panEnabled: true,
        scaleEnabled: true,
        minScale: 0.5,
        maxScale: 2.5,
        child: AspectRatio(
          aspectRatio: originalImageWidth / originalImageHeight,
          child: LayoutBuilder(
            builder: (context, constraints) {
              double displayWidth = constraints.maxWidth;
              double displayHeight = constraints.maxHeight;

              return Stack(
                children: [
                  Image.asset(
                    'assets/images/floorplanwithtrees2.png',
                    width: displayWidth,
                    height: displayHeight,
                    fit: BoxFit.contain,
                  ),
                  ...locations.map((location) {
                    // Calculate exact position without scaling issues
                    double xPosition = (location.x / originalImageWidth) * displayWidth;
                    double yPosition = (location.y / originalImageHeight) * displayHeight;

                    return Positioned(
                      left: xPosition,
                      top: yPosition,
                      child: GestureDetector(
                        onTap: () => _showLocationDetails(context, location),
                        child: CircleAvatar(
                          radius: 10, // Make the icons a bit smaller
                          backgroundColor: Colors.red,
                          child: Text(
                            location.id.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _showLocationDetails(BuildContext context, TourLocation location) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var appLoc = AppLocalizations.of(context)!;
        bool isGerman = appLoc.localeName == 'de';
        bool isHistorical = Provider.of<TourTypeProvider>(context, listen: false).tourType == 'historical';

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
                  Image.asset(
                    'assets/images/${location.mainImageName}',
                    fit: BoxFit.cover,
                  ),
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
                      options: CarouselOptions(
                        height: 200,
                        enableInfiniteScroll: false,
                        enlargeCenterPage: true,
                      ),
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
                              child: Image.asset(
                                'assets/images/$imageName',
                                fit: BoxFit.cover,
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
        );
      },
    );
  }
}
