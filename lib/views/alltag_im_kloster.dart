import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AllTagImKloster extends StatefulWidget {
  @override
  _AllTagImKlosterState createState() => _AllTagImKlosterState();
}

class _AllTagImKlosterState extends State<AllTagImKloster> {
  final Color primaryColor = Color(0xFFB0943C);
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final String introText =
      "Wie sieht denn ein Tag im Leben eines Mönchs aus? Diese Frage wird uns "
      "immer wieder gestellt, wenn Gruppen uns besuchen. Die äussere Struktur, "
      "der Tagesablauf, ist dabei schnell erzählt. Um seinem tieferen Sinn auf die "
      "Spur zu kommen, muss man ihn leben. Dann entdeckt man: Es geht um nichts "
      "weniger als um die Begegnung mit Gott.";

  final List<Map<String, dynamic>> dailySchedule = [
    {'time': '05:30 Uhr', 'title': 'Vigil', 'description': '...', 'icon': Icons.light},
    {'time': '', 'title': 'Frühstück und Betrachtung', 'description': '...', 'icon': Icons.wb_twilight},
    {'time': '07:15 Uhr', 'title': 'Laudes', 'description': '...', 'icon': Icons.wb_sunny},
    {'time': '', 'title': 'Arbeitszeit', 'description': '...', 'icon': Icons.work_off_rounded},
    {'time': '11:15 Uhr', 'title': 'Konventamt und Mittagsgebet', 'description': '...', 'icon': Icons.church},
    {'time': '12:15 Uhr', 'title': 'Mittagessen und Rekreation', 'description': '...', 'icon': Icons.restaurant},
    {'time': '16:30 Uhr', 'title': 'Vesper und Salve Regina', 'description': '...', 'icon': Icons.nightlight},
    {'time': '', 'title': 'Geistliche Lesung', 'description': '...', 'icon': Icons.menu_book},
    {'time': '18:30 Uhr', 'title': 'Abendessen und Rekreation', 'description': '...', 'icon': Icons.coffee},
    {'time': '19:55 Uhr', 'title': 'Totengedenken, geistliche Lesung und Komplet', 'description': '...', 'icon': Icons.bedtime},
  ];

  List<Map<String, dynamic>> get _timelineEvents =>
      dailySchedule.where((event) => event['time']!.isNotEmpty).toList();

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          appLoc.alltagImKloster,
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 2,
      ),
      body: Stack(
        children: [
          _buildParallaxBackground(),
          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: dailySchedule.length + 1, // +1 for the intro page
                  onPageChanged: (index) {
                    setState(() => _currentIndex = index);
                  },
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return _buildIntroPage();
                    } else {
                      return _buildEventCard(dailySchedule[index - 1]);
                    }
                  },
                ),
              ),
              if (_currentIndex != 0) _buildWhiteNavigationBar(),
            ],
          ),
        ],
      ),
    );
  }

  /// **🌄 Fixed Parallax Background Effect**
  Widget _buildParallaxBackground() {
    return Positioned.fill(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              double offset = (_pageController.hasClients ? _pageController.page ?? 0 : 0) * -50;
              return Transform.translate(
                offset: Offset(offset, 0),
                child: Image.asset(
                  'assets/images/DSC_0734-Pano.jpg', // ✅ Panorama Background
                  fit: BoxFit.cover,
                  width: constraints.maxWidth,
                  height: constraints.maxHeight * 1.2, // ✅ Ensures full coverage
                ),
              );
            },
          );
        },
      ),
    );
  }

  /// **📜 Intro Page**
  Widget _buildIntroPage() {
    return _buildWhiteCard(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30), // ✅ Reduced vertical padding
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Ein Tag im Kloster",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: primaryColor),
          ),
          SizedBox(height: 15),
          Text(
            introText,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.black87),
          ),
          SizedBox(height: 25),
          ElevatedButton(
            onPressed: () {
              _pageController.animateToPage(
                1,
                duration: Duration(milliseconds: 700),
                curve: Curves.easeInOut,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text("Zum Tagesablauf", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  /// **🕰️ Event Card**
  Widget _buildEventCard(Map<String, dynamic> event) {
    return _buildWhiteCard(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20), // ✅ Reduced height to avoid app bar overlap
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(event['icon'], size: 50, color: primaryColor),
          SizedBox(height: 8),
          Text(event['time'].isNotEmpty ? event['time'] : '', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: primaryColor)),
          SizedBox(height: 6),
          Text(event['title'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          SizedBox(height: 8),
          Text(event['description'], textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
        ],
      ),
    );
  }

  /// **📅 White Navigation Bar**
  Widget _buildWhiteNavigationBar() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white, // ✅ Fully white background
        border: Border(top: BorderSide(color: primaryColor, width: 2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _timelineEvents.asMap().entries.map((entry) {
          Map<String, dynamic> event = entry.value;
          int targetIndex = dailySchedule.indexWhere((e) => e['time'] == event['time']) + 1;
          bool isSelected = _currentIndex == targetIndex;

          return GestureDetector(
            onTap: () {
              _pageController.animateToPage(
                targetIndex,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
              setState(() => _currentIndex = targetIndex);
            },
            child: Column(
              children: [
                Icon(event['icon'], size: 28, color: isSelected ? primaryColor : Colors.black54),
                SizedBox(height: 4),
                Text(event['time'], style: TextStyle(fontSize: 12, color: isSelected ? primaryColor : Colors.black54)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  /// **✅ White Card Wrapper**
  Widget _buildWhiteCard({required Widget child, EdgeInsets? padding}) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 6,
        child: Padding(padding: EdgeInsets.all(16), child: child),
      ),
    );
  }
}
