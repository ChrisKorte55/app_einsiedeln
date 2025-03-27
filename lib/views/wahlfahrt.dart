import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Wahlfahrt extends StatelessWidget {
  final Color primaryColor = Color.fromRGBO(176, 148, 60, 1);

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(appLoc.gemeinschaft),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 2,
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/01_Gnadenkapelle-010.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Gradient overlay for better readability
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withValues(alpha: 0.6), Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          // Centered content with integrated texts
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      appLoc.gemeinschaft,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Uns Mönchen des Klosters Einsiedeln ist die Wallfahrt zu Unserer Lieben Frau von Einsiedeln anvertraut. Benediktinerabtei und Marienwallfahrt bilden in Einsiedeln eine einmalige Kombination.\n\nZusammen mit unseren Mitarbeitenden versuchen wir hier einen Ort zu gestalten, wo Begegnung möglich ist – mit Gott, den Menschen und sich selbst.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Einsiedeln ist kein Wallfahrtsort, der auf eine Marienerscheinung zurückgeht. Einsiedeln ist ein Wallfahrtsort der Tradition – einer sehr langen Tradition mit starker klösterlicher Prägung. In Einsiedeln gehen Kloster und Wallfahrt eine einmalige Symbiose ein und machen aus dem Heiligtum der Gottesmutter Maria im Herzen der Schweiz einen „benediktinischen Wallfahrtsort”.\n\nDie Einsiedler Wallfahrtsgeschichte beginnt mit der einfachen Zelle des heiligen Meinrad (+861) und machte aus Einsiedeln im Laufe der Jahrhunderte den bedeutendsten Marienwallfahrtsort der Schweiz. Die Wallfahrt im klassischen Sinn reicht in Einsiedeln sicher ins 12. Jahrhundert zurück. Erste schriftliche Zeugnisse aus dem frühen 14. Jahrhundert sprechen ganz selbstverständlich von Wallfahrten nach Einsiedeln und auch davon, dass sie recht bedeutend gewesen sind.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
