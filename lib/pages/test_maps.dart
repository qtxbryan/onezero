import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController _controller;

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(37.4226711, -122.0849872),
        zoom: 15,
      ),
    ));
  }

  void _launchMaps() async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=37.4226711,-122.0849872';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Page'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: _launchMaps,
          child: Card(
            child: SizedBox(
              height: 200,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(37.4226711, -122.0849872),
                  zoom: 15,
                ),
                markers: {
                  Marker(
                    markerId: MarkerId('myLocation'),
                    position: LatLng(37.4226711, -122.0849872),
                  ),
                },
                zoomControlsEnabled: true,
                myLocationButtonEnabled: false,
                mapType: MapType.normal,
                onMapCreated: _onMapCreated,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
