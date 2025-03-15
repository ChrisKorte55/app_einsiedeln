import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class KlosterHistoryPage extends StatefulWidget {
  @override
  _KlosterHistoryPageState createState() => _KlosterHistoryPageState();
}

class _KlosterHistoryPageState extends State<KlosterHistoryPage> {
  final Color primaryColor = Color.fromRGBO(176, 148, 60, 1);

  final String introText = 
      "In der über tausendjährigen Klostergeschichte spiegelt sich die Geschichte "
      "von Kirche und Gesellschaft. Sie zeigt, dass unser Kloster keine Insel darstellt, "
      "sondern auf vielfältige Weise mit seiner Umwelt verbunden ist. Blüte und Niedergang, "
      "Idealismus und Dekadenz, Heiligkeit und Sünde, Licht und Schatten wechseln sich ab "
      "im Gang durch die Jahrhunderte. Und doch: Was im 9. Jahrhundert durch den heiligen "
      "Meinrad seinen Anfang nahm, hat auf vielfältige Weise Frucht getragen und ist für "
      "unzählige Menschen zum Segen geworden. Unsere Klostergemeinschaft kann so im 21. "
      "Jahrhundert auf ein gutes Fundament bauen und fühlt sich privilegiert, die Geschichte "
      "von Kloster und Wallfahrtsort weiterzuschreiben.";

  final List<Map<String, dynamic>> historyEvents = [
    {
      'date': '1820',
      'title': 'Founding of the Monastery',
      'description': 'A group of monks established the monastery for solitude and spiritual reflection.',
      'image': 'assets/images/monastery_founding.jpg'
    },
    {
      'date': '1855',
      'title': 'First Major Expansion',
      'description': 'New buildings were added, including a library with ancient manuscripts.',
      'image': 'assets/images/library_expansion.jpg'
    },
    {
      'date': '1900',
      'title': 'Fire Incident',
      'description': 'A fire destroyed parts of the monastery, but it was rebuilt with new materials.',
      'image': 'assets/images/fire_reconstruction.jpg'
    },
    {
      'date': '1925',
      'title': 'Cultural Renaissance',
      'description': 'The monastery became a hub for art and literature.',
      'image': 'assets/images/cultural_renaissance.jpg'
    },
    {
      'date': '1950',
      'title': 'Modernization',
      'description': 'Electricity and plumbing were introduced while keeping the historic charm.',
      'image': 'assets/images/modernization.jpg'
    },
    {
      'date': '2000',
      'title': 'Preservation Efforts',
      'description': 'Restoration projects preserved artifacts for future generations.',
      'image': 'assets/images/preservation_efforts.jpg'
    },
    {
      'date': '2020',
      'title': '200-Year Celebration',
      'description': 'A grand celebration was held to mark 200 years of the monastery.',
      'image': 'assets/images/200_years.jpg'
    },
  ];

  int _expandedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          appLoc.historyPage,
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 2,
      ),
      body: Stack(
        children: [
          _buildParallaxBackground(),
          ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 20),
            itemCount: historyEvents.length + 1, // +1 for intro section
            itemBuilder: (context, index) {
              if (index == 0) {
                return _buildIntroSection(); // First item is the intro text
              } else {
                return _buildTimelineItem(historyEvents[index - 1], index - 1, index == historyEvents.length);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildParallaxBackground() {
    return Positioned.fill(
      child: Image.asset(
        'assets/images/kloster_fog_forest.jpg', // A subtle monastery background
        fit: BoxFit.cover,
        opacity: AlwaysStoppedAnimation(0.8),
      ),
    );
  }

  Widget _buildIntroSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white.withValues(alpha: 0.9),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Die Geschichte des Klosters",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: 10),
              Text(
                introText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineItem(Map<String, dynamic> event, int index, bool isLastItem) {
    bool isExpanded = _expandedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _expandedIndex = _expandedIndex == index ? -1 : index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 16, bottom: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: isExpanded ? 20 : 16,
                  height: isExpanded ? 20 : 16,
                  decoration: BoxDecoration(
                    color: isExpanded ? Colors.white : primaryColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
                if (!isLastItem)
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height: isExpanded ? 70 : 50,
                    width: 2,
                    color: primaryColor,
                    margin: EdgeInsets.only(top: 4),
                  ),
              ],
            ),
            SizedBox(width: 20),
            Expanded(
              child: Card(
                elevation: isExpanded ? 6 : 3,
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
                      AnimatedCrossFade(
                        firstChild: Container(),
                        secondChild: Column(
                          children: [
                            SizedBox(height: 10),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                event['image']!,
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              event['description']!,
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                        duration: Duration(milliseconds: 500),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
