import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onezero/controller/validations.dart';
import 'dart:io';
import 'package:onezero/models/Listing.dart';
import 'package:onezero/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditPropertyPage extends StatefulWidget {
  final Listing property;

  EditPropertyPage(this.property);

  @override
  _EditPropertyPageState createState() => _EditPropertyPageState();
}

class _EditPropertyPageState extends State<EditPropertyPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final ImagePicker picker = ImagePicker();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Auth _auth = Auth();

  late Listing list;
  late File imageFile;

  @override
  void initState() {
    super.initState();
    list = Listing(
      address: widget.property.address,
      description: widget.property.description,
      dimension: widget.property.dimension,
      lease: widget.property.lease,
      neighbourhood: widget.property.neighbourhood,
      numOfBedroom: widget.property.numOfBedroom,
      price: widget.property.price,
      propertyName: widget.property.propertyName,
      listed_by_email: widget.property.listed_by_email,
      upload_url: widget.property.upload_url,
    );
  }

  @override
  Widget build(BuildContext context) {
    print(list.upload_url);
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Property"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              if (list.upload_url != null)
                SizedBox(
                  height: 200,
                  child: Image.network(list.upload_url!),
                ),
              SizedBox(height: 16.0),
              TextButton.icon(
                icon: Icon(Icons.add_a_photo),
                label: Text("Change Photo"),
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
                validator: validateAddress,
                initialValue: list.address,
                decoration: InputDecoration(
                  labelText: "Address",
                ),
                onChanged: (value) => list.setAddress = value,
                onSaved: (value) => list.setAddress = value,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                validator: validateDescription,
                initialValue: list.description,
                decoration: InputDecoration(
                  labelText: "Description",
                ),
                onSaved: (value) => list.setDescription = value,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                validator: validateDimensions,
                initialValue: list.dimension,
                decoration: InputDecoration(
                  labelText: "Dimension",
                ),
                onChanged: (value) => list.setDimension = value,
                onSaved: (value) => list.setDimension = value,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                validator: validateNeighborhood,
                initialValue: list.neighbourhood,
                decoration: InputDecoration(
                  labelText: "Neighbourhood",
                ),
                onChanged: (value) => list.setNeighbourhood = value,
                onSaved: (value) => list.setNeighbourhood = value,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                validator: validateLease,
                initialValue: list.lease,
                decoration: InputDecoration(
                  labelText: "Lease",
                ),
                onChanged: (value) => list.setLease = value,
                onSaved: (value) => list.setLease = value,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                validator: validateNumberOfBedrooms,
                initialValue: list.numOfBedroom?.toString(),
                decoration: InputDecoration(
                  labelText: "Number of Bedrooms",
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) => list.setNumOfBedroom = value,
                onSaved: (value) => list.setNumOfBedroom = value,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                validator: validatePrice,
                initialValue: list.price?.toString(),
                decoration: InputDecoration(
                  labelText: "Price",
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) => list.setPrice = value,
                onSaved: (value) => list.setPrice = value,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                validator: validatePropertyName,
                initialValue: list.propertyName,
                decoration: InputDecoration(
                  labelText: "Property Name",
                ),
                onChanged: (value) => list.setPropertyName = value,
                onSaved: (value) => list.setPropertyName = value,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                child: Text("Save Changes"),
                onPressed: () => saveChanges(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> uploadImage() async {
    final storageRef = storage.ref().child("properties/${DateTime.now()}.jpg");
    final uploadTask = storageRef.putFile(imageFile);
    final snapshot = await uploadTask.whenComplete(() {});
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  void saveChanges() async {
    // Upload image if provided
    if (imageFile != null) {
      list.upload_url = await uploadImage();
    }

    // Update data in Firebase
    await firestore.collection("listing").doc(widget.property.id).update({
      "address": list.address,
      "description": list.description,
      "dimension": list.dimension,
      "neighbourhood": list.neighbourhood,
      "lease": list.lease,
      "numOfBedroom": list.numOfBedroom,
      "price": list.price,
      "propertyName": list.propertyName,
      "imageUrl": list.upload_url,
    });

    Navigator.pop(context, true);
  }
}
