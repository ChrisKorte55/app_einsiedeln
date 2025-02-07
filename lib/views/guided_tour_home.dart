import 'package:flutter/material.dart';

class TourLangHome extends StatelessWidget {
  const TourLangHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color mainColor = Color.fromRGBO(176, 148, 60, 1);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Events and Services"),
        backgroundColor: mainColor,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Welcome to the Events and Services page!",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: mainColor),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: mainColor,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => SpiritualTourPage()));
                print('Navigating to Spiritual Tour');
              },
              child: Text('Spiritual Tour'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: mainColor,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryArtTourPage()));
                print('Navigating to History/Art Tour');
              },
              child: Text('History/Art Tour'),
            ),
          ],
        ),
      ),
    );
  }
}
