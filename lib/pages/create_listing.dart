import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:onezero/backend/database.dart';
import 'package:onezero/models/Listing.dart';

class CreateListingPage extends StatefulWidget {
  const CreateListingPage({super.key});

  @override
  State<CreateListingPage> createState() => _CreateListingPageState();
}

class _CreateListingPageState extends State<CreateListingPage> {
  Database db = Database();

  final addressController = TextEditingController();
  final descriptionController = TextEditingController();
  final dimenisonController = TextEditingController();
  final leaseController = TextEditingController();
  final neighbourhoodController = TextEditingController();
  final numOfBedroomController = TextEditingController();
  final priceController = TextEditingController();
  final propertyNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            TextFormField(
              controller: addressController,
            ),
            TextFormField(
              controller: descriptionController,
            ),
            TextFormField(
              controller: dimenisonController,
            ),
            TextFormField(
              controller: leaseController,
            ),
            TextFormField(
              controller: neighbourhoodController,
            ),
            TextFormField(
              controller: numOfBedroomController,
            ),
            TextFormField(
              controller: priceController,
            ),
            TextFormField(
              controller: propertyNameController,
            ),
            TextButton(
              onPressed: () {
                final address = addressController.text;
                final desc = descriptionController.text;
                final dimenison = dimenisonController.text;
                final lease = leaseController.text;
                final neighbour = neighbourhoodController.text;
                final numOfBedroom = numOfBedroomController.text;
                final price = priceController.text;
                final propertyName = propertyNameController.text;

                db.createListing(
                    address: address,
                    description: desc,
                    dimension: int.parse(dimenison),
                    lease: int.parse(lease),
                    neighbourhood: neighbour,
                    numOfBedroom: int.parse(numOfBedroom),
                    price: double.parse(price),
                    propertyName: propertyName);
              },
              child: Text('Submit Button'),
            )
          ],
        ),
      ),
    );
  }
}
