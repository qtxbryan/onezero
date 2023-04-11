import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:onezero/pages/test_register.dart';
import 'package:onezero/pages/new_landing_6-4.dart';
import 'package:onezero/pages/my_properties_page.dart';
import 'test_maps.dart';

import '../auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _unfocusNode = FocusNode();

  String? errorMessage = '';

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => HomePage(),
    ));
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Humm ? $errorMessage');
  }

  Widget _loginButton() {
    return Align(
      alignment: Alignment.center,
      child: OutlinedButton(
        onPressed: signInWithEmailAndPassword,
        child: Text(
          'Login',
          style: TextStyle(
            fontFamily: 'Urbanist',
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(Size(300, 50)),
          padding: MaterialStateProperty.all(EdgeInsets.all(0)),
          backgroundColor: MaterialStateProperty.all(Color(0xFFF64668)),
          elevation: MaterialStateProperty.all(3),
          side: MaterialStateProperty.all(
            BorderSide(
              color: Colors.transparent,
              width: 1,
            ),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }

  Widget TextField(controller, hintText, labelText) {
    return TextFormField(
      controller: controller,
      obscureText: false,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          fontFamily: 'Outfit',
          color: Colors.grey,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: 'Outfit',
          color: Colors.grey,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black, // Set default border color to black
            width: 2,
          ),
          borderRadius: BorderRadius.circular(40),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black, // Set default border color to black
            width: 2,
          ),
          borderRadius: BorderRadius.circular(40),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black, // Set default border color to black
            width: 2,
          ),
          borderRadius: BorderRadius.circular(40),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black, // Set default border color to black
            width: 2,
          ),
          borderRadius: BorderRadius.circular(40),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
      ),
      style: TextStyle(
        fontFamily: 'Outfit',
        color: Color(0xFF0F1113),
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      maxLength: null,
      validator: null,
    );
  }

  Widget PasswordTextField(controller, hintText, labelText) {
    return TextFormField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          fontFamily: 'Outfit',
          color: Colors.grey,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: 'Outfit',
          color: Colors.grey,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black, // Set default border color to black
            width: 2,
          ),
          borderRadius: BorderRadius.circular(40),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black, // Set default border color to black
            width: 2,
          ),
          borderRadius: BorderRadius.circular(40),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black, // Set default border color to black
            width: 2,
          ),
          borderRadius: BorderRadius.circular(40),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black, // Set default border color to black
            width: 2,
          ),
          borderRadius: BorderRadius.circular(40),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
      ),
      style: TextStyle(
        fontFamily: 'Outfit',
        color: Color(0xFF0F1113),
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      maxLength: null,
      validator: null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
            child: Container(
                child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/icon.png',
                          width: 340.7,
                          height: 239.9,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                              child: TextField(
                                  _controllerEmail,
                                  'Enter your email here... ',
                                  'Email Address')),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: PasswordTextField(_controllerPassword,
                              'Enter your password here... ', 'Password'),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 24, 24, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /*TextButton(
                          onPressed: null, //FORGET PASSWORD DOESNT WORK
                          child: Text(
                            'Forget Password?',
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              color: Color(0xFF57636C),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          style: ButtonStyle(
                              fixedSize:
                                  MaterialStateProperty.all(Size(170, 40)),
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.all(0)),
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0x00FFFFFF)),
                              elevation: MaterialStateProperty.all(0),
                              side: MaterialStateProperty.all(BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ))),
                        ),*/
                        Expanded(child: _loginButton()),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Do not have an account?',
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              color: Color(0xFF0F1113),
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TestRegisterPage(),
                                ),
                              );
                            },
                            style: ButtonStyle(
                              fixedSize:
                                  MaterialStateProperty.all(Size(150, 30)),
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.all(0)),
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0x00FFFFFF)),
                              elevation: MaterialStateProperty.all(0),
                              side: MaterialStateProperty.all(BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              )),
                            ),
                            child: Text(
                              'Create Account',
                              style: TextStyle(
                                fontFamily: 'Urbanist',
                                color: Color(0xFF39D2C0),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )),
                  _errorMessage(),
                ],
              ),
            ))));
  }
}
