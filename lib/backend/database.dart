import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:onezero/models/Listing.dart';
import '../auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  Stream<DocumentSnapshot> readSingleDocument(
      String collectionName, String uid) {
    CollectionReference _collectionRef;
    DocumentReference _collectionDocRef;
    Stream<DocumentSnapshot> _collectionDocStream;

    _collectionRef = FirebaseFirestore.instance.collection(collectionName);
    _collectionDocRef = _collectionRef.doc(uid);
    _collectionDocStream = _collectionDocRef.snapshots();

    return _collectionDocStream;
  }
}
