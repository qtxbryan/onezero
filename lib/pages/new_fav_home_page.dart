/*import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _searchText = '';
  int _selectedFilterIndex = -1;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Properties'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FavoritePropertiesPage(),
              ));
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FilterButton(
                    title: '2 Rooms',
                    isActive: _selectedFilterIndex == 0,
                    onPressed: () {
                      setState(() {
                        _selectedFilterIndex =
                            _selectedFilterIndex == 0 ? -1 : 0;
                      });
                    },
                  ),
                  SizedBox(width: 8),
                  FilterButton(
                    title: '3 Rooms',
                    isActive: _selectedFilterIndex == 1,
                    onPressed: () {
                      setState(() {
                        _selectedFilterIndex =
                            _selectedFilterIndex == 1 ? -1 : 1;
                      });
                    },
                  ),
                  SizedBox(width: 8),
                  FilterButton(
                    title: '4 Rooms',
                    isActive: _selectedFilterIndex == 2,
                    onPressed: () {
                      setState(() {
                        _selectedFilterIndex =
                            _selectedFilterIndex == 2 ? -1 : 2;
                      });
                    },
                  ),
                  SizedBox(width: 8),
                  FilterButton(
                    title: '5 Rooms',
                    isActive: _selectedFilterIndex == 3,
                    onPressed: () {
                      setState(() {
                        _selectedFilterIndex =
                            _selectedFilterIndex == 3 ? -1 : 3;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('properties')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final properties =
                    snapshot.data!.docs.map((doc) => doc.data()).toList();
                final filteredProperties = properties.where((property) {
                  // Filter by search text
                  final propertyName =
                      property['propertyName']?.toString().toLowerCase() ?? '';
                  final searchText = _searchText.toLowerCase();
                  if (searchText.isNotEmpty &&
                      !propertyName.contains(searchText)) {
                    return false;
                  }

                  // Filter by number of rooms
                  final numRooms = property['rooms'] as int?;
                  if (_selectedFilterIndex == -1 ||
                      numRooms == _selectedFilterIndex + 2) {
                    return true;
                  }
                  return false;
                }).toList();

                if (filteredProperties.isEmpty) {
                  return Center(
                    child: Text('Property not found.'),
                  );
                }
                return ListView.builder(
                  itemCount: filteredProperties.length,
                  itemBuilder: (context, index) {
                    final property =
                        filteredProperties[index] as Map<String, dynamic>;
                    return PropertyListItem(property: property);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PropertyListItem extends StatefulWidget {
  final Map<String, dynamic> property;

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
    await favoritesRef.doc(widget.property['id']).set(widget.property);

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
    await favoritesRef.doc(widget.property['id']).delete();

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
      favoritesRef.doc(widget.property['id']).get().then((doc) {
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
      subtitle: Text(
          '${widget.property['numOfBedroom']} rooms, ${widget.property['price']}'),
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

class FavoritePropertiesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
// Get the current user's ID
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
// If the user is not signed in, show an error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text('You must be signed in to view your favorite properties.'),
      ));
      return Scaffold();
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
          final favoriteProperties =
              snapshot.data!.docs.map((doc) => doc.data()).toList();
          if (favoriteProperties.isEmpty) {
            return Center(
              child: Text('You have no favorite properties.'),
            );
          }
          return ListView.builder(
            itemCount: favoriteProperties.length,
            itemBuilder: (context, index) {
              final favoriteProperty =
                  favoriteProperties[index] as Map<String, dynamic>;
              return FavoritePropertyListItem(
                  propertyId: favoriteProperty['id'],
                  property: favoriteProperty);
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
    }
// Remove the property from the user's favorites collection in Firestore
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
      title: Text('${widget.property['propertyName']}'),
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

class FilterButton extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onPressed;

  FilterButton(
      {required this.title, required this.isActive, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: isActive ? Colors.blue : Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(title),
    );
  }
}*/
