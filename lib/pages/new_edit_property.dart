import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:onezero/controller/textInputFormatter.dart';
import 'package:onezero/controller/validations.dart';
import 'dart:io';
import 'package:onezero/models/Listing.dart';
import 'package:onezero/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cached_network_image/cached_network_image.dart';

class EditPropertyPage extends StatefulWidget {
  EditPropertyPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _EditPropertyPageState createState() => _EditPropertyPageState();
}

class _EditPropertyPageState extends State<EditPropertyPage> {
  String? _imageUrl;
  final TextEditingController _propertyNameController = TextEditingController();

  void _handleImageUrlChanged(String url) {
    setState(() {
      _imageUrl = url;
    });
  }

  void _handleSaveButtonPressed() async {
    final propertyName = _propertyNameController.text;
    if (propertyName.isEmpty) return;

    if (_imageUrl == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please select an image.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    final document = FirebaseFirestore.instance.collection('properties').doc();
    await document.set({
      'name': propertyName,
      'imageUrl': _imageUrl!,
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Success'),
        content: Text('Property saved.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _propertyNameController.clear();
              setState(() {
                _imageUrl = null;
              });
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF41436A),
        elevation: 0,
        title: Text(
          'My Properties',
          style: FlutterFlowTheme.of(context).bodyText1.override(
                fontFamily: 'Urbanist',
                color: Colors.white,
                fontSize: 18.0,
              ),
        ),
        actions: [],
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_imageUrl != null) ...[
              MyImageWidget(imageUrl: _imageUrl!),
              SizedBox(height: 8),
            ],
            MyUploadWidget(onImageUrlChanged: _handleImageUrlChanged),
            SizedBox(height: 8),
            TextField(
              controller: _propertyNameController,
              decoration: InputDecoration(
                hintText: 'Property name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: _handleSaveButtonPressed,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyImageWidget extends StatelessWidget {
  final String imageUrl;

  const MyImageWidget({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}

class MyUploadWidget extends StatefulWidget {
  final void Function(String) onImageUrlChanged;

  const MyUploadWidget({Key? key, required this.onImageUrlChanged})
      : super(key: key);

  @override
  _MyUploadWidgetState createState() => _MyUploadWidgetState();
}

class _MyUploadWidgetState extends State<MyUploadWidget> {
  late final ImagePicker _imagePicker;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    final file = File(pickedFile.path);
    final ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('images/${DateTime.now().millisecondsSinceEpoch}');
    final uploadTask = ref.putFile(file);
    final snapshot = await uploadTask.whenComplete(() {});
    final downloadUrl = await snapshot.ref.getDownloadURL();

    setState(() {
      _imageUrl = downloadUrl;
    });
    widget.onImageUrlChanged(downloadUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_imageUrl != null) ...[
          Image.network(_imageUrl!),
          SizedBox(height: 8),
        ],
        ElevatedButton(
          onPressed: _pickImage,
          child: Text('Change photo'),
        ),
      ],
    );
  }
}
