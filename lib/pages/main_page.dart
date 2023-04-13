import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:onezero/auth.dart';
import 'favorite_page.dart';
import 'settings_page.dart';
import 'new_landing_13-4.dart';
import 'new_add_property_page.dart';
import 'my_properties_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with AutomaticKeepAliveClientMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  final Auth _auth = Auth();

  @override
  bool get wantKeepAlive => true;

  int _selectedTabIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    FavoritePropertiesPage(),
    AddPropertyPageWidget(),
    MyPropertiesWidget(),
    SettingPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    User? user = _auth.currentUser;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF0F0F0),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF41436A),
        currentIndex: _selectedTabIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor:
            Color.fromRGBO(246, 70, 104, 1.0), // set the selected item color
        unselectedItemColor: Colors.white, // set the unselected item color
        // Set custom item height
        // Set your desired height here
      ),
      body: _pages[_selectedTabIndex],
    );
  }
}
