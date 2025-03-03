import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_einsiedeln/services/tour_type_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '/widgets/custom_navigation_bar.dart'; // Ensure this path is correct
import 'tour_location_detail_views.dart';

class GuidedTourHome extends StatelessWidget {
  final Color accentColor = const Color.fromRGBO(176, 148, 60, 1);

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!; // Get localized strings

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "appLoc.selectTourType", // Correct this to actually use the localized string
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 2,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/kloster_mountains_vert.JPG',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildButton(
                  context,
                  label: appLoc.historicalTour,
                  onPressed: () {
                    Provider.of<TourTypeProvider>(context, listen: false).setTourType('historical');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TourLocationDetailView()),
                    );
                  },
                ),
                const SizedBox(height: 20),
                _buildButton(
                  context,
                  label: appLoc.spiritualTour,
                  onPressed: () {
                    Provider.of<TourTypeProvider>(context, listen: false).setTourType('spiritual');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TourLocationDetailView()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: 4, // Set this to the correct index for the Guided Tour Home page
      ),
    );
  }

  Widget _buildButton(BuildContext context, {required String label, required VoidCallback onPressed}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6, // Make the button 80% of screen width
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 20),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          elevation: 5,
          shadowColor: Colors.black45,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: Text(label),
      ),
    );
  }
}
