import 'package:flutter/material.dart';

class LiveStreamPage extends StatelessWidget {
  const LiveStreamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Events and Services"),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Text("Welcome to the Events and Services page!"),
      ),
    );
  }
}