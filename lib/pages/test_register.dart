import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onezero/pages/new_user_page.dart';
import '../auth.dart';
import 'package:onezero/flutter_flow/flutter_flow_theme.dart';
import 'package:onezero/controller/validations.dart';

class TestRegisterPage extends StatefulWidget {
  const TestRegisterPage({super.key});

  @override
  State<TestRegisterPage> createState() => _TestRegisterPageState();
}

class _TestRegisterPageState extends State<TestRegisterPage> {
  String? errorMessage = '';

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );

      // Get the current user and create a new document with their data
      User? user = Auth().currentUser;
      await FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
        'email': user?.email,
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Humm ? ${errorMessage}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Register'),
          backgroundColor: Color(0xFF41436A),
        ),
        body: Form(
            key: _formKey,
            child: Container(
                height: double.infinity,
                width: double.infinity,
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _controllerEmail,
                      validator: validateEmail,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email...',
                        labelStyle: TextStyle(
                          fontFamily: 'Outfit',
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                        hintStyle: FlutterFlowTheme.of(context).bodyText1,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        filled: true,
                        fillColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        contentPadding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 24.0, 0.0, 24.0),
                      ),
                      style: FlutterFlowTheme.of(context).subtitle2, //
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 16.0),
                    ),
                    TextFormField(
                      controller: _controllerPassword,
                      validator: validatePassword, // VALIDATE PASSWORD
                      obscureText: true, //OBSCURE TEXT FOR PASSWORD
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password...',
                        labelStyle: TextStyle(
                          fontFamily: 'Outfit',
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                        hintStyle: FlutterFlowTheme.of(context).bodyText1,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        filled: true,
                        fillColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        contentPadding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 24.0, 0.0, 24.0),
                      ),
                      style: FlutterFlowTheme.of(context).subtitle2, //
                    ),
                    _errorMessage(),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFFF64668)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20.0), // Adjust the border radius value here
                          ),
                        ),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal:
                                  40.0), // Adjust the padding values here
                        ),
                        // You can add more style properties here if needed, such as textStyle, elevation, etc.
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print("test");
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) => NewUserPageWidget(
                                  email: _controllerEmail.text,
                                  password: _controllerPassword
                                      .text)))); // Navigate to next page
                        }
                      },
                      child: Text('Continue', style: TextStyle(fontSize: 16.0)),
                    ),
                  ],
                ))));
  }
}
