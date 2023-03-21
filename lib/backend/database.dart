import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:onezero/models/Listing.dart';
import '../auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class Database {
  final FirebaseStorage storage = FirebaseStorage.instance;

  // Store image in firebase
  Future<String> uploadFile(File file) async {
    String fileName = file.path.split('/').last;
    Reference reference = storage.ref().child('uploads/$fileName');
    UploadTask uploadTask = reference.putFile(file);
    TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

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
