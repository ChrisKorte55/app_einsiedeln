import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'package:app_einsiedeln/models/tour_location_csv.dart';

class TourDataLoader {
  Future<List<TourLocation>> loadTourData(String tourType, bool isGerman) async {
    final csvData = await rootBundle.loadString('assets/kloster_tour_texts.csv');
    List<List<dynamic>> rows = const CsvToListConverter().convert(csvData);
    rows.removeAt(0); // Remove headers

    // Determine the correct column indices based on tour type and language
    int descriptionIndexHistorical = tourType == 'religious' ? (isGerman ? 2 : 3) : (isGerman ? 4 : 5);
    int descriptionIndexSpiritual = tourType == 'religious' ? (isGerman ? 4 : 5) : (isGerman ? 2 : 3);

    List<TourLocation> locations = [];
    for (var row in rows) {
      // Ensure the row has enough elements to prevent "index out of range" errors
      if (row.length >= 10) {
        locations.add(TourLocation(
          id: int.tryParse(row[0]?.toString() ?? '0') ?? 0,
          name: row[1]?.toString() ?? 'Unknown',
          descriptionGermanHistorical: row[descriptionIndexHistorical]?.toString() ?? 'No description available',
          descriptionEnglishHistorical: row[descriptionIndexHistorical + 1]?.toString() ?? 'No description available',
          descriptionGermanSpiritual: row[descriptionIndexSpiritual]?.toString() ?? 'No description available',
          descriptionEnglishSpiritual: row[descriptionIndexSpiritual + 1]?.toString() ?? 'No description available',
          mainImageName: row[6]?.toString() ?? '',
          otherImageNames: row[7]?.toString().split(' ') ?? [],
          x: double.tryParse(row[8]?.toString() ?? '0.0') ?? 0.0,
          y: double.tryParse(row[9]?.toString() ?? '0.0') ?? 0.0,
        ));
      } else {
        // Optionally, log or handle rows with insufficient data
        print('Skipping row with insufficient data: $row');
      }
    }
    return locations;
  }
}
