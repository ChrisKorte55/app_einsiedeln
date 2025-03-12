import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_einsiedeln/services/tour_type_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'tour_location_detail_views.dart';

class GuidedTourHome extends StatelessWidget {
  final Color accentColor = const Color.fromRGBO(176, 148, 60, 1); // Accent color throughout the layout

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!; // Safely unwrap as it's confirmed to be non-null in this context

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Text(
                'Explore our guided tours: Spiritual & Historic',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: accentColor,),
                textAlign: TextAlign.center,
              ),
            ),
            _buildButtonWithBackground(
              context,
              label: appLoc.spiritualTour,
              imagePath: 'assets/images/05_Herz-Jesu-009.jpg',
              onPressed: () {
                Provider.of<TourTypeProvider>(context, listen: false).setTourType('spiritual');
                Navigator.push(context,MaterialPageRoute(builder: (context) => TourLocationDetailView()),);
              },
            ),
            const SizedBox(height: 20),
            _buildButtonWithBackground(
              context,
              label: appLoc.historicalTour,
              imagePath: 'assets/images/03_Decken_und_Boden-008.jpg',
              onPressed: () {
                Provider.of<TourTypeProvider>(context, listen: false).setTourType('historical');
                Navigator.push(context, MaterialPageRoute(builder: (context) => TourLocationDetailView()),);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonWithBackground(BuildContext context, {required String label, required String imagePath, required VoidCallback onPressed}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6, // Adjusted width to reflect 60% of the screen
      height: 150, // Height for better image visibility
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 20),
          backgroundColor: Colors.transparent, // Button background is transparent to allow image visibility
          shadowColor: Colors.black45,
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0),),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(imagePath, fit: BoxFit.cover,),
            ),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: Colors.black.withValues(alpha: 0.3),),
              alignment: Alignment.center,
              child: Text(label, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white,), textAlign: TextAlign.center,),
            ),
          ],
        ),
      ),
    );
  }
}
