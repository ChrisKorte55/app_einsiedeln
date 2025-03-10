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
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: (MediaQuery.of(context).size.width / 2) / 150,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: <Widget>[
                      TourButton(label: appLoc.alltagImKloster, imagePath: 'assets/images/05_Herz-Jesu-009.jpg'),
                      TourButton(label: appLoc.historyPage, imagePath: 'assets/images/03_Decken_und_Boden-008.jpg'),
                      TourButton(label: appLoc.gemeinschaft, imagePath: 'assets/images/kloster_saint_trees.jpg'),
                      TourButton(label: 'New Button 2', imagePath: 'assets/images/03_Decken_und_Boden-008.jpg'),
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

class TourButton extends StatelessWidget {
  final String label;
  final String imagePath;

  const TourButton({Key? key, required this.label, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.45,
      height: 150,
      child: ElevatedButton(
        onPressed: () {
          // Implement navigation or action
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 20),
          backgroundColor: Colors.transparent,
          elevation: 0,  // Removed shadow
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),  // Less rounded corners
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),  // Less rounded corners for image
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.black.withValues(alpha: 0.2),
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
