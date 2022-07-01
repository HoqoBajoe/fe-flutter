import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hoqobajoe/theme.dart';

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
    AppBar buildAppBar() {
      return AppBar(
          centerTitle: true,
          title: Text(
            "Hoqo Bajoe",
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: bold,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.black,
              ),
              onPressed: () => {
                Navigator.pop(context),
              },
            ),
          ));
    }

    return Scaffold(
      appBar: buildAppBar(),
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
