import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '/widgets/custom_navigation_bar.dart'; // Make sure this path is correct

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  int _selectedIndex = 1; // Assuming this is the index for the Events page in the navigation bar

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
      switch (index) {
        case 0:
          Navigator.pushReplacementNamed(context, '/about_us_page');
          break;
        case 1:
          Navigator.pushReplacementNamed(context, '/events_calendar_page');
          break;
        case 2:
          Navigator.pushReplacementNamed(context, '/live_stream_page');
          break;
        case 3:
          Navigator.pushReplacementNamed(context, '/salve_newsletter_page');
          break;
        case 4:
          Navigator.pushReplacementNamed(context, '/guided_tour_home');
          break;
        case 5:
          Navigator.pushReplacementNamed(context, '/online_shop_page');
          break;
        default:
          break;
      }
    }
  }

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
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
