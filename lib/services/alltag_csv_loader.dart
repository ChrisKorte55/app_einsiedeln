import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

IconData getIconFromOrder(String order) {
  switch (order) {
    case '1':
      return Icons.light;
    case '2':
      return Icons.wb_twilight;
    case '3':
      return Icons.wb_sunny;
    case '4':
      return Icons.work_off_rounded;
    case '5':
      return Icons.church;
    case '6':
      return Icons.restaurant;
    case '7':
      return Icons.nightlight_round;
    case '8':
      return Icons.menu_book;
    case '9':
      return Icons.coffee;
    case '10':
      return Icons.bedtime;
    default:
      return Icons.help_outline; // Default icon if no match
  }
}

Future<List<Map<String, dynamic>>> loadSchedule() async {
  try {
    // Load the CSV data from assets
    final csvData = await rootBundle.loadString('assets/kloster_alltag_texte.csv');
    // Convert CSV data into a List of Lists
    List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter().convert(csvData);
    List<Map<String, dynamic>> loadedSchedule = [];

    // Iterate over each row, skipping the header
    for (var i = 1; i < rowsAsListOfValues.length; i++) {
      var row = rowsAsListOfValues[i];
      IconData icon = getIconFromOrder(row[0].toString());  // Ensure order is a string
      loadedSchedule.add({
        'order': row[0], // Order number from CSV
        'time': row[1], // Time from CSV
        'titleGerman': row[2], // German title from CSV
        'titleEnglish': row[3], // English title from CSV
        'textGerman': row[4], // German text from CSV
        'textEnglish': row[5], // English text from CSV
        'icon': icon, // Dynamically assigned icon
      });
    }

    return loadedSchedule;
  } catch (e) {
    print('Error loading the schedule CSV: $e');
    return []; // Return an empty list in case of failure
  }
}
