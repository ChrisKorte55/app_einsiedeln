import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomNavigationBar({
    Key? key, 
    required this.selectedIndex, 
    required this.onItemTapped
  }) : super(key: key);

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    final bottomPadding = MediaQuery.of(context).padding.bottom; // Get bottom inset for iPhones

    return Theme(
      data: Theme.of(context).copyWith(
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Color.fromRGBO(176, 148, 60, 1),
          unselectedItemColor: Colors.black,
          selectedLabelStyle: TextStyle(fontSize: 10),
          unselectedLabelStyle: TextStyle(fontSize: 10),
          backgroundColor: Colors.white,
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(bottom: bottomPadding > 0 ? bottomPadding - 5 : 10), // Adjust for curved iPhones
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)), // Slight rounding for modern look
          color: Colors.white, // Ensures seamless blend with UI
        ),
        child: BottomNavigationBar(
          currentIndex: widget.selectedIndex,
          onTap: widget.onItemTapped,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.event), label: appLoc.eventsCalendar),
            BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: appLoc.liveStream),
            BottomNavigationBarItem(icon: Icon(Icons.mail_outline), label: appLoc.newsLetter),
            BottomNavigationBarItem(icon: Icon(Icons.map), label: appLoc.selfGuidedTour),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: appLoc.onlineShop),
          ],
        ),
      ),
    );
  }
}
