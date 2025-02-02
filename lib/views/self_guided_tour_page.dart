import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'tour_location_detail_views.dart';

void main() {
  runApp(MaterialApp(home: TourLocation()));
}

class TourLocation extends StatefulWidget {
  const TourLocation({Key? key}) : super(key: key);

  @override
  TourLocationState createState() => TourLocationState();
}

class TourLocationState extends State<TourLocation> {
  Future<List<Map<String, dynamic>>> loadCSV() async {
    final csvData = await rootBundle.loadString('assets/kloster_tour_texts.csv');
    List<List<dynamic>> csvList = CsvToListConverter(eol: '\n', shouldParseNumbers: false).convert(csvData);

    csvList.forEach((row) {
      print("Row data: $row, Length: ${row.length}");
    });

    csvList.removeAt(0); // Remove header

    return csvList.map<Map<String, dynamic>>((List<dynamic> row) {
      if (row.length < 6) {
        print("Error: Row does not contain enough elements: $row");
        return {};
      }

      return {
        'name': row[1].toString(),
        'description': row[2].toString(),
        'imageName': row[6].toString(),
        'x': double.parse(row[7].toString()),
        'y': double.parse(row[8].toString()),
      };
    }).where((location) => location.isNotEmpty).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tour Locations"),
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
                    imagePath: 'assets/floorplan.png',
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
              if (location.isEmpty) return SizedBox.shrink();
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