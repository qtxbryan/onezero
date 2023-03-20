import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late final CollectionReference _usersRef;
  late final DocumentReference _userDocRef;
  late final User? _user;
  late final Stream<DocumentSnapshot> _userDocStream;

  @override
  void initState() {
    super.initState();
    _usersRef = FirebaseFirestore.instance.collection('users');
    _user = FirebaseAuth.instance.currentUser;
    _userDocRef = _usersRef.doc(_user!.uid);
    _userDocStream = _userDocRef.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _userDocStream,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData && snapshot.data!.exists) {
            final userProfileData =
                snapshot.data!.data() as Map<String, dynamic>;
            final hasEmptyFields = userProfileData['displayName'] == null ||
                userProfileData['displayName'].isEmpty ||
                userProfileData['email'] == null ||
                userProfileData['email'].isEmpty ||
                userProfileData['age'] == null ||
                userProfileData['age'].isEmpty;

            if (hasEmptyFields) {
              return ElevatedButton(
                onPressed: null,
                child: Text('Edit Profile'),
              );
            } else {
              return MyProfileWidget(userProfileData);
            }
          } else {
            return Center(
              child: ElevatedButton(
                onPressed: null,
                child: Text('Edit Profile'),
              ),
            );
          }
        },
      ),
    );
  }
}

class MyProfileWidget extends StatelessWidget {
  final Map<String, dynamic> _userProfileData;

  const MyProfileWidget(this._userProfileData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _userProfileData['displayName'],
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            _userProfileData['email'],
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8),
          Text(
            _userProfileData['age'],
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

// class EditProfilePage extends StatefulWidget {
//   const EditProfilePage({Key? key}) : super(key: key);

//   @override
//   _EditProfilePageState createState()
