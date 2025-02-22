import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OnlineShopPage extends StatelessWidget {
  const OnlineShopPage({super.key});  // Updated to use the latest syntax for super parameters

  // Function to launch URL
  void _launchURL() async {
    final url = Uri.parse('https://shop.kloster-einsiedeln.ch/');  // Using Uri.parse for the URL
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kloster Laden"),
        backgroundColor: Colors.white,
        elevation: 0,  // No shadow
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/kloster_inside_light.jpg"),  // Ensure the image is in the assets folder
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: ElevatedButton(
            onPressed: _launchURL,
            child: const Text('Visit Kloister Shop'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,  // Button background color
              foregroundColor: Colors.black,  // Button text color
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
          ),
        ),
      ),
    );
  }
}
