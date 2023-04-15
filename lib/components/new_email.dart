import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:onezero/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class EmailWidget extends StatefulWidget {
  final String listed_by;

  EmailWidget({
    required this.listed_by,
  });

  @override
  State<EmailWidget> createState() => _EmailWidgetState();
}

class _EmailWidgetState extends State<EmailWidget> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final messageController = TextEditingController();

  Future sendEmail(String name, String email, String message) async {
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    print("THIS IS EMAIL ${email}");
    final response = await http.post(url,
        headers: {
          'origin': 'http://localhost',
          'Content-Type': 'application/json'
        },
        body: json.encode({
          'service_id': "service_grf079c",
          'template_id': "template_ojqu43u",
          'user_id': "XtWI0luSjZUter1Am",
          'template_params': {
            'from_name': name,
            'from_email': email,
            'message': message
          }
        }));

    print("error ${response.body}");
    return response.statusCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFF41436A),
          elevation: 0,
          title: Center(
            child: Text(
              'Send Email',
              style: TextStyle(
                fontFamily: 'Urbanist',
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          )),
      backgroundColor: const Color(0xfff5f5fd),
      body: Center(
        child: Container(
          height: 450,
          width: 400,
          margin: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 20,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 20,
          ),
          decoration: BoxDecoration(
              color: Color(0xfff5f5fd),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 5),
                    blurRadius: 10,
                    spreadRadius: 1,
                    color: Colors.grey[300]!)
              ]),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*Required';
                    }
                    return null;
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    hintText: 'Enter here',
                    hintStyle: FlutterFlowTheme.of(context).bodyText2,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(ACCENT_1),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(PRIMARY_COLOR),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).alternate,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).alternate,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: Icon(
                      Icons.person,
                      color: FlutterFlowTheme.of(context).alternate,
                      size: 18.0,
                    ),
                  ),
                  style: FlutterFlowTheme.of(context)
                      .bodyText1
                      .override(color: Colors.black, fontFamily: 'Poppins'),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextFormField(
                    controller: messageController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*Required';
                      }
                      return null;
                    },
                    maxLines: 5,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Message',
                      hintText: 'Enter your message here',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.0,
                      ),
                      prefixIcon: Icon(
                        Icons.message,
                        color: Colors.grey,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 45,
                  width: 300,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Color(PRIMARY_COLOR),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final response = await sendEmail(
                            nameController.value.text,
                            widget.listed_by,
                            messageController.value.text);
                        ScaffoldMessenger.of(context).showSnackBar(
                          response == 200
                              ? const SnackBar(
                                  content: Text('Message Sent!'),
                                  backgroundColor: Colors.green)
                              : const SnackBar(
                                  content: Text('Failed to send message!'),
                                  backgroundColor: Colors.red),
                        );
                        nameController.clear();
                        messageController.clear();
                      }
                    },
                    child: const Text('Send', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
