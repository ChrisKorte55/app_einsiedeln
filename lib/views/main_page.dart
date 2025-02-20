import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '/services/locale_provider.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 120,
              child: DrawerHeader(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(176, 148, 60, 1),  // Main golden color
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
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 3,
                child: Image.asset(
                  'images/DSC_0754.jpg',
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            appLoc.welcomeMessage,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                          SizedBox(height: 10),
                          Text(
                            appLoc.welcomeMonks,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              iconSize: 40.0,  // Adjusted icon size
              onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            right: 10,
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
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, BuildContext context, String routeName) {
    return ListTile(
      leading: Icon(icon, color: Colors.black), // Drawer Icon Color
      title: Text(title, style: TextStyle(color: Colors.black)), // Drawer Text Color 
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
    );
  }
}
