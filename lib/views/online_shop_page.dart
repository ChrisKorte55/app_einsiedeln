import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class OnlineShopPage extends StatelessWidget {
  const OnlineShopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kloster Laden"),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: HtmlWidget(
          '''
            <iframe src="https://shop.kloster-einsiedeln.ch/" 
            width="${MediaQuery.of(context).size.width}"
            height="${MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top}"
            frameborder="0" 
            allowfullscreen></iframe>
          ''',
        ),
      ),
    );
  }
}