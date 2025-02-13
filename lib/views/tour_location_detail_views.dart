import 'package:flutter/material.dart';

class LocationDetailPage extends StatelessWidget {
  final String locationName;
  final String description;
  final String imageName;

  const LocationDetailPage({
    Key? key,
    required this.locationName,
    required this.description,
    required this.imageName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(locationName, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              'assets/images/$imageName',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 250,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: double.infinity,
                  height: 250,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    description,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400, height: 1.5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
