import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:onezero/models/Listing.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Stream<QuerySnapshot> _listingsStream;
  List<String> _favoriteList = [];

  @override
  void initState() {
    super.initState();
    _listingsStream =
        FirebaseFirestore.instance.collection('listing').snapshots();
    _loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _listingsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          final listings = snapshot.data!.docs
              .map((doc) =>
                  Listing.fromMap(doc.data()! as Map<String, dynamic>, doc.id))
              .toList();

          return ListView.builder(
            itemCount: listings.length,
            itemBuilder: (context, index) {
              final listing = listings[index];

              return ListTile(
                title: Text(listing.propertyName!),
                subtitle: Text(listing.price!),
                trailing: IconButton(
                  icon: Icon(
                    _favoriteList.contains(listing.id!)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: () => _toggleFavorite(listing.id!),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => FavoritesPage(),
              ),
            );
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }

  void _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteList = prefs.getStringList('favoriteList') ?? [];

    setState(() {
      _favoriteList = favoriteList;
    });
  }

  void _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favoriteList', _favoriteList);
  }

  void _toggleFavorite(String id) {
    setState(() {
      if (_favoriteList.contains(id)) {
        _favoriteList.remove(id);
      } else {
        _favoriteList.add(id);
      }

      _saveFavorites();
    });
  }

  bool _isFavorite(String id) {
    return _favoriteList.contains(id);
  }
}

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late Stream<QuerySnapshot> _favoritesStream;
  List<String> _favoriteList = [];
  List<Map<String, dynamic>> _favoriteListings = []; // declare favoriteListings

  @override
  void initState() {
    super.initState();
    _loadFavorites();
    if (_favoriteList.isNotEmpty) {
      _favoritesStream = FirebaseFirestore.instance
          .collection('listing')
          .where(FieldPath.documentId, whereIn: _favoriteList)
          .snapshots();
    } else {
      _favoritesStream = Stream.empty();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites Page'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _favoritesStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.data != null && snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No favorite properties.'),
            );
          }

          _favoriteListings = snapshot.data!.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList();

          return ListView.builder(
            itemCount: _favoriteListings.length,
            itemBuilder: (context, index) {
              final favoriteListing = _favoriteListings[index];
              return ListTile(
                title: Text(favoriteListing['propertyName']),
                subtitle: Text(favoriteListing['price']),
                trailing: IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  onPressed: () => _toggleFavorite(favoriteListing['id']),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }

  void _toggleFavorite(String id) {
    setState(() {
      _favoriteList.remove(id);
      _saveFavorites();
    });
  }

  void _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteList = prefs.getStringList('favoriteList') ?? [];

    setState(() {
      _favoriteList = favoriteList;
    });
  }

  void _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favoriteList', _favoriteList);
  }
}
