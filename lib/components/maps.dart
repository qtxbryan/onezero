import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MapsWidget extends StatefulWidget {
  final String lat;
  final String long;

  MapsWidget({required this.lat, required this.long});

  @override
  State<MapsWidget> createState() => _MapsWidgetState();
}

class _MapsWidgetState extends State<MapsWidget> {
  late GoogleMapController _controller;

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(double.parse(widget.lat), double.parse(widget.long)),
        zoom: 15,
      ),
    ));
  }

  void _launchMaps() async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=${widget.lat},${widget.long}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: _launchMaps,
        child: Card(
          child: SizedBox(
            height: 200,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target:
                    LatLng(double.parse(widget.lat), double.parse(widget.long)),
                zoom: 15,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('myLocation'),
                  position: LatLng(
                      double.parse(widget.lat), double.parse(widget.long)),
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
    );
  }
}
