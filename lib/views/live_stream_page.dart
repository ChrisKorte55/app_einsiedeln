import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class LiveStreamPage extends StatelessWidget {
  const LiveStreamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        bool isLandscape = orientation == Orientation.landscape;
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;

        return Scaffold(
          appBar: isLandscape
              ? null // Remove the AppBar in landscape mode
              : AppBar(
                  title: const Text("Live Stream Gottesdienst"),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
          body: Stack(
            children: [
              Container(
                color: Colors.white,
                child: Center(
                  child: HtmlWidget(
                    '''
                      <iframe 
                        src="https://cust-kloster-einsiedeln-front-9b2d91cc913e.herokuapp.com/embed" 
                        width="$screenWidth"
                        height="$screenHeight"
                        frameborder="0" 
                        allow="autoplay; encrypted-media; fullscreen"
                        allowfullscreen
                        style="border-radius: 10px;"
                      ></iframe>
                    ''',
                  ),
                ),
              ),
              // Back button overlay in landscape mode
              if (isLandscape)
                Positioned(
                  top: 16, // Keeps it near the top
                  left: 16, // Keeps it near the left
                  child: SafeArea(
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black, size: 30),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
