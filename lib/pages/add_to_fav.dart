import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Properties'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('listing').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final properties = snapshot.data!.docs;
          return ListView.builder(
            itemCount: properties.length,
            itemBuilder: (context, index) {
              final property = properties[index];
              return ListTile(
                title: Text(property['propertyName']),
                subtitle: Text('${property['price']}'),
                trailing: AddToFavoritesButton(propertyId: property.id),
              );
            },
          );
        },
      ),
    );
  }
}

class AddToFavoritesButton extends StatelessWidget {
  final String propertyId;

  AddToFavoritesButton({required this.propertyId});

  void _addToFavorites(BuildContext context) async {
    // Get the current user's ID
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // If the user is not signed in, show an error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text('You must be signed in to add properties to your favorites.'),
      ));
      return;
    }

    // Add the property to the user's favorites collection in Firestore
    final favoritesRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('favorites');
    await favoritesRef.doc(propertyId).set({});

    // Show a success message
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Added to favorites.'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.favorite_border),
      onPressed: () => _addToFavorites(context),
    );
  }
}
