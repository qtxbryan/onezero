import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:onezero/models/Listing.dart';

class Database {
  //Listing

  //Create Functions
  Future createListing(
      {required String address,
      required String description,
      required int dimension,
      required int lease,
      required String neighbourhood,
      required int numOfBedroom,
      required double price,
      required String propertyName}) async {
    final docListing = FirebaseFirestore.instance.collection('listing').doc();

    final listing = Listing(
      id: docListing.id,
      address: address,
      description: description,
      dimension: dimension,
      lease: lease,
      neighbourhood: neighbourhood,
      numOfBedroom: numOfBedroom,
      price: price,
      propertyName: propertyName,
    );

    final json = listing.toJson();

    await docListing.set(json);
  }

  //Read Listing
  CollectionReference listings =
      FirebaseFirestore.instance.collection('listing');
}
