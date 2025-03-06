import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    _timer?.cancel();  // Properly cancel the timer
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
            Container(
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
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    appLoc.welcomeTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 35, color: Color.fromRGBO(176, 148, 60, 1), fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    appLoc.welcomeMonks,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  SizedBox(height: 20),
                  TourButton(label: appLoc.spiritualTour, imagePath: 'assets/images/05_Herz-Jesu-009.jpg'),
                  SizedBox(height: 20),
                  TourButton(label: appLoc.historicalTour, imagePath: 'assets/images/03_Decken_und_Boden-008.jpg'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TourButton extends StatelessWidget {
  final String label;
  final String imagePath;

  const TourButton({Key? key, required this.label, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      height: 150,
      child: ElevatedButton(
        onPressed: () {
          // Implement navigation or action
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 20),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.black45,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.black.withValues(alpha: 0.1),
              ),
              alignment: Alignment.center,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
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
