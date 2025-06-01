import 'package:flutter/material.dart';
import 'package:google_maps_widget/google_maps_widget.dart';
import 'package:emergency_one/core/constants/assets_path.dart';

class DemoPage extends StatelessWidget {
  final LatLng sourceLatLng;
  final LatLng destinationLatLng;

  const DemoPage({
    super.key,
    required this.sourceLatLng,
    required this.destinationLatLng,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tracking"),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Stack(
        children: [
          /// 🗺️ Map View
          GoogleMapsWidget(
            apiKey: "AIzaSyAl5TtsfNcQL0iLuG_STqqYcW5zgEV19no",
            sourceLatLng: sourceLatLng,
            destinationLatLng: destinationLatLng,
            routeWidth: 40,
            sourceMarkerIconInfo: MarkerIconInfo(
              infoWindowTitle: "You",
              assetPath: ImageAssets.my,
              assetMarkerSize: const Size.square(40),
            ),
            destinationMarkerIconInfo: MarkerIconInfo(
              assetPath: ImageAssets.des,
              infoWindowTitle: "Destination",
              assetMarkerSize: const Size.square(40),
            ),
            driverMarkerIconInfo: MarkerIconInfo(
              infoWindowTitle: "Driver",
              assetPath: ImageAssets.car,
              assetMarkerSize: const Size.square(40),
              rotation: 90,
            ),
            
            updatePolylinesOnDriverLocUpdate: true,
            onPolylineUpdate: (_) => print("Polyline updated"),
            // driverCoordinatesStream: Stream.periodic(
            //   const Duration(milliseconds: 500),
            //   (i) => LatLng(
            //     sourceLatLng.latitude + i / 10000,
            //     sourceLatLng.longitude - i / 10000,
            //   ),
            // ),
            totalTimeCallback: (time) {
              print("ETA: $time");
            },
            totalDistanceCallback: (distance) {
              print("Distance: $distance");
            },
          ),

          /// 🔲 Info Panel (bottom)
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Colors.white.withOpacity(0.9),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Your Ambulance is on the Way",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _infoItem("ETA", "3 mins"),
                        _infoItem("Distance", "1.2 km"),
                        _infoItem("Driver", "Alex"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Simple reusable widget for bottom info
  Widget _infoItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    );
  }
}
