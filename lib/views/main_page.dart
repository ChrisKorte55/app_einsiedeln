import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '/services/locale_provider.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> _imagePaths = [
    'assets/images/kloster_front_snow_vert.jpg',
    'assets/images/kloster_statue_vert.jpg',
    'assets/images/kloster_grass_vert.jpg',
  ];

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < _imagePaths.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
              height: 70,
              child: DrawerHeader(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Text(
                  appLoc.drawerHeader,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            _buildDrawerItem(Icons.info_outline, appLoc.aboutTheKloister, context, '/about_us_page'),
            _buildDrawerItem(Icons.event, appLoc.eventsCalendar, context, '/events_calendar_page'),
            _buildDrawerItem(Icons.live_tv, appLoc.liveStream, context, '/live_stream_page'),
            _buildDrawerItem(Icons.mail_outline, appLoc.newsLetter, context, '/salve_newsletter_page'),
            _buildDrawerItem(Icons.map, appLoc.selfGuidedTour, context, '/guided_tour_home'),
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
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _imagePaths.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      _imagePaths[index],
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    );
                  },
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
                            style: const TextStyle(fontSize: 18, color: Colors.black),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            appLoc.welcomeMonks,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 14, color: Colors.grey),
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
              icon: const Icon(Icons.menu, color: Colors.white),
              iconSize: 40.0,
              onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            right: 10,
            child: GestureDetector(
              onTap: () {
                final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
                Locale newLocale = Localizations.localeOf(context).languageCode == 'de'
                    ? const Locale('en')
                    : const Locale('de');
                languageProvider.setLocale(newLocale);
              },
              child: const Text(
                'DE | EN',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 7,
            left: MediaQuery.of(context).size.width / 2 - 100,
            child: Image.asset(
              'assets/images/klosterbirds.png',
              width: 200,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, BuildContext context, String routeName) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(title, style: const TextStyle(color: Colors.black)),
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
    );
  }
}
