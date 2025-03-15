import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class SalvePage extends StatelessWidget {
  const SalvePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (!isLandscape) // **Only show text in portrait mode**
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Vier Mal im Jahr lässt Sie unsere Zeitschrift salve einen Blick auf das Leben hinter den Einsiedler und Fahrer Klostermauern samt den mit ihnen verbundenen Institutionen werfen.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            HtmlWidget(
              '''
              <iframe src="https://www.kloster-einsiedeln.ch/_blaetterpdf/salve_2024/salve_2024_05/" 
              style="width:100%; height:800px; border:none;"></iframe>
              '''
            ),
          ],
        ),
      ),
    );
  }
}
