import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth.dart';
import 'new_landing_6-4.dart';

class NewUserPageWidget extends StatefulWidget {
  //Data passed from register page
  final String email;
  final String password;

  const NewUserPageWidget(
      {Key? key, required this.email, required this.password})
      : super(key: key);

  @override
  _NewUserPageWidgetState createState() => _NewUserPageWidgetState();
}

class _NewUserPageWidgetState extends State<NewUserPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String? errorMessage = '';
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: widget.email,
        password: widget.password,
      );

      // Get the current user and create a new document with their data
      User? user = Auth().currentUser;
      await FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
        'email': user?.email,
        'displayName': displayNameController.text,
        'age': ageController.text,
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }

    Navigator.of(context)
        .push(MaterialPageRoute(builder: ((context) => HomePage())));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Your Profile'),
        backgroundColor: Color(0xFF41436A),
        // dk if need remove the back button
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 16),
              child: TextFormField(
                controller: displayNameController,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Display Name',
                  hintText: 'Enter your name...',
                  labelStyle: TextStyle(
                    fontFamily: 'Outfit',
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                  hintStyle: TextStyle(
                    fontFamily: 'Outfit',
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
                ),
                style: FlutterFlowTheme.of(context).subtitle2,
                maxLines: null,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 16),
              child: TextFormField(
                controller: ageController,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Your Age',
                  hintText: 'Enter your age...',
                  labelStyle: TextStyle(
                    fontFamily: 'Outfit',
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                  hintStyle: TextStyle(
                    fontFamily: 'Outfit',
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
                ),
                style: FlutterFlowTheme.of(context).subtitle2,
                maxLines: null,
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0, 0.05),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF64668),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(20.0), // set border radius
                      // You can also set other border properties like borderSide and sideWidth
                    ),
                    minimumSize: Size(150, 50), // set minimum button size
                  ),
                  onPressed: createUserWithEmailAndPassword,
                  child: Text('Register', style: TextStyle(fontSize: 16.0)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
