import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainPage extends StatelessWidget {
  final Function(Locale) onLocaleChange;

  const MainPage({
    Key? key,
    required this.onLocaleChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(appLoc.welcomeTitle),
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
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
              onTap: () {
                Locale newLocale = Localizations.localeOf(context).languageCode == 'de'
                    ? const Locale('en')
                    : const Locale('de');
                onLocaleChange(newLocale);
              },
              child: Text(
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
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: Text(appLoc.eventsCalendar),
              onTap: () {
                Navigator.pop(context); // Optionally close the drawer
              },
            ),
            ListTile(
              title: Text(appLoc.liveStream),
              onTap: () {
                Navigator.pop(context); // Optionally close the drawer
              },
            ),
            ListTile(
              title: Text(appLoc.selfGuidedTour),
              onTap: () {
                Navigator.pop(context); // Optionally close the drawer
              },
            ),
            ListTile(
              title: Text(appLoc.onlineShop),
              onTap: () {
                Navigator.pop(context); // Optionally close the drawer
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
              'images/KlosterInsideMain.jpg',
              fit: BoxFit.cover, // Adjust to fit the content within the current layout space
              width: MediaQuery.of(context).size.width, // Match the screen's width
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
                    SizedBox(height: 10),  // Space between texts
                    Text(
                      appLoc.welcomeMonks,  // Example additional text
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),  // Example style for second text
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
