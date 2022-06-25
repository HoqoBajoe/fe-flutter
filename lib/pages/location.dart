import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  static const LatLng _kMapCenter = LatLng(-6.97299, 107.63030);
  static const CameraPosition _kInitialPosition =
      CameraPosition(target: _kMapCenter, zoom: 11.0, tilt: 0, bearing: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff59CAFF),
        elevation: 0,
        title: const Text(
          "Hoqo Bajoe",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: _kInitialPosition,
        markers: _createMarker(),
      ),
    );
  }

  Set<Marker> _createMarker() {
    return {
      const Marker(
        markerId: MarkerId("Hoqo Bajoe"),
        position: _kMapCenter,
        infoWindow: InfoWindow(title: 'Hoqo Bajoe'),
      ),
    };
  }
}
