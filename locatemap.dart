import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Location Status')
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(22.5448131, 88.3403691),
          zoom: 15
        ),
      ),
    );
  }
}