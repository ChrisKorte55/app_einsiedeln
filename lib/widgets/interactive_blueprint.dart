import 'package:flutter/material.dart';
import 'package:app_einsiedeln/models/tour_location_csv.dart';
import 'package:app_einsiedeln/widgets/location_details_popup.dart';

class InteractiveBlueprint extends StatelessWidget {
  final List<TourLocation> locations;

  const InteractiveBlueprint({Key? key, required this.locations}) : super(key: key);

  final double originalImageWidth = 442.0;
  final double originalImageHeight = 734.0;

  @override
  Widget build(BuildContext context) {
    return Center(
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
                  Image.asset('assets/images/floorplanzoomedin.png', width: displayWidth, height: displayHeight, fit: BoxFit.contain, ),
                  Positioned(
                    left: 10,
                    top: 10,
                    child: GestureDetector(
                      onTap: () => _showMiniMap(context),
                      child: Container(
                        width: 140,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red, width: 2),
                          boxShadow: [BoxShadow(color: Color(0x4D000000), spreadRadius: 2, blurRadius: 2, offset: Offset(0, 2),),],
                          image: DecorationImage(image: AssetImage('assets/images/kloster_uebersicht.jpg'), fit: BoxFit.cover,),
                        ),
                      ),
                    ),
                  ),
                  ...locations.map((location) {
                    double xPosition = (location.x / originalImageWidth) * displayWidth - 15;
                    double yPosition = (location.y / originalImageHeight) * displayHeight - 15;

                    return Positioned(
                      left: xPosition,
                      top: yPosition,
                      child: GestureDetector(
                        onTap: () => showLocationDetails(context, location),
                        child: Column(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle,
                                boxShadow: [BoxShadow(color: Color(0x4D000000), spreadRadius: 1, blurRadius: 2, offset: Offset(0, 2),),],
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                location.id.toString(),
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10,),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(location.name, style: TextStyle(color: Colors.black, fontSize: 12), textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _showMiniMap(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Image.asset('assets/images/kloster_uebersicht.jpg', fit: BoxFit.cover),
          actions: <Widget>[
            TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Close'),),
          ],
        );
      },
    );
  }
}
