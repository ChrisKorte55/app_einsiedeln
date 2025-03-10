import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AllTagImKloster extends StatelessWidget {
  final Color primaryColor = Color.fromRGBO(176, 148, 60, 1); // Updated Color

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ' ',
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appLoc.alltagImKloster,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: 12),
            Text(
              appLoc.alltagImKlosterIntro,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            _buildTimeline(),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeline() {
    List<Map<String, String>> events = [
      {'time': '05.30', 'title': 'Vigil', 'description': '...'},
      {'time': 'Nach Vigil', 'title': 'Frühstück und Betrachtung', 'description': '...'},
      {'time': '07.15', 'title': 'Laudes', 'description': '...'},
      {'time': '12.00', 'title': 'Mittagshore und Mittagessen', 'description': '...'},
      {'time': '18.00', 'title': 'Vesper', 'description': '...'},
      {'time': '20.00', 'title': 'Komplet', 'description': '...'},
    ];

    return Column(
      children: events.asMap().entries.map((entry) {
        int index = entry.key;
        Map<String, String> event = entry.value;
        return _buildTimelineEvent(
          time: event['time']!,
          title: event['title']!,
          description: event['description']!,
          isFirst: index == 0,
          isLast: index == events.length - 1,
        );
      }).toList(),
    );
  }

  Widget _buildTimelineEvent({
    required String time,
    required String title,
    required String description,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            if (!isFirst)
              Container(height: 20, width: 2, color: primaryColor.withValues(alpha: 0.5)),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withValues(alpha: 0.3),
                    blurRadius: 6,
                    spreadRadius: 2,
                  )
                ],
              ),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    time,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ),
            ),
            if (!isLast)
              Container(height: 40, width: 2, color: primaryColor.withValues(alpha: 0.5)),
          ],
        ),
        SizedBox(width: 16),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 12),
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: primaryColor, width: 1.5),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 6,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor),
                ),
                SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
