import 'package:onezero/pages/landing_page.dart';
import 'package:onezero/pages/test_grant.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth.dart';

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
        .push(MaterialPageRoute(builder: ((context) => LandingPage())));
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
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30.0,
          borderWidth: 1.0,
          buttonSize: 60.0,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 30.0,
          ),
          onPressed: () async {
           // context.pushNamed('createProperty_1Test');
          },
        ),
        title: Text(
          'Create Your Profile',
          style: FlutterFlowTheme.of(context).title2.override(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: 22.0,
              ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 2.0,
      ),
        ),
      
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            // Padding(
            //   padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
            //   child: Row(
            //     mainAxisSize: MainAxisSize.max,
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       InkWell(
            //         onTap: () async {
            //           final selectedMedia =
            //               await selectMediaWithSourceBottomSheet(
            //             context: context,
            //             allowPhoto: true,
            //           );
            //           if (selectedMedia != null &&
            //               selectedMedia.every((m) =>
            //                   validateFileFormat(m.storagePath, context))) {
            //             setState(() => _model.isMediaUploading = true);
            //             var selectedUploadedFiles = <FFUploadedFile>[];
            //             var downloadUrls = <String>[];
            //             try {
            //               selectedUploadedFiles = selectedMedia
            //                   .map((m) => FFUploadedFile(
            //                         name: m.storagePath.split('/').last,
            //                         bytes: m.bytes,
            //                         height: m.dimensions?.height,
            //                         width: m.dimensions?.width,
            //                       ))
            //                   .toList();

            //               downloadUrls = (await Future.wait(
            //                 selectedMedia.map(
            //                   (m) async =>
            //                       await uploadData(m.storagePath, m.bytes),
            //                 ),
            //               ))
            //                   .where((u) => u != null)
            //                   .map((u) => u!)
            //                   .toList();
            //             } finally {
            //               _model.isMediaUploading = false;
            //             }
            //             if (selectedUploadedFiles.length ==
            //                     selectedMedia.length &&
            //                 downloadUrls.length == selectedMedia.length) {
            //               setState(() {
            //                 _model.uploadedLocalFile =
            //                     selectedUploadedFiles.first;
            //                 _model.uploadedFileUrl = downloadUrls.first;
            //               });
            //             } else {
            //               setState(() {});
            //               return;
            //             }
            //           }
            //         },
            //         child: Container(
            //           width: 100,
            //           height: 100,
            //           decoration: BoxDecoration(
            //             color: Color(0xFFDBE2E7),
            //             shape: BoxShape.circle,
            //           ),
            //           child: Container(
            //             width: 120,
            //             height: 120,
            //             clipBehavior: Clip.antiAlias,
            //             decoration: BoxDecoration(
            //               shape: BoxShape.circle,
            //             ),
            //             child: Image.network(
            //               _model.uploadedFileUrl,
            //               fit: BoxFit.cover,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 24.0, 20, 16.0),
                        child: TextFormField(
                          controller: displayNameController,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            labelStyle: FlutterFlowTheme.of(context).bodyText1,
                            hintText: 'Enter Your Name',
                            hintStyle: FlutterFlowTheme.of(context).bodyText1,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            filled: true,
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            contentPadding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 24.0, 0.0, 24.0),
                          ),
                          style: FlutterFlowTheme.of(context).subtitle2,
                        ),
                      ),
            Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 20, 16.0),
                        child: TextFormField(
                          controller: ageController,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Age',
                            labelStyle: FlutterFlowTheme.of(context).bodyText1,
                            hintText: 'Enter Your Age',
                            hintStyle: FlutterFlowTheme.of(context).bodyText1,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            filled: true,
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            contentPadding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 24.0, 0.0, 24.0),
                          ),
                          style: FlutterFlowTheme.of(context).subtitle2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 20, 16.0),
                        child: TextFormField(
                          controller: ageController,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            labelStyle: FlutterFlowTheme.of(context).bodyText1,
                            hintText: 'Enter Your Phone Number',
                            hintStyle: FlutterFlowTheme.of(context).bodyText1,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            filled: true,
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            contentPadding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 24.0, 0.0, 24.0),
                          ),
                          style: FlutterFlowTheme.of(context).subtitle2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0,20, 16.0),
                        child: TextFormField(
                          controller: ageController,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Address',
                            labelStyle: FlutterFlowTheme.of(context).bodyText1,
                            hintText: 'Enter Your Address',
                            hintStyle: FlutterFlowTheme.of(context).bodyText1,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            filled: true,
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            contentPadding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 24.0, 0.0, 24.0),
                          ),
                          style: FlutterFlowTheme.of(context).subtitle2,
                        ),
                      ),
            Align(
              alignment: AlignmentDirectional(0, 0.05),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                child: FFButtonWidget(
                  onPressed: createUserWithEmailAndPassword,
                  text: 'Continue',
                  options: FFButtonOptions(
                    width: 270,
                    height: 50,
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    color: Color(0xFFF64668),
                    textStyle: FlutterFlowTheme.of(context).subtitle1.override(
                          fontFamily: 'Outfit',
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                    elevation: 2,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
