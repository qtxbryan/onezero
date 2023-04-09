import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import '/flutter_flow/flutter_flow_theme.dart';

import 'package:onezero/auth.dart';
import '/flutter_flow/flutter_flow_widgets.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:onezero/constants.dart';

class AddPropertyPage extends StatefulWidget {
  @override
  _AddPropertyPageState createState() => _AddPropertyPageState();
}

class _AddPropertyPageState extends State<AddPropertyPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final ImagePicker picker = ImagePicker();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController postalCodeController = TextEditingController();
  TextEditingController streetNameController = TextEditingController();
  TextEditingController blockNumberController = TextEditingController();
  TextEditingController unitNumberController = TextEditingController();

  Auth _auth = Auth();

  File? imageFile;
  String? imageUrl;
  String? address;
  String? description;
  String? dimension;
  String? neighbourhood;
  String? lease;
  String? numOfBedroom;
  String? price;
  String? propertyName;
  String? listedByEmail;
  String? postalCode;
  List<double> longlat = [];

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;

    if (user != null) {
      listedByEmail = user.email!;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Add Property",
          style: TextStyle(
            fontFamily: 'Urbanist',
            color: Color(TEXT_COLOR),
            fontSize: 18,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16, 25, 16, 16),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              if (imageFile != null)
                SizedBox(
                  height: 200,
                  child: Image.file(imageFile!),
                ),
              SizedBox(height: 16.0),
              TextButton.icon(
                icon: Icon(Icons.add_a_photo),
                label: Text("Add Photo"),
                onPressed: () async {
                  final pickedFile =
                      await picker.getImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      imageFile = File(pickedFile.path);
                    });
                  }
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: postalCodeController,
                decoration: InputDecoration(
                  labelText: "Postal Code",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter an address.";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextButton(
                onPressed: searchAddress,
                child: Text('Search'),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: streetNameController,
                decoration: InputDecoration(
                  labelText: "Street",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter an address.";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: blockNumberController,
                decoration: InputDecoration(
                  labelText: "Block",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter an address.";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: unitNumberController,
                decoration: InputDecoration(
                  labelText: "Unit Number",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter an address.";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Description",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a description.";
                  }
                  return null;
                },
                onSaved: (value) => description = value,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Dimension",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a dimension.";
                  }
                  return null;
                },
                onSaved: (value) => dimension = value,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Neighbourhood",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a neighbourhood.";
                  }
                  return null;
                },
                onSaved: (value) => neighbourhood = value,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Lease",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a lease.";
                  }
                  return null;
                },
                onSaved: (value) => lease = value,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Number of Bedrooms",
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a number of bedrooms.";
                  }
                  return null;
                },
                onSaved: (value) => numOfBedroom = value,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Price",
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a price.";
                  }
                  return null;
                },
                onSaved: (value) => price = value,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Property Name",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a property name.";
                  }
                  return null;
                },
                onSaved: (value) => propertyName = value,
              ),
              SizedBox(height: 16.0),
              FFButtonWidget(
                onPressed: () => addProperty(),
                text: 'Add Property',
                options: FFButtonOptions(
                  width: 320.0,
                  height: 50.0,
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: Colors.white,
                  textStyle: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Color(ALTERNATE_COLOR),
                        fontSize: 14,
                      ),
                  borderSide: BorderSide(
                    color: Color(ALTERNATE_COLOR),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> uploadImage() async {
    final storageRef = storage.ref().child("properties/${DateTime.now()}.jpg");
    final uploadTask = storageRef.putFile(imageFile!);
    final snapshot = await uploadTask.whenComplete(() {});
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> searchAddress() async {
    String postalCode = postalCodeController.text;
    String latLongString;

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

          longlat.add(location.latitude);
          longlat.add(location.longitude);

          print('LONG: ${location.longitude}');
          print('LAT ${location.latitude}');
          latLongString = longlat.join(",");

          return latLongString;
        }
      } catch (e) {
        print(e);
      }
    }

    return '';
  }

  void addProperty() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      // Upload image if provided
      if (imageFile != null) {
        imageUrl = await uploadImage();
      }

      DocumentReference newDocRef = firestore.collection('listing').doc();
      String newDocId = newDocRef.id;

      // Add data to Firebase
      await newDocRef.set({
        "id": newDocId,
        "address": streetNameController.text,
        "postalCode": postalCodeController.text,
        "unitNumber": unitNumberController.text,
        "description": description,
        "dimension": dimension,
        "neighbourhood": neighbourhood,
        "lease": lease,
        "numOfBedroom": numOfBedroom,
        "price": price,
        "propertyName": propertyName,
        "listed_by_email": listedByEmail,
        "upload_url": imageUrl,
        "lat": longlat[0].toString(),
        "long": longlat[1].toString(),
      });

      Navigator.pop(context);
    }
  }
}
