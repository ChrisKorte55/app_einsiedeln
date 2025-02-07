import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '/services/locale_provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
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
              child: const Text(
                'DE | EN',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(176, 148, 60, 1),
              ),
              child: Text(
                appLoc.drawerHeader,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            ListTile(
              title: Text(appLoc.aboutTheKloister),
              onTap: () {
                Navigator.pushNamed(context, '/about_us_page');
              },
            ),
            ListTile(
              title: Text(appLoc.eventsCalendar),
              onTap: () {
                Navigator.pushNamed(context, '/events_calendar_page');
              },
            ),
            ListTile(
              title: Text(appLoc.liveStream),
              onTap: () {
                Navigator.pushNamed(context, '/live_stream_page');
              },
            ),
            ListTile(
              title: Text(appLoc.selfGuidedTour),
              onTap: () {
                Navigator.pushNamed(context, '/self_guided_tour_page');
              },
            ),
            ListTile(
              title: Text(appLoc.onlineShop),
              onTap: () {
                Navigator.pushNamed(context, '/online_shop_page');
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2, // This gives the image 2/3 of the available space
            child: Image.asset(
              'images/DSC_0754.jpg',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Expanded(
            flex: 1, // This gives the text 1/3 of the available space
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      appLoc.welcomeMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10), // Space between texts
                    Text(
                      appLoc.welcomeMonks, // Example additional text
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
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
}
