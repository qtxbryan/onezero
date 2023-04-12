import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:onezero/backend/database.dart';
import 'package:onezero/auth.dart';
import 'package:onezero/models/LocationModel.dart';
import 'package:geocoding/geocoding.dart';
import 'favorite_page.dart';
import 'package:onezero/components/property_card.dart';
import 'package:onezero/components/filter_button.dart';
import 'settings_page.dart';
import 'new_add_property_page.dart';
import 'my_properties_page.dart';
import 'dart:async';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  final screens = [
    Center(child: Text('Home', style: TextStyle(fontSize: 60))),
    Center(child: Text('Feed', style: TextStyle(fontSize: 60))),
    Center(child: Text('Chat', style: TextStyle(fontSize: 60))),
    Center(child: Text('My property', style: TextStyle(fontSize: 60))),
    Center(child: Text('Profile', style: TextStyle(fontSize: 60))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF0F0F0),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xFF41436A),
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
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
        body: IndexedStack(
          children: screens,
        ));
  }
}
