import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class SalvePage extends StatelessWidget {
  const SalvePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Salve Newsletter"),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView( // Allows scrolling when content is larger than the screen
        child: Column( // Organizes children in a vertical column
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0), // Adds padding around the text
              child: Text(
                "Vier Mal im Jahr lässt Sie unsere Zeitschrift salve einen Blick auf das Leben hinter den Einsiedler und Fahrer Klostermauern samt den mit ihnen verbundenen Institutionen werfen.",
                style: TextStyle(
                  fontSize: 16, // Sets font size
                  color: Colors.black87, // Sets text color
                ),
                textAlign: TextAlign.center, // Centers the text
              ),
            ),
            HtmlWidget(
              '''
              <iframe src="https://www.kloster-einsiedeln.ch/_blaetterpdf/salve_2024/salve_2024_05/" style="width:100%; height:800px; border:none;"></iframe>
              '''
            ),
          ],
        ),
      ),
    );
  }
}
