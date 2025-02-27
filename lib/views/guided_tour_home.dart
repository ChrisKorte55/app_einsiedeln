import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_einsiedeln/services/tour_type_provider.dart';  // Make sure this path is correct
import 'tour_location_detail_views.dart';  // Make sure this path is correct

class GuidedTourHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Tour Type'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Provider.of<TourTypeProvider>(context, listen: false).setTourType('historical');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TourLocationDetailView()),
                );
              },
              child: Text('Historical Tour'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Provider.of<TourTypeProvider>(context, listen: false).setTourType('spiritual');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TourLocationDetailView()),
                );
              },
              child: Text('Spiritual Tour'),
            ),
          ],
        ),
      ),
    );
  }
}
