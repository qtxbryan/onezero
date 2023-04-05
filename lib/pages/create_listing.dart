import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:onezero/backend/database.dart';
import 'package:onezero/models/Listing.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CreateListingPage extends StatefulWidget {
  const CreateListingPage({super.key});

  @override
  State<CreateListingPage> createState() => _CreateListingPageState();
}

class _CreateListingPageState extends State<CreateListingPage> {
  Database db = Database();

  final _formKey = GlobalKey<FormState>();
  String _selectedRoom = '4 room';
  int _selectedNumber = 10;
  File? _image;

  final addressController = TextEditingController();
  final descriptionController = TextEditingController();
  final dimenisonController = TextEditingController();
  final leaseController = TextEditingController();
  final neighbourhoodController = TextEditingController();
  final numOfBedroomController = TextEditingController();
  final priceController = TextEditingController();
  final propertyNameController = TextEditingController();

  Future getImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Property Name'),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Dimensions'),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Address'),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Neighbourhood'),
                ),
                CustomNumberPicker(
                  initialValue: _selectedNumber,
                  maxValue: 99,
                  minValue: 10,
                  step: 1,
                  onValue: (value) {
                    setState(() {
                      _selectedNumber = value;
                    });
                  },
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Rooms'),
                  value: _selectedRoom,
                  items: ['2 room', '3 room', '4 room', '5 room']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRoom = newValue!;
                    });
                  },
                ),
                _image == null
                    ? Text('No image selected.')
                    : Image.file(_image!),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).accentColor,
                  ),
                  onPressed: getImage,
                  child: Text('Upload Image',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
