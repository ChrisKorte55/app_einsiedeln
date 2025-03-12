import 'dart:async';
import 'package:app_einsiedeln/views/benediktiner.dart';
import 'package:app_einsiedeln/views/gemeinschaft.dart';
import 'package:app_einsiedeln/views/guided_tour_home.dart';
import 'package:app_einsiedeln/views/history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'alltag_im_kloster.dart'; 

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController _pageController = PageController();
  Timer? _timer;
  int _currentPage = 0;

  final List<String> _imagePaths = [
    'assets/images/kloster_front_snow_vert.jpg',
    'assets/images/kloster_statue_vert.jpg',
    'assets/images/kloster_grass_vert.jpg',
    'assets/images/kloster_sunset.jpg',
    'assets/images/kloster_chandelier.jpg',
    'assets/images/kloster_facade.jpg'
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 6), (Timer timer) {
      if (_currentPage < _imagePaths.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;

    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.75,
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
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/images/white_gradient.png',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      appLoc.welcome,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        shadows: [Shadow(offset: Offset(0.0, 0.0), blurRadius: 10.0, color: Color.fromARGB(150, 0, 0, 0),),],
                      ),
                    ),
                    Text(
                      appLoc.klosterName,
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [Shadow(offset: Offset(0.0, 0.0), blurRadius: 10.0, color: Color.fromARGB(150, 0, 0, 0),),],
                      ),
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => GuidedTourHome()),);},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(176, 148, 60, 1),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                        elevation: 4,
                      ),
                      child: Text('Tours'),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 40),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    appLoc.introTextwelcome,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text(
                    appLoc.welcomeMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, color: Colors.black),
                  ),
                  SizedBox(height: 20),
                  Text(
                    appLoc.welcomeMonks,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 20),
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: (MediaQuery.of(context).size.width / 2) / 150,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: <Widget>[
                      AboutUsButton(label: appLoc.alltagImKloster, imagePath: 'assets/images/kloster_grass_horz.jpg', onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => AllTagImKloster()),);},),
                      AboutUsButton(label: appLoc.historyPage, imagePath: 'assets/images/03_Decken_und_Boden-008.jpg', onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => KlosterHistoryPage()),);},),
                      AboutUsButton(label: appLoc.gemeinschaft, imagePath: 'assets/images/kloster_saint_trees_horz.jpg', onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => Gemeinschaft()),);},),
                      AboutUsButton(label: appLoc.benediktiner, imagePath: 'assets/images/kloster_hallway.jpg', onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => Benediktiner()),);},),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class AboutUsButton extends StatelessWidget {
  final String label;
  final String imagePath;
  final VoidCallback onPressed;

  const AboutUsButton({
    Key? key,
    required this.label,
    required this.imagePath,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20), // Rounded corners
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withValues(alpha: 0.5), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Center(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(0.0, 0.0),
                      blurRadius: 10.0,
                      color: Colors.black.withValues(alpha: 0.7),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


