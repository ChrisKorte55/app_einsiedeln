import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // if you are using localization

class CustomNavigationBar extends StatefulWidget {
  final int selectedIndex;

  const CustomNavigationBar({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  void _navigateTo(int index) {
    if (index != widget.selectedIndex) {
      String routeName = _getRouteForIndex(index);
      Navigator.pushReplacementNamed(context, routeName);
    }
  }

  String _getRouteForIndex(int index) {
    switch (index) {
      case 0: return '/';
      case 1: return '/events_calendar_page';
      case 2: return '/live_stream_page';
      case 3: return '/salve_newsletter_page';
      case 4: return '/guided_tour_home';
      case 5: return '/online_shop_page';
      default: return '/';
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;

    return Theme(
      data: Theme.of(context).copyWith(
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Color.fromRGBO(176, 148, 60, 1),
          unselectedItemColor: Colors.black,
          selectedLabelStyle: TextStyle(fontSize: 10),
          unselectedLabelStyle: TextStyle(fontSize: 10),
          backgroundColor: Colors.white, // Ensuring the background is white
        ),
      ),
      child: SafeArea(
        bottom: true,
        child: BottomNavigationBar(
          currentIndex: widget.selectedIndex,
          onTap: _navigateTo,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
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
      ),
    );
  }
}
