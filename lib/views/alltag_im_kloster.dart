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
    {'time': '05:30 Uhr', 'title': 'Vigil', 'description': '...', 'icon': Icons.nightlight_round},
    {'time': '', 'title': 'Frühstück und Betrachtung', 'description': '...', 'icon': Icons.wb_twilight},
    {'time': '07:15 Uhr', 'title': 'Laudes', 'description': '...', 'icon': Icons.wb_sunny},
    {'time': '', 'title': 'Arbeitszeit', 'description': '...', 'icon': Icons.construction},
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
      body: Column(
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
                  return _buildIntroPage(); // First page is the intro
                } else {
                  return _buildEventCard(dailySchedule[index - 1]); // Events start from index 1
                }
              },
            ),
          ),
          if (_currentIndex != 0) _buildTimeline(), // Hide timeline on intro page
        ],
      ),
    );
  }

  Widget _buildIntroPage() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [primaryColor.withValues(alpha: 0.2), Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Ein Tag im Kloster",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: 20),
              Text(
                introText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  _pageController.animateToPage(
                    1, // Move to the first event
                    duration: Duration(milliseconds: 700),
                    curve: Curves.easeInOut,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Text(
                    "Zum Tagesablauf",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [primaryColor.withValues(alpha: 0.2), Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(event['icon'], size: 60, color: primaryColor),
              SizedBox(height: 10),
              Text(
                event['time'].isNotEmpty ? event['time'] : '',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor),
              ),
              SizedBox(height: 8),
              Text(
                event['title'],
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Text(
                event['description'],
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeline() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
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
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: isSelected ? 35 : 30,
                  height: isSelected ? 35 : 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? primaryColor : Colors.grey[300],
                  ),
                  child: Icon(event['icon'], color: isSelected ? Colors.white : Colors.black),
                ),
                SizedBox(height: 5),
                Text(event['time'], style: TextStyle(color: isSelected ? primaryColor : Colors.black54)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
