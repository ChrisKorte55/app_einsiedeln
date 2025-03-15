import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class KlosterHistoryPage extends StatelessWidget {
  final Color primaryColor = Color.fromRGBO(176, 148, 60, 1);

  final List<Map<String, String>> historyEvents = [
    {
      'date': '1820',
      'title': 'Founding of the Monastery',
      'description': 'The monastery was established by a group of monks seeking solitude and spiritual reflection. It became a center for learning and religious devotion in the region.'
    },
    {
      'date': '1855',
      'title': 'First Major Expansion',
      'description': 'New buildings and facilities were added to accommodate more monks and visitors. A library was also built, housing ancient manuscripts and religious texts.'
    },
    {
      'date': '1900',
      'title': 'Fire Incident',
      'description': 'A devastating fire destroyed parts of the monastery. Reconstruction efforts began immediately, and it was restored with stronger materials and new architectural features.'
    },
    {
      'date': '1925',
      'title': 'Cultural Renaissance',
      'description': 'The monastery became a hub for art and literature. Scholars and artists gathered here to create and preserve cultural heritage.'
    },
    {
      'date': '1950',
      'title': 'Modernization',
      'description': 'Electricity and plumbing were introduced to the monastery, bringing it into the modern era while maintaining its historical charm.'
    },
    {
      'date': '2000',
      'title': 'Preservation Efforts',
      'description': 'A major restoration project was undertaken to preserve the monastery’s historical artifacts and structures for future generations.'
    },
    {
      'date': '2020',
      'title': '200-Year Celebration',
      'description': 'A grand celebration was held to commemorate 200 years of the monastery’s existence, attended by visitors from around the world.'
    },
    // Add more events up to 25
  ];

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(appLoc.historyPage),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: historyEvents.length,
          itemBuilder: (context, index) {
            return _buildTimelineItem(historyEvents[index], index == historyEvents.length - 1);
          },
        ),
      ),
    );
  }

  Widget _buildTimelineItem(Map<String, String> event, bool isLastItem) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
                if (!isLastItem)
                  Container(
                    height: 50,
                    width: 2,
                    color: primaryColor,
                    margin: EdgeInsets.only(top: 4),
                  ),
              ],
            ),
            SizedBox(width: 16),
            Expanded(
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event['date']!,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        event['title']!,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        event['description']!,
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
