import 'package:onezero/constants.dart';
import 'package:onezero/pages/main_page.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../controller/auth.dart';
import 'register_page.dart';
import 'package:onezero/controller/validations.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({Key? key}) : super(key: key);

  @override
  _LoginPageWidgetState createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  String? errorMessage = '';
  bool hasError = false;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool obscureText = true;

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MainPage(),
      ));
    } on FirebaseAuthException catch (e) {
      setState(() {
        hasError = true;
        errorMessage = e.code; // Update error message with error code
      });
    }
  }

  Widget _errorMessage() {
    hasError ? errorMessage : '';
    print('$errorMessage');
    return Center(
      child: Text(
        errorMessage == ''
            ? ''
            : errorMessage == 'invalid-email' // Add condition for invalid email
                ? 'Invalid email.'
                : errorMessage ==
                        'wrong-password' // Add condition for wrong password
                    ? 'Wrong password.'
                    : 'Account does not exist.',
        style: TextStyle(
          color: Colors.red,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>(); // Initialize _formKey in initState()
  }

  Widget _loginButton() {
    return FFButtonWidget(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          setState(() {
            errorMessage = ''; // Clear error message before validating form
          });
          signInWithEmailAndPassword();
        }
      },
      text: 'Login',
      options: FFButtonOptions(
        width: 130,
        height: 50,
        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        color: Color(0xFF4B39EF),
        textStyle: FlutterFlowTheme.of(context).bodyText1.override(
              fontFamily: 'Outfit',
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
        elevation: 3,
        borderSide: BorderSide(
          color: Colors.transparent,
          width: 1,
        ),
      ),
    );
  }

  Widget TextField(controller, hintText, labelText) {
    return TextFormField(
      controller: controller,
      validator: validateEmail,
      obscureText: false,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: FlutterFlowTheme.of(context).bodyText2.override(
              fontFamily: 'Outfit',
              color: Color(0xFF57636C),
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
        hintText: hintText,
        hintStyle: FlutterFlowTheme.of(context).bodyText1.override(
              fontFamily: 'Outfit',
              color: Color(0xFF57636C),
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFF1F4F8),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(40),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(PRIMARY_COLOR),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(40),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0x00000000),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(40),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(ALTERNATE_COLOR),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(40),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
      ),
      style: FlutterFlowTheme.of(context).bodyText1.override(
            fontFamily: 'Outfit',
            color: Color(0xFF0F1113),
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
      maxLines: null,
    );
  }

  Widget PasswordTextField(controller, hintText, labelText) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validatePassword,
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: FlutterFlowTheme.of(context).bodyText2.override(
              fontFamily: 'Outfit',
              color: Color(0xFF57636C),
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
        hintText: hintText,
        hintStyle: FlutterFlowTheme.of(context).bodyText2.override(
              fontFamily: 'Outfit',
              color: Color(0xFF57636C),
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFF1F4F8),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(40),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(PRIMARY_COLOR),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(40),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0x00000000),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(40),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(ALTERNATE_COLOR),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(40),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsetsDirectional.fromSTEB(16, 24, 24, 24),
        suffixIcon: InkWell(
          onTap: () {
            setState(() {
              obscureText = false;
            });
          },
          focusNode: FocusNode(skipTraversal: true),
          child: Icon(
            obscureText
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: Color(0xFF57636C),
            size: 22,
          ),
        ),
      ),
      style: FlutterFlowTheme.of(context).bodyText1.override(
            fontFamily: 'Outfit',
            color: Color(0xFF0F1113),
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 70, 0, 30),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (Theme.of(context).brightness ==
                                Brightness.light)
                              Image.asset(
                                'assets/images/flatfinder.png',
                                width: 242,
                                height: 120,
                                fit: BoxFit.fitWidth,
                              ),
                            if (Theme.of(context).brightness == Brightness.dark)
                              Image.network(
                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/template-screens-hpce0u/assets/xofl99y11az0/@3xlogo_primary_color_white.png',
                                width: 242,
                                height: 60,
                                fit: BoxFit.fitWidth,
                              ),
                          ],
                        ),
                      ),
                      Text(
                        'Welcome Back!',
                        style: FlutterFlowTheme.of(context).bodyText2.override(
                              fontFamily: 'Outfit',
                              color: Color(0xFF0F1113),
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
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
                                    EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                                child: TextField(
                                    _controllerEmail,
                                    "Enter your email here ...",
                                    'Email Address'),
                              ),
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
                              child: PasswordTextField(_controllerPassword,
                                  'Enter your password here ...', 'Password'),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FFButtonWidget(
                              onPressed: () {
                                print('Button-ForgotPassword pressed ...');
                              },
                              text: 'Forgot Password?',
                              options: FFButtonOptions(
                                width: 170,
                                height: 40,
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                iconPadding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                color: Color(0x00FFFFFF),
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyText2
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF57636C),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                elevation: 0,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                              ),
                            ),
                            _loginButton(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF0F1113),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                            FFButtonWidget(
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            RegisterPageWidget())));
                              },
                              text: 'Create Account',
                              options: FFButtonOptions(
                                width: 150,
                                height: 30,
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                iconPadding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                color: Color(0x00FFFFFF),
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyText2
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF39D2C0),
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                elevation: 0,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      _errorMessage(),
                    ],
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
