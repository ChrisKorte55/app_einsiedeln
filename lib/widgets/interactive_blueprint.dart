import 'package:flutter/material.dart';
import 'package:app_einsiedeln/models/tour_location_csv.dart';
import 'package:app_einsiedeln/widgets/location_details_popup.dart';

class InteractiveBlueprint extends StatelessWidget {
  final List<TourLocation> locations;

  InteractiveBlueprint({Key? key, required this.locations}) : super(key: key);

  final double originalImageWidth = 442.0;
  final double originalImageHeight = 734.0;
  final Color primaryColor = Color.fromRGBO(176, 148, 60, 1);
  final Color redColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: InteractiveViewer(
            panEnabled: true,
            scaleEnabled: true,
            minScale: 0.5,
            maxScale: 2.5,
            child: AspectRatio(
              aspectRatio: originalImageWidth / originalImageHeight,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double displayWidth = constraints.maxWidth;
                  double displayHeight = constraints.maxHeight;

                  return Stack(
                    children: [
                      Image.asset(
                        'assets/images/floorplanzoomedin.png',
                        width: displayWidth,
                        height: displayHeight,
                        fit: BoxFit.contain,
                      ),
                      ...locations.map((location) {
                        double xPosition =
                            (location.x / originalImageWidth) * displayWidth;
                        double yPosition =
                            (location.y / originalImageHeight) * displayHeight;

                        return Stack(
                          children: [
                            Positioned(
                              left: xPosition - 15,
                              top: yPosition - 15,
                              child: GestureDetector(
                                onTap: () => showLocationDetails(context, location),
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 200),
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: redColor,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black54,
                                        spreadRadius: 1,
                                        blurRadius: 6,
                                        offset: Offset(-1, -1),
                                      ),
                                      BoxShadow(
                                        color: Colors.white38,
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: Offset(2, 2),
                                      ),
                                    ],
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    location.id.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: xPosition - 40,
                              top: yPosition + 20,
                              child: SizedBox(
                                width: 80,
                                child: Text(
                                  location.name,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    height: 1.2,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
        Positioned(
          right: 16,
          bottom: 16,
          child: FloatingActionButton(
            onPressed: () => _showMiniMap(context),
            backgroundColor: redColor,
            shape: CircleBorder(),
            elevation: 8,
            splashColor: Colors.white,
            highlightElevation: 12,
            child: Icon(Icons.map, color: Colors.white, size: 30),
          ),
        ),
      ],
    );
  }

  void _showMiniMap(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(20),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Define original image size
            double originalWidth = 1000;
            double originalHeight = 707;

            // Determine the scaled width and height while maintaining aspect ratio
            double maxDialogWidth = constraints.maxWidth * 0.9;
            double maxDialogHeight = constraints.maxHeight * 0.8;
            double aspectRatio = originalWidth / originalHeight;
            double scaledWidth = maxDialogWidth;
            double scaledHeight = maxDialogWidth / aspectRatio;

            if (scaledHeight > maxDialogHeight) {
              scaledHeight = maxDialogHeight;
              scaledWidth = scaledHeight * aspectRatio;
            }

            // Calculate scaled text position
            double scaleFactorX = scaledWidth / originalWidth;
            double scaleFactorY = scaledHeight / originalHeight;
            double textX = 100 * scaleFactorX;
            double textY = 352 * scaleFactorY;

            return Stack(
              alignment: Alignment.topRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: scaledWidth,
                          height: scaledHeight,
                          child: Image.asset(
                            'assets/images/kloster_uebersicht.jpg',
                            fit: BoxFit.contain,
                          ),
                        ),
                        Positioned(
                          left: textX,
                          top: textY,
                          child: Text(
                            "Visitor\nEntrance",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18, 
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                              letterSpacing: 1.2,
                              shadows: [
                                Shadow(
                                  color: Colors.white, // White outline
                                  blurRadius: 3,
                                  offset: Offset(-1, -1),
                                ),
                                Shadow(
                                  color: Colors.white,
                                  blurRadius: 3,
                                  offset: Offset(1, 1),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 12,
                  top: 12,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(Icons.close, color: Colors.black, size: 24),
                  ),
                ),
              ],
            );
          },
        ),
      );
    },
  );
}

}