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
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          actions: [],
          flexibleSpace: FlexibleSpaceBar(
            title: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 14),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_rounded,
                              color: Color(0xFF101213),
                              size: 30,
                            ),
                            onPressed: () {
                              print('IconButton pressed ...');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                    child: Text(
                      'Create your Profile',
                      style: FlutterFlowTheme.of(context).title2.override(
                            fontFamily: 'Outfit',
                            color: Color(0xFF101213),
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            centerTitle: true,
            expandedTitleScale: 1.0,
          ),
          elevation: 0,
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
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 16),
              child: TextFormField(
                controller: displayNameController,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Your Name',
                  labelStyle: FlutterFlowTheme.of(context).bodyText2.override(
                        fontFamily: 'Outfit',
                        color: Color(0xFF57636C),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
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
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
                ),
                style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Outfit',
                      color: Color(0xFF101213),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
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
                  labelStyle: FlutterFlowTheme.of(context).bodyText2.override(
                        fontFamily: 'Outfit',
                        color: Color(0xFF57636C),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
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
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
                ),
                style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Outfit',
                      color: Color(0xFF101213),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                maxLines: null,
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
                    color: Color(0xFF4B39EF),
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
