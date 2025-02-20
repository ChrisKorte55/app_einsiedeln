import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '/services/locale_provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    final primaryColor = Color.fromRGBO(176, 148, 60, 1);  // Main golden color
    final appBarColor = Color.fromRGBO(245, 245, 245, 1);  // Cream color for AppBar
    final highlightColor = Color.fromRGBO(53, 42, 102, 1);  // Dark blue for contrast

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,  // Cream colored AppBar
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu, color: Colors.black),  // Black icon for contrast
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
              onTap: () {
                final languageProvider =
                    Provider.of<LanguageProvider>(context, listen: false);
                Locale newLocale = Localizations.localeOf(context).languageCode == 'de'
                    ? const Locale('en')
                    : const Locale('de');
                languageProvider.setLocale(newLocale);
              },
              child: Text(
                'DE | EN',
                style: TextStyle(color: Colors.black, fontSize: 20),  // Black text for visibility
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 120,  // Increased height for better visual impact
              child: DrawerHeader(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: primaryColor,  // Golden color for the header
                ),
                child: Text(
                  appLoc.drawerHeader,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            _buildDrawerItem(Icons.info_outline, appLoc.aboutTheKloister, context, '/about_us_page'),
            _buildDrawerItem(Icons.event, appLoc.eventsCalendar, context, '/events_calendar_page'),
            _buildDrawerItem(Icons.live_tv, appLoc.liveStream, context, '/live_stream_page'),
            _buildDrawerItem(Icons.mail_outline, appLoc.newsLetter, context, '/salve_newsletter_page'),
            _buildDrawerItem(Icons.map, appLoc.selfGuidedTour, context, '/self_guided_tour_page'),
            _buildDrawerItem(Icons.shopping_cart, appLoc.onlineShop, context, '/online_shop_page'),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Image.asset(
              'images/DSC_0754.jpg',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      appLoc.welcomeMessage,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      appLoc.welcomeMonks,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, BuildContext context, String routeName) {
    return ListTile(
      leading: Icon(icon, color: Color.fromRGBO(53, 42, 102, 1)),  // Dark blue icons for contrast
      title: Text(title),
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
    );
  }
}
