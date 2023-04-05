import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _imageFile;
  String? _imageURL;

  final picker = ImagePicker();

  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = File(pickedFile!.path);
    });
  }

  Future uploadImageToFirebase() async {
    final storage = FirebaseStorage.instance;
    final snapshot = await storage
        .ref()
        .child('users/${DateTime.now().microsecondsSinceEpoch}.jpg')
        .putFile(_imageFile!);
    final downloadURL = await snapshot.ref.getDownloadURL();
    setState(() {
      _imageURL = downloadURL;
    });
  }

  Widget buildProfileImage() {
    if (_imageFile != null) {
      return Image.file(_imageFile!);
    } else if (_imageURL != null) {
      return Image.network(_imageURL!);
    } else {
      return Placeholder();
    }
  }

  Widget buildChangePhotoButton() {
    return ElevatedButton(
      onPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          barrierColor: Color(0xB2090F13),
          context: context,
          builder: (BuildContext context) {
            return ChangePhotoWidget(
              onUploadImage: () {
                getImageFromGallery();
              },
              onSaveImage: () {
                uploadImageToFirebase();
                Navigator.pop(context);
              },
              onCancel: () {
                Navigator.pop(context);
              },
            );
          },
        );
      },
      child: Text('Change Photo'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                if (_imageFile != null || _imageURL != null) {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return buildProfileImage();
                    },
                  );
                } else {
                  getImageFromGallery();
                }
              },
              child: CircleAvatar(
                radius: 75,
                child: buildProfileImage(),
              ),
            ),
            SizedBox(height: 16),
            buildChangePhotoButton(),
          ],
        ),
      ),
    );
  }
}

class ChangePhotoWidget extends StatefulWidget {
  final VoidCallback onUploadImage;
  final VoidCallback onSaveImage;
  final VoidCallback onCancel;

  ChangePhotoWidget({
    required this.onUploadImage,
    required this.onSaveImage,
    required this.onCancel,
  });

  @override
  _ChangePhotoWidgetState createState() => _ChangePhotoWidgetState();
}

class _ChangePhotoWidgetState extends State<ChangePhotoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Change Photo',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          GestureDetector(
            onTap: widget.onUploadImage,
            child: Text(
              'Upload Image',
              style: TextStyle(
                fontSize: 18,
                color: Colors.blue,
              ),
            ),
          ),
          SizedBox(height: 16),
          GestureDetector(
            onTap: widget.onSaveImage,
            child: Text(
              'Save Image',
              style: TextStyle(
                fontSize: 18,
                color: Colors.blue,
              ),
            ),
          ),
          SizedBox(height: 16),
          GestureDetector(
            onTap: widget.onCancel,
            child: Text(
              'Cancel',
              style: TextStyle(
                fontSize: 18,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
