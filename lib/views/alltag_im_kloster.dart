import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AllTagImKloster extends StatefulWidget {
  @override
  _AllTagImKlosterState createState() => _AllTagImKlosterState();
}

class _AllTagImKlosterState extends State<AllTagImKloster> {
  final Color primaryColor = Color.fromRGBO(176, 148, 60, 1);
  final PageController _pageController = PageController();

  int _currentIndex = 0;

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

  // Filter only events with actual timestamps for the bottom timeline
  List<Map<String, dynamic>> get _timelineEvents => dailySchedule.where((event) => event['time']!.isNotEmpty).toList();

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          appLoc.alltagImKloster,
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
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
              scrollDirection: Axis.horizontal,
              itemCount: dailySchedule.length,
              onPageChanged: (index) {
                setState(() => _currentIndex = index);
              },
              itemBuilder: (context, index) {
                return _buildEventCard(dailySchedule[index]);
              },
            ),
          ),
          _buildTimeline(),
        ],
      ),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(event['icon'], size: 50, color: primaryColor),
              SizedBox(height: 10),
              Text(
                event['time'].isNotEmpty ? event['time'] : '',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: primaryColor),
              ),
              SizedBox(height: 8),
              Text(
                event['title'],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                event['description'],
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeline() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(
      border: Border(top: BorderSide(color: primaryColor, width: 2)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: _timelineEvents.asMap().entries.map((entry) {
        Map<String, dynamic> event = entry.value; // Removed 'index'
        
        // Get the correct index of this event in the full dailySchedule
        int targetIndex = dailySchedule.indexWhere((e) => e['time'] == event['time']);
        bool isSelected = _currentIndex == targetIndex;

        return GestureDetector(
          onTap: () {
            if (targetIndex != -1) {
              _pageController.animateToPage(
                targetIndex,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
              setState(() {
                _currentIndex = targetIndex; // Update selected event
              });
            }
          },
          child: Column(
            children: [
              Icon(
                event['icon'],
                color: isSelected ? primaryColor : Colors.black,
                size: isSelected ? 30 : 24,
              ),
              SizedBox(height: 5),
              Text(
                event['time'],
                style: TextStyle(
                  fontSize: isSelected ? 14 : 12,
                  color: isSelected ? primaryColor : Colors.black54,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );
}
}