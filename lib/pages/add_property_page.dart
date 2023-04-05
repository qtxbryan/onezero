import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onezero/models/Listing.dart';
import 'package:onezero/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddPropertyPage extends StatefulWidget {
  @override
  _AddPropertyPageState createState() => _AddPropertyPageState();
}

class _AddPropertyPageState extends State<AddPropertyPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final ImagePicker picker = ImagePicker();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;

    if (user != null) {
      listedByEmail = user.email!;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Property"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
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
                decoration: InputDecoration(
                  labelText: "Address",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter an address.";
                  }
                  return null;
                },
                onSaved: (value) => address = value,
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
              ElevatedButton(
                child: Text("Add Property"),
                onPressed: () => addProperty(),
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

  void addProperty() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      // Upload image if provided
      if (imageFile != null) {
        imageUrl = await uploadImage();
      }

      // Add data to Firebase
      await firestore.collection("listing").add({
        "address": address,
        "description": description,
        "dimension": dimension,
        "neighbourhood": neighbourhood,
        "lease": lease,
        "numOfBedroom": numOfBedroom,
        "price": price,
        "propertyName": propertyName,
        "listed_by_email": listedByEmail,
        "upload_url": imageUrl,
      });

      Navigator.pop(context, true);
    }
  }
}
