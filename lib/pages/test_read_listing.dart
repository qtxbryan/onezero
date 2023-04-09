import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onezero/models/Listing.dart';
import 'package:onezero/constants.dart';
import 'package:onezero/backend/database.dart';

class TestReadListing extends StatefulWidget {
  const TestReadListing({super.key});

  @override
  State<TestReadListing> createState() => _TestReadListingState();
}

class _TestReadListingState extends State<TestReadListing> {
  Database db = Database();

  final CollectionReference _listings =
      FirebaseFirestore.instance.collection('listing');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All lisings')),
      body: StreamBuilder(
        stream: _listings.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                print('Item builder called');
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];

                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(documentSnapshot['address']),
                    subtitle: Text(documentSnapshot['price'].toString()),
                  ),
                );
              },
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget buildListing(Listing listing) => ListTile(
        subtitle: Text((listing.lease).toString()),
      );
}
