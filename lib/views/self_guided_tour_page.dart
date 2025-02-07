import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'tour_location_detail_views.dart';

class TourLocation extends StatefulWidget {
  final String tourType; // "religious" or "historical"

  const TourLocation({Key? key, required this.tourType}) : super(key: key);

  @override
  TourLocationState createState() => TourLocationState();
}

class TourLocationState extends State<TourLocation> {
  String tourIntroText = "Loading...";
  List<Map<String, dynamic>> locations = [];

  @override
  void initState() {
    super.initState();
    _loadTourData();
  }

  Future<void> _loadTourData() async {
    final csvData = await rootBundle.loadString('assets/kloster_tour_texts.csv');
    List<List<dynamic>> csvList = CsvToListConverter(eol: '\n', shouldParseNumbers: false).convert(csvData);

    if (csvList.isNotEmpty) {
      csvList.removeAt(0); // Remove header row

      final locale = Localizations.localeOf(context).languageCode;
      bool isGerman = locale == "de";

      // Determine the correct column index
      int columnIndex = widget.tourType == 'religious' ? (isGerman ? 6 : 7) : (isGerman ? 4 : 5);

      setState(() {
        tourIntroText = csvList[0][columnIndex].toString(); // Load the intro text

        // Extract correct tour data
        locations = csvList.map((row) {
          return {
            'name': row[1].toString(),
            'description': row[columnIndex].toString(),
            'imageName': row[8].toString(),
            'x': double.parse(row[9].toString()),
            'y': double.parse(row[10].toString()),
          };
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tourType == 'religious' ? appLoc.religiousTour : appLoc.historyTour),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tourIntroText,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: locations.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          InteractiveBlueprint(
                            locations: locations,
                            imagePath: 'assets/images/floorplan.png',
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: locations.length,
                            itemBuilder: (context, index) {
                              var location = locations[index];
                              return ListTile(
                                leading: const Icon(Icons.location_on),
                                title: Text(location['name']),
                                subtitle: Text(location['description']),
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
                    ),
            ),
          ],
        ),
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

        // Calculate the displayed height of the image to maintain the aspect ratio
        const double imageIntrinsicWidth = 1000.0; // Image's actual width
        const double imageIntrinsicHeight = 1000.0; // Image's actual height

        double imageHeight = screenWidth * (imageIntrinsicHeight / imageIntrinsicWidth);

        return Stack(
          children: [
            SizedBox(
              width: screenWidth,
              height: imageHeight,
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain, // Ensure the image is completely visible
              ),
            ),
            ...locations.map((location) {
              double scaledX = (location['x'] as double) / imageIntrinsicWidth * screenWidth;
              double scaledY = (location['y'] as double) / imageIntrinsicHeight * imageHeight;
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
