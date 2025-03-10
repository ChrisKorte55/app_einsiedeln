import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '/views/main_page.dart';
import '/views/events_calendar_page.dart';
import '/views/live_stream_page.dart';
import '/views/guided_tour_home.dart';
import '/views/salve_newsletter_page.dart';
import '/widgets/custom_navigation_bar.dart';
import '/services/locale_provider.dart';

class AppShell extends StatefulWidget {
  @override
  _AppShellState createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    MainPage(),
    EventsPage(),
    LiveStreamPage(),
    SalvePage(),
    GuidedTourHome(),
  ];

  final List<String> _titles = [
    " ",
    "Events",
    "Live Stream",
    "Salve Newsletter",
    "Guided Tour",
  ];

  void _onItemTapped(int index) async {
    if (index == 5) { // Online Shop index
      final Uri url = Uri.parse('https://shop.kloster-einsiedeln.ch/');
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication); // Opens in external browser
      }
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    bool isLiveStreamPage = _selectedIndex == 2; // Check if LiveStreamPage is active
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);

    return Scaffold(
      appBar: (isLiveStreamPage && isLandscape)
          ? null
          : AppBar(
              title: Text(_titles[_selectedIndex]),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 2,
              leading: IconButton(
                icon: Image.asset('assets/images/kloster_full_logo.png'), // Replace 'assets/kloster_logo.png' with your actual logo asset path
                onPressed: () {
                  setState(() {
                    _selectedIndex = 0; // Navigate to MainPage()
                  });
                },
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      Locale newLocale = Localizations.localeOf(context).languageCode == 'de'
                          ? Locale('en')
                          : Locale('de');
                      languageProvider.setLocale(newLocale);
                    },
                    child: Text(
                      'DE | EN',
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: (isLiveStreamPage && isLandscape)
          ? null
          : CustomNavigationBar(
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
            ),
    );
  }
}
