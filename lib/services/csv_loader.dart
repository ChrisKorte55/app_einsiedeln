import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'package:app_einsiedeln/models/tour_location_csv.dart';

class TourDataLoader {
  Future<List<TourLocation>> loadTourData(String tourType, bool isGerman) async {
    final csvData = await rootBundle.loadString('assets/kloster_tour_texts.csv');
    List<List<dynamic>> rows = const CsvToListConverter().convert(csvData);
    rows.removeAt(0); // Remove headers

    List<TourLocation> locations = [];
    for (var row in rows) {
      // Ensure the row has enough elements to prevent "index out of range" errors
      if (row.length >= 10) {
        locations.add(TourLocation(
          id: int.tryParse((row[0]?.toString() ?? '0').trim()) ?? 0, // Handle null safely
          name: (row[1]?.toString() ?? 'Unknown').trim(),
          descriptionGermanHistorical: (row[2]?.toString() ?? 'No historical description (German) available').trim(),
          descriptionEnglishHistorical: (row[3]?.toString() ?? 'No historical description (English) available').trim(),
          descriptionGermanSpiritual: (row[4]?.toString() ?? 'No spiritual description (German) available').trim(),
          descriptionEnglishSpiritual: (row[5]?.toString() ?? 'No spiritual description (English) available').trim(),
          mainImageName: (row[6]?.toString() ?? '').trim(),
          otherImageNames: (row[7]?.toString().trim().split(' ') ?? []),
          x: double.tryParse((row[8]?.toString() ?? '0.0').trim()) ?? 0.0,
          y: double.tryParse((row[9]?.toString() ?? '0.0').trim()) ?? 0.0,
        ));
      } else {
        print('Skipping row with insufficient data: $row');
      }
    }
    return locations;
  }
}
