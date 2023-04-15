import 'package:flutter/material.dart';

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
