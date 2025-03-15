import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:app_einsiedeln/views/benediktiner.dart';
import 'package:app_einsiedeln/views/gemeinschaft.dart';
import 'package:app_einsiedeln/views/guided_tour_home.dart';
import 'package:app_einsiedeln/views/history.dart';
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
    final size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section with Refined Fade Effect
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // Slideshow Background
                SizedBox(
                  height: size.height * 0.75,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _imagePaths.length,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        _imagePaths[index],
                        fit: BoxFit.cover,
                        width: size.width,
                      );
                    },
                  ),
                ),

                // Top Overlay for Readability
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black.withValues(alpha: 76), Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ),

                // **🔥 Improved Fade Effect at the Bottom 🔥**
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 140, // Adjusted height for smoother blending
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withValues(alpha: 100),
                          Colors.white.withValues(alpha: 150), // Softer white to prevent harsh contrast
                          Colors.white.withValues(alpha: 200),
                          Colors.white.withValues(alpha: 240),
                          Colors.white.withValues(alpha: 300),
                          Colors.transparent // More gradual fade
                        ],
                        stops: [0.0, 0.1, 0.3, 0.5, 0.6, 1.0],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ),

                // Hero Text & Call-to-Action Button
                Positioned(
                  bottom: 120,
                  child: Column(
                    children: [
                      Text(
                        appLoc.welcome,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          shadows: [Shadow(offset: Offset(0.0, 0.0), blurRadius: 10.0, color: Colors.black26)],
                        ),
                      ),
                      Text(
                        appLoc.klosterName,
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [Shadow(offset: Offset(0.0, 0.0), blurRadius: 12.0, color: Colors.black45)],
                        ),
                      ),
                      SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => GuidedTourHome()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(176, 148, 60, 1),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          elevation: 6,
                        ),
                        child: Text(
                          'Explore Tours',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // **✅ Fix: Explicitly Set White Background for Content**
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Column(
                children: [
                  Text(
                    appLoc.introTextwelcome,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  SizedBox(height: 15),
                  Text(
                    appLoc.welcomeMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.black87),
                  ),
                  SizedBox(height: 20),
                  Text(
                    appLoc.welcomeMonks,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            // **✅ Fix: Explicitly Set White Background Behind Buttons**
            Container(
              color: Colors.white, // Ensure consistent white background
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: [
                  AboutUsButton(label: appLoc.alltagImKloster, imagePath: 'assets/images/kloster_grass_horz.jpg', onPressed: () => _navigateTo(AllTagImKloster())),
                  AboutUsButton(label: appLoc.historyPage, imagePath: 'assets/images/03_Decken_und_Boden-008.jpg', onPressed: () => _navigateTo(KlosterHistoryPage())),
                  AboutUsButton(label: appLoc.gemeinschaft, imagePath: 'assets/images/kloster_saint_trees_horz.jpg', onPressed: () => _navigateTo(Gemeinschaft())),
                  AboutUsButton(label: appLoc.benediktiner, imagePath: 'assets/images/kloster_hallway.jpg', onPressed: () => _navigateTo(Benediktiner())),
                ],
              ),
            ),

            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  void _navigateTo(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}



// **🔥 About Us Button - Modernized Card Style 🔥**
class AboutUsButton extends StatelessWidget {
  final String label;
  final String imagePath;
  final VoidCallback onPressed;

  const AboutUsButton({Key? key, required this.label, required this.imagePath, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(imagePath, fit: BoxFit.cover),
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
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white, shadows: [Shadow(offset: Offset(0.0, 0.0), blurRadius: 8.0, color: Colors.black54)]),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
