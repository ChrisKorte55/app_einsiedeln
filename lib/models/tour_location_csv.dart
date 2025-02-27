// lib/models/tour_location_csv.dart
class TourLocation {
  final int id;
  final String name;
  final String descriptionGermanHistorical;
  final String descriptionEnglishHistorical;
  final String descriptionGermanSpiritual;
  final String descriptionEnglishSpiritual;
  final String mainImageName;
  final List<String> otherImageNames;
  final double x;
  final double y;

  TourLocation({
    required this.id,
    required this.name,
    required this.descriptionGermanHistorical,
    required this.descriptionEnglishHistorical,
    required this.descriptionGermanSpiritual,
    required this.descriptionEnglishSpiritual,
    required this.mainImageName,
    required this.otherImageNames,
    required this.x,
    required this.y,
  });

  factory TourLocation.fromCsv(List<dynamic> row) {
    return TourLocation(
      id: row[0],
      name: row[1],
      descriptionGermanHistorical: row[2],
      descriptionEnglishHistorical: row[3],
      descriptionGermanSpiritual: row[4],
      descriptionEnglishSpiritual: row[5],
      mainImageName: row[6],
      otherImageNames: row[7].split(' '),
      x: double.parse(row[8].toString()),
      y: double.parse(row[9].toString()),
    );
  }
}
