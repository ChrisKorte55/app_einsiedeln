//services/tour_type_provider.dart
import 'package:flutter/material.dart';

class TourTypeProvider with ChangeNotifier {
  String _tourType = 'religious'; // Default value

  String get tourType => _tourType;

  void setTourType(String newType) {
    if (_tourType != newType) {
      _tourType = newType;
      notifyListeners(); // Notify widgets to rebuild with the new tour type
    }
  }
}
