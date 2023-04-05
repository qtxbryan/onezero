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
              return PropertyListItem(property: property);
            },
          );
        },
      ),
    );
  }
}

class PropertyListItem extends StatefulWidget {
  final DocumentSnapshot property;

  PropertyListItem({required this.property});

  @override
  _PropertyListItemState createState() => _PropertyListItemState();
}

class _PropertyListItemState extends State<PropertyListItem> {
  bool isFavorite = false;

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
    await favoritesRef.doc(widget.property.id).set({});

    // Update the state to indicate that the property is now a favorite
    setState(() {
      isFavorite = true;
    });

    // Show a success message
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Added to favorites.'),
    ));
  }

  void _removeFromFavorites(BuildContext context) async {
    // Get the current user's ID
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // If the user is not signed in, show an error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'You must be signed in to remove properties from your favorites.'),
      ));
      return;
    }

    // Remove the property from the user's favorites collection in Firestore
    final favoritesRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('favorites');
    await favoritesRef.doc(widget.property.id).delete();

    // Update the state to indicate that the property is no longer a favorite
    setState(() {
      isFavorite = false;
    });

    // Show a success message
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Removed from favorites.'),
    ));
  }

  @override
  void initState() {
    super.initState();
    // Check if the property is already in the user's favorites collection
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final favoritesRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('favorites');
      favoritesRef.doc(widget.property.id).get().then((doc) {
        setState(() {
          isFavorite = doc.exists;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.property['propertyName']),
      subtitle: Text('${widget.property['price']}'),
      trailing: IconButton(
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? Colors.red : null,
        ),
        onPressed: () {
          if (isFavorite) {
            _removeFromFavorites(context);
          } else {
            _addToFavorites(context);
          }
        },
      ),
    );
  }
}
