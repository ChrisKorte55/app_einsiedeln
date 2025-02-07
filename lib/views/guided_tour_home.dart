import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'self_guided_tour_page.dart'; // Import the next page

class TourLangHome extends StatelessWidget {
  const TourLangHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!; // Fetch localized strings

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/images/DSC_6772.jpg', // Replace with the correct image asset
            fit: BoxFit.cover,
          ),

          // Overlay for better readability
          Container(
            color: const Color.fromRGBO(0, 0, 0, 0.4), // Semi-transparent overlay
          ),

          // Centered Content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                appLoc.tourHomeText,
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
                title: appLoc.religiousTour,
                icon: Icons.church,
                tourType: 'religious',
              ),
              const SizedBox(height: 30),
              _buildTourButton(
                context,
                title: appLoc.historyTour,
                icon: Icons.history,
                tourType: 'historical',
              ),
            ],
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
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
          elevation: 4,
        ),
        icon: Icon(icon, color: Colors.black, size: 28),
        label: Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
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
