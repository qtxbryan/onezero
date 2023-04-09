import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddressForm extends StatefulWidget {
  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController streetNameController = TextEditingController();
  TextEditingController blockNumberController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Address Form')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: postalCodeController,
              decoration: InputDecoration(labelText: 'Postal Code'),
            ),
            TextButton(
              onPressed: searchAddress,
              child: Text('Search'),
            ),
            TextFormField(
              controller: streetNameController,
              decoration: InputDecoration(labelText: 'Street Name'),
            ),
            TextFormField(
              controller: blockNumberController,
              decoration: InputDecoration(labelText: 'Block Number'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> storeLatLngInFirebase(double latitude, double longitude) async {
    try {
      await firestore.collection('locations').add({
        'latitude': latitude,
        'longitude': longitude,
      });
    } catch (e) {
      print('Error storing location in Firestore: $e');
    }
  }

  Future<void> searchAddress() async {
    String postalCode = postalCodeController.text;

    if (postalCode.isNotEmpty) {
      try {
        List<Location> locations = await locationFromAddress(postalCode);
        if (locations.isNotEmpty) {
          Location location = locations.first;
          List<Placemark> placemarks = await placemarkFromCoordinates(
              location.latitude, location.longitude);

          if (placemarks.isNotEmpty) {
            Placemark placemark = placemarks.first;
            setState(() {
              streetNameController.text = placemark.street ?? '';
              blockNumberController.text = placemark.subThoroughfare ?? '';
            });
          }

          await storeLatLngInFirebase(location.latitude, location.longitude);
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
