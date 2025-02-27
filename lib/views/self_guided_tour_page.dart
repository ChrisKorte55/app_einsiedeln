/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';  // Localized string handling
import 'tour_location_detail_views.dart'; // Ensure this is the correct import path for LocationDetailPage

class TourLocation extends StatefulWidget {
  final String tourType; // "religious" or "spiritual"

  const TourLocation({Key? key, required this.tourType}) : super(key: key);

  @override
  TourLocationState createState() => TourLocationState();
}

class TourLocationState extends State<TourLocation> {
  Future<List<Map<String, dynamic>>> loadCSV() async {
    try {
      final csvData = await rootBundle.loadString('assets/kloster_tour_texts.csv');
      List<List<dynamic>> csvList = CsvToListConverter(eol: '\n', shouldParseNumbers: false).convert(csvData);

      if (csvList.isNotEmpty) {
        csvList.removeAt(0); // Remove header row
        final locale = Localizations.localeOf(context).languageCode;
        bool isGerman = locale == "de";
        int descriptionIndex = widget.tourType == 'religious' ?
            (isGerman ? 2 : 3) : (isGerman ? 4 : 5);

        return csvList.map((row) {
          return {
            'name': row[1].toString(),
            'description': row[descriptionIndex].toString(),
            'imageName': row[6].toString(),
            'x': double.parse(row[7].toString()),
            'y': double.parse(row[8].toString()),
          };
        }).toList();
      }
    } catch (e) {
      print('Error loading CSV data: $e');
      throw Exception('Failed to load data');
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!; // Access localized strings

    return Scaffold(
      appBar: AppBar(
        title: Text(appLoc.tourHomeText), // Localized title from AppLocalizations
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: loadCSV(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error.toString()}'));
          } else if (snapshot.hasData) {
            var locations = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  InteractiveBlueprint(
                    locations: locations,
                    imagePath: 'assets/images/floorplanwithtrees2.png',
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: locations.length,
                    itemBuilder: (context, index) {
                      var location = locations[index];
                      if (location.isEmpty) {
                        return SizedBox.shrink();
                      }
                      return ListTile(
                        leading: const Icon(Icons.location_on),
                        title: Text(location['name']),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LocationDetailPage(
                                locationName: location['name'],
                                description: location['description'],
                                imageName: location['imageName'],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text("No data available"));
          }
        },
      ),
    );
  }
}

class InteractiveBlueprint extends StatelessWidget {
  final String imagePath;
  final List<Map<String, dynamic>> locations;

  const InteractiveBlueprint({Key? key, required this.imagePath, required this.locations}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double imageHeight = screenWidth; // Assumes a square aspect ratio for simplicity

        return Stack(
          children: [
            SizedBox(
              width: screenWidth,
              height: imageHeight,
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
            ...locations.map((location) {
              double scaledX = (location['x'] as double) * screenWidth;
              double scaledY = (location['y'] as double) * imageHeight;
              return Positioned(
                left: scaledX,
                top: scaledY,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LocationDetailPage(
                          locationName: location['name'],
                          description: location['description'],
                          imageName: location['imageName'],
                        ),
                      ),
                    );
                  },
                  child: const Icon(Icons.location_on, color: Colors.red, size: 40.0),
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