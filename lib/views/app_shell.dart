import 'package:flutter/material.dart';
import '/views/main_page.dart';
import '/views/events_calendar_page.dart';
// import '/views/about_us_page.dart';  // Uncomment or remove if not used
import '/views/live_stream_page.dart';
import '/views/online_shop_page.dart';
import '/views/guided_tour_home.dart';
import '/views/salve_newsletter_page.dart';
import '/widgets/custom_navigation_bar.dart';

class AppShell extends StatefulWidget {
  @override
  _AppShellState createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    MainPage(),           // Home page
    EventsPage(), 
    LiveStreamPage(), // Assumed correct class name for the events page
    GuidedTourHome(), 
    SalvePage(),    // Guided tour pag    // Live stream page
    OnlineShopPage(),     // Online shop page// Newsletter page
    // AboutUsPage(),      // Uncomment this if you add the AboutUsPage later
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;  // Change the index state to refresh IndexedStack
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,  // This stack manages the visibility of pages
      ),
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: _selectedIndex,  // Current page index
        onItemTapped: _onItemTapped,     // Callback for handling page changes
      ),
    );
  }
}
