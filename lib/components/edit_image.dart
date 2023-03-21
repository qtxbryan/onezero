import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:onezero/backend/database.dart';
import 'dart:io';

class EditImageWidget extends StatefulWidget {
  const EditImageWidget({super.key});

  @override
  State<EditImageWidget> createState() => _EditImageWidgetState();
}

class _EditImageWidgetState extends State<EditImageWidget> {
  final Database db = Database();
  String? path;
  String fileName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('cloud storage'),
        ),
        body: Column(children: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                final results = await FilePicker.platform.pickFiles(
                  allowMultiple: false,
                  type: FileType.custom,
                  allowedExtensions: ['png', 'jpg', 'jpeg'],
                );

                if (results == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('No File Selected'),
                    ),
                  );

                  return null;
                }

                setState(() {
                  path = results.files.single.path!;
                  fileName = results.files.single.name;
                });

                db.uploadFile(path!, fileName);

                print(path);
                print(fileName);
              },
              child: Text('Upload File'),
            ),
          ),
          SizedBox(height: 16.0),
          path != null
              ? Image.file(File(path!),
                  height: 200.0, width: 200.0, fit: BoxFit.cover)
              : Container(),
        ]));
  }
}
