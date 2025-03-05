import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Events"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Upcoming Events Schedule",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Center(
              child: HtmlWidget(
                '''
                  <iframe 
                    src="https://www.kloster-einsiedeln.ch/gettimes_2024_08/" 
                    width="$screenWidth"
                    height="${screenHeight * 0.8}"
                    frameborder="0" 
                    allow="fullscreen"
                    style="border-radius: 10px; border: 1px solid #ccc;"
                  ></iframe>
                ''',
                key: UniqueKey(), // Ensures the iframe reloads correctly
              ),
            ),
          ),
        ],
      ),
      // Removed the bottomNavigationBar since it's managed by AppShell
    );
  }
}
