import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;

    return Stack(
      children: [
        BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.info_outline),
              label: appLoc.aboutTheKloister,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.event),
              label: appLoc.eventsCalendar,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.live_tv),
              label: appLoc.liveStream,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mail_outline),
              label: appLoc.newsLetter,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: appLoc.selfGuidedTour,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: appLoc.onlineShop,
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 10,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withAlpha(128), // Equivalent to Colors.white.withOpacity(0.5)
                  Colors.white.withAlpha(0),   // Equivalent to Colors.white.withOpacity(0.0)
                ],
                stops: [0.0, 1.0],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
