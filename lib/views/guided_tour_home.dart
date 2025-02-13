import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'self_guided_tour_page.dart'; // Ensure this is the correct import path for the next page

class TourLangHome extends StatelessWidget {
  const TourLangHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context); // Attempt to fetch localized strings

    // Safely access localized text with a null check
    final String titleText = appLoc?.tourHomeText ?? 'Default Title Text'; // Provide a default value

    return Scaffold(
      appBar: AppBar(
        title: Text(titleText), // Use the safely accessed or default title
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/DSC_6772.jpg', // Ensure you have this image in assets
            fit: BoxFit.cover,
          ),
          Container(
            color: const Color.fromRGBO(0, 0, 0, 0.4), // Semi-transparent overlay for text visibility
          ),
          Center( // Centered column for buttons
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  titleText, // Use the localized or default text
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),
                _buildTourButton(
                  context,
                  title: appLoc?.religiousTour ?? 'Religious Tour', // Safely accessed localized string with fallback
                  icon: Icons.church,
                  tourType: 'religious',
                ),
                const SizedBox(height: 30),
                _buildTourButton(
                  context,
                  title: appLoc?.historyTour ?? 'History Tour', // Safely accessed localized string with fallback
                  icon: Icons.history,
                  tourType: 'historical',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTourButton(
    BuildContext context, {
    required String title,
    required IconData icon,
    required String tourType,
  }) {
    return SizedBox(
      width: 280,
      height: 70,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white, // Updated from 'primary'
          foregroundColor: Colors.black, // Text and icon color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
          elevation: 4,
        ),
        icon: Icon(icon, size: 28),
        label: Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TourLocation(tourType: tourType),
            ),
          );
        },
      ),
    );
  }
}
