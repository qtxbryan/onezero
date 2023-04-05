import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:onezero/models/Listing.dart';
import '../auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Database {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile(String filePath, String fileName) async {
    File file = File(filePath);

    try {
      await storage.ref('$fileName').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  Future<firebase_storage.ListResult> listFiles() async {
    firebase_storage.ListResult result = await storage.ref().listAll();

    result.items.forEach((firebase_storage.Reference ref) {
      print('Found file: $ref');
    });

    return result;
  }

  Future<String> downloadURL(String imageName) async {
    String downloadURL = await storage.ref('$imageName').getDownloadURL();

    return downloadURL;
  }

  //Listing

  // Create Functions
  Future createListing({
    required String address,
    required String description,
    required String dimension,
    required String lease,
    required String neighbourhood,
    required String numOfBedroom,
    required String price,
    required String propertyName,
    required String listedEmail,
  }) async {
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
      listed_by_email: listedEmail,
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

  //Update
  bool updateProfile(
      String uid,
      String displayName,
      String emailAddress,
      String phoneNumber,
      String address,
      String age,
      String householdIncome,
      String applicationType,
      String firstTime,
      String Martial,
      String citizenship,
      String applicationStatus,
      String photoURL) {
    final docUser = FirebaseFirestore.instance.collection('users').doc(uid);

    docUser.update({
      'displayName': displayName,
      'emailAddress': emailAddress,
      'phoneNumber': phoneNumber,
      'address': address,
      'age': age,
      'averageMonthlyHousehold': householdIncome,
      'applicationType': applicationType,
      'firstTime': firstTime,
      'Martial': Martial,
      'citizenship': citizenship,
      'applicationStatus': applicationStatus,
      'photo_url': photoURL,
    });

    return true;
  }
}
