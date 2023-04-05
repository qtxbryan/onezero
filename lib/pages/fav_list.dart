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
                    .collection('listing')
                    .doc(favoritePropertyId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final favoriteProperty =
                      snapshot.data!.data() as Map<String, dynamic>;
                  if (favoriteProperty == null) {
                    return SizedBox.shrink();
                  }
                  return ListTile(
                    title: Text('${favoriteProperty['propertyName']}'),
                    subtitle: Text('${favoriteProperty['price']}'),
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
