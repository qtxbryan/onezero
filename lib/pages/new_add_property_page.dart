import 'package:onezero/constants.dart';
import 'main_page.dart';

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:onezero/auth.dart';
import 'dart:io';

class AddPropertyPageWidget extends StatefulWidget {
  @override
  _AddPropertyPageWidgetState createState() => _AddPropertyPageWidgetState();
}

class _AddPropertyPageWidgetState extends State<AddPropertyPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final ImagePicker picker = ImagePicker();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController postalCodeController = TextEditingController();
  TextEditingController streetNameController = TextEditingController();
  TextEditingController blockNumberController = TextEditingController();
  TextEditingController unitNumberController = TextEditingController();
  TextEditingController levelController = TextEditingController();

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

      String unit = levelController.text + ' - ' + unitNumberController.text;

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

      Navigator.push(
          context, MaterialPageRoute(builder: ((context) => MainPage())));
    }
  }

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;

    if (user != null) {
      listedByEmail = user.email!;
    }

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBtnText,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Add Property',
          style: FlutterFlowTheme.of(context).bodyText1.override(
                fontFamily: 'Poppins',
                color: Color(0xFF1D1D1D),
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (imageFile != null)
                  SizedBox(
                    height: 200,
                    child: Image.file(imageFile!),
                  ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FFButtonWidget(
                        onPressed: () async {
                          final pickedFile = await picker.getImage(
                              source: ImageSource.gallery);
                          if (pickedFile != null) {
                            setState(() {
                              imageFile = File(pickedFile.path);
                            });
                          }
                        },
                        text: 'Add Photo',
                        options: FFButtonOptions(
                          width: 100.0,
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primaryBtnText,
                          textStyle:
                              FlutterFlowTheme.of(context).bodyText2.override(
                                    fontFamily: 'Poppins',
                                    color: Color(PRIMARY_COLOR),
                                    fontSize: 12.0,
                                  ),
                          borderSide: BorderSide(
                            color: Color(PRIMARY_COLOR),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 280.0,
                            height: 60.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: Container(
                              width: 100.0,
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter a property name.";
                                  }
                                  return null;
                                },
                                onSaved: (value) => propertyName = value,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Property Name',
                                  hintText: 'Enter here',
                                  hintStyle:
                                      FlutterFlowTheme.of(context).bodyText2,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(ACCENT_1),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(PRIMARY_COLOR),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.house,
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    size: 18.0,
                                  ),
                                ),
                                style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 219.7,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  child: Container(
                                    width: 100.0,
                                    child: TextFormField(
                                      controller: postalCodeController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter an address.";
                                        }
                                        return null;
                                      },
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Postal Code',
                                        hintText: 'Enter here',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .bodyText2,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(ACCENT_1),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(PRIMARY_COLOR),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(ALTERNATE_COLOR),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        prefixIcon: Icon(
                                          Icons.local_post_office,
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          size: 18.0,
                                        ),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1,
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15.0, 0.0, 0.0, 20.0),
                                  child: FlutterFlowIconButton(
                                    borderColor: Colors.transparent,
                                    borderRadius: 30.0,
                                    borderWidth: 1.0,
                                    buttonSize: 40.0,
                                    fillColor: Color(PRIMARY_COLOR),
                                    icon: Icon(
                                      Icons.search,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBtnText,
                                      size: 18.0,
                                    ),
                                    onPressed: searchAddress,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 280.0,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  child: Container(
                                    width: 100.0,
                                    child: TextFormField(
                                      obscureText: false,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter an address.";
                                        }
                                        return null;
                                      },
                                      controller: blockNumberController,
                                      decoration: InputDecoration(
                                        labelText: 'Block',
                                        hintText: 'Enter here',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .bodyText2,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(ACCENT_1),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(PRIMARY_COLOR),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        prefixIcon: Icon(
                                          Icons.apartment,
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          size: 18.0,
                                        ),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 280.0,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  child: Container(
                                    width: 100.0,
                                    child: TextFormField(
                                      obscureText: false,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter an address.";
                                        }
                                        return null;
                                      },
                                      controller: streetNameController,
                                      decoration: InputDecoration(
                                        labelText: 'Street',
                                        hintText: 'Enter here',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .bodyText2,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(ACCENT_1),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(PRIMARY_COLOR),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(ALTERNATE_COLOR),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        prefixIcon: Icon(
                                          Icons.store,
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          size: 18.0,
                                        ),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 120.0,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  child: Container(
                                    width: 100.0,
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter a level.";
                                        }
                                        return null;
                                      },
                                      controller: levelController,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Level',
                                        hintText: 'Level',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .bodyText2,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(ACCENT_1),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(PRIMARY_COLOR),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(ALTERNATE_COLOR),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(ALTERNATE_COLOR),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10.0, 0.0, 10.0, 0.0),
                                  child: Text(
                                    '-',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Poppins',
                                          fontSize: 24.0,
                                        ),
                                  ),
                                ),
                                Container(
                                  width: 120.0,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  child: Container(
                                    width: 100.0,
                                    child: TextFormField(
                                      obscureText: false,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter an address.";
                                        }
                                        return null;
                                      },
                                      controller: unitNumberController,
                                      decoration: InputDecoration(
                                        labelText: 'Unit',
                                        hintText: 'Unit',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .bodyText2,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(ACCENT_1),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(PRIMARY_COLOR),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 280.0,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  child: Container(
                                    width: 100.0,
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter a neighbourhood.";
                                        }
                                        return null;
                                      },
                                      onSaved: (value) => neighbourhood = value,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Neighbourhood',
                                        hintText: 'Enter here',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .bodyText2,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(ACCENT_1),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(PRIMARY_COLOR),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        prefixIcon: Icon(
                                          Icons.store,
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          size: 18.0,
                                        ),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 120.0,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  child: Container(
                                    width: 100.0,
                                    child: TextFormField(
                                      obscureText: false,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter a number of bedrooms.";
                                        }
                                        return null;
                                      },
                                      onSaved: (value) => numOfBedroom = value,
                                      decoration: InputDecoration(
                                        labelText: 'Bedrooms',
                                        hintText: 'Bedrooms',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .bodyText2,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(ACCENT_1),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(PRIMARY_COLOR),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(ALTERNATE_COLOR),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10.0, 0.0, 10.0, 0.0),
                                  child: Text(
                                    '-',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Poppins',
                                          fontSize: 24.0,
                                        ),
                                  ),
                                ),
                                Container(
                                  width: 120.0,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  child: Container(
                                    width: 100.0,
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter a lease.";
                                        }
                                        return null;
                                      },
                                      onSaved: (value) => lease = value,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Lease',
                                        hintText: 'Lease',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .bodyText2,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(ACCENT_1),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(PRIMARY_COLOR),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 120.0,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  child: Container(
                                    width: 100.0,
                                    child: TextFormField(
                                      obscureText: false,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter a dimension.";
                                        }
                                        return null;
                                      },
                                      onSaved: (value) => dimension = value,
                                      decoration: InputDecoration(
                                        labelText: 'Dimensions',
                                        hintText: 'Dimensions',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .bodyText2,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(ACCENT_1),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(PRIMARY_COLOR),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10.0, 0.0, 10.0, 0.0),
                                  child: Text(
                                    '-',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Poppins',
                                          fontSize: 24.0,
                                        ),
                                  ),
                                ),
                                Container(
                                  width: 120.0,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  child: Container(
                                    width: 100.0,
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter a price.";
                                        }
                                        return null;
                                      },
                                      onSaved: (value) => price = value,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Price',
                                        hintText: 'Price',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .bodyText2,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(ACCENT_1),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(PRIMARY_COLOR),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 280.0,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  child: Container(
                                    width: 100.0,
                                    child: TextFormField(
                                      obscureText: false,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter a description.";
                                        }
                                        return null;
                                      },
                                      onSaved: (value) => description = value,
                                      decoration: InputDecoration(
                                        labelText: 'Description',
                                        hintText: 'Enter here',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .bodyText2,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(ACCENT_1),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(PRIMARY_COLOR),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        prefixIcon: Icon(
                                          Icons.apartment,
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          size: 18.0,
                                        ),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1,
                                      keyboardType: TextInputType.multiline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 20.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 300.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBtnText,
                        ),
                        child: FFButtonWidget(
                          onPressed: () => addProperty(),
                          text: 'Add Property',
                          options: FFButtonOptions(
                            width: 130.0,
                            height: 40.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primaryBtnText,
                            textStyle:
                                FlutterFlowTheme.of(context).bodyText2.override(
                                      fontFamily: 'Poppins',
                                      color: Color(PRIMARY_COLOR),
                                    ),
                            borderSide: BorderSide(
                              color: Color(PRIMARY_COLOR),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
