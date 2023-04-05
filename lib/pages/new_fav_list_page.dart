import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoritePropertiesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
// If the user is not signed in, show an error message
      return Center(
        child: Text('You must be signed in to view your favorite properties.'),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Properties'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('favorites')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final favoritePropertyIds =
              snapshot.data!.docs.map((doc) => doc.id).toList();
          return ListView.builder(
            itemCount: favoritePropertyIds.length,
            itemBuilder: (context, index) {
              final favoritePropertyId = favoritePropertyIds[index];
              return StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('properties')
                    .doc(favoritePropertyId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final favoriteProperty =
                      snapshot.data!.data() as Map<String, dynamic>?;
                  if (favoriteProperty == null) {
                    return SizedBox.shrink();
                  }
                  return FavoritePropertyListItem(
                    propertyId: favoritePropertyId,
                    property: favoriteProperty,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class FavoritePropertyListItem extends StatefulWidget {
  final String propertyId;
  final Map<String, dynamic> property;
  FavoritePropertyListItem({required this.propertyId, required this.property});

  @override
  _FavoritePropertyListItemState createState() =>
      _FavoritePropertyListItemState();
}

class _FavoritePropertyListItemState extends State<FavoritePropertyListItem> {
  bool isFavorite = true;

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
    } // Remove the property from the user's favorites collection in Firestore
    final favoritesRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('favorites');
    await favoritesRef.doc(widget.propertyId).delete();

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
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${widget.property['name']}'),
      subtitle: Text('${widget.property['price']}'),
      trailing: IconButton(
        icon: Icon(
          Icons.favorite,
          color: Colors.red,
        ),
        onPressed: () {
          _removeFromFavorites(context);
        },
      ),
    );
  }
}
