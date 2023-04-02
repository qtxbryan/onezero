import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
//import '/flutter_flow/upload_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/models/create_property1_test_model.dart';
export '/models/create_property1_test_model.dart';
import 'package:onezero/pages/landing_page.dart';

import 'package:onezero/pages/create_property2_widget.dart';
class EditPropertyWidget extends StatefulWidget {
  const EditPropertyWidget({
    Key? key,
    this.owner,
  }) : super(key: key);

  final DocumentReference? owner;

  @override
  _EditPropertyState createState() =>
      _EditPropertyState();
}

class _EditPropertyState extends State<EditPropertyWidget> {
  late EditPropertyWidget _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    //_model = createModel(context, () => CreateProperty1TestModel());

   // _model.propertyAddressController ??= TextEditingController();
   // _model.propertyNeighborhoodController ??= TextEditingController();
    //_model.propertyDescriptionController ??= TextEditingController();
  }

  @override
  void dispose() {
   // _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, 
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
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
                    Navigator.pop(context);
                  },
        ),
        title: Text(
          'Edit Listing',
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
      body: SafeArea(
        child: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 70.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 20.0, 20.0, 10),
                                child: GestureDetector(
                                  onTap: () {print('click on edit');},
                                  child: Image.asset('assets/images/icon.png',fit: BoxFit.cover,)
                                  
                                  /*
                                    final selectedMedia = await selectMedia(
                                      mediaSource: MediaSource.photoGallery,
                                      multiImage: false,
                                    );
                                    if (selectedMedia != null &&
                                        selectedMedia.every((m) =>
                                            validateFileFormat(
                                                m.storagePath, context))) {
                                      setState(
                                          () => _model.isDataUploading = true);
                                      var selectedUploadedFiles =
                                          <FFUploadedFile>[];

                                      try {
                                        selectedUploadedFiles = selectedMedia
                                            .map((m) => FFUploadedFile(
                                                  name: m.storagePath
                                                      .split('/')
                                                      .last,
                                                  bytes: m.bytes,
                                                  height: m.dimensions?.height,
                                                  width: m.dimensions?.width,
                                                ))
                                            .toList();
                                      } finally {
                                        _model.isDataUploading = false;
                                      }
                                      if (selectedUploadedFiles.length ==
                                          selectedMedia.length) {
                                        setState(() {
                                          _model.uploadedLocalFile =
                                              selectedUploadedFiles.first;
                                        });
                                      } else {
                                        setState(() {});
                                        return;
                                      }
                                    }
                                  */
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 10.0, 10.0, 10.0),
                                child: Text(
                                  'Tap to add image',
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 4.0, 0.0, 0.0),
                                child: TextFormField(
                                 // controller: _model.propertyAddressController,
                                  
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Address',
                            labelStyle: FlutterFlowTheme.of(context).bodyText1,
                            hintText: 'Enter Address',
                            hintStyle: FlutterFlowTheme.of(context).bodyText1,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).lineGray,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
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
                                    0.0, 12.0, 0.0, 0.0),
                                child: TextFormField(
                                //  controller: _model.propertyAddressController,
                                  
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Neighbourhood',
                            labelStyle: FlutterFlowTheme.of(context).bodyText1,
                            hintText: 'Enter neighbourhood',
                            hintStyle: FlutterFlowTheme.of(context).bodyText1,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).lineGray,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
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
                                    0.0, 12.0, 0.0, 0.0),
                                child: TextFormField(
                               //   controller: _model.propertyDescriptionController,
                                  
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Description',
                            labelStyle: FlutterFlowTheme.of(context).bodyText1,
                            hintText: 'Enter Description',
                            hintStyle: FlutterFlowTheme.of(context).bodyText1,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).lineGray,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
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
                                    0.0, 12.0, 0.0, 0.0),
                                child: TextFormField(
                              //    controller: _model.propertyAddressController,
                                  
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Price',
                            labelStyle: FlutterFlowTheme.of(context).bodyText1,
                            hintText: 'Enter Price',
                            hintStyle: FlutterFlowTheme.of(context).bodyText1,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).lineGray,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
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
                                    0.0, 12.0, 0.0, 0.0),
                                child: TextFormField(
                                //  controller: _model.propertyAddressController,
                                  
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Number of Bedrooms',
                            labelStyle: FlutterFlowTheme.of(context).bodyText1,
                            hintText: 'Enter Number of Bedrooms',
                            hintStyle: FlutterFlowTheme.of(context).bodyText1,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).lineGray,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
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
                                    0.0, 12.0, 0.0, 0.0),
                                child: TextFormField(
                                 // controller: _model.propertyAddressController,
                                  
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Number of Bathrooms',
                            labelStyle: FlutterFlowTheme.of(context).bodyText1,
                            hintText: 'Enter Number of Bathrooms',
                            hintStyle: FlutterFlowTheme.of(context).bodyText1,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).lineGray,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
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
                                    0.0, 12.0, 0.0, 0.0),
                                child: TextFormField(
                                //  controller: _model.propertyAddressController,
                                  
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Dimension',
                            labelStyle: FlutterFlowTheme.of(context).bodyText1,
                            hintText: 'Enter Dimensions',
                            hintStyle: FlutterFlowTheme.of(context).bodyText1,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).lineGray,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
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
                                    0.0, 12.0, 0.0, 0.0),
                                child: TextFormField(
                                 // controller: _model.propertyAddressController,
                                  
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Leftover Lease',
                            labelStyle: FlutterFlowTheme.of(context).bodyText1,
                            hintText: 'Enter Leftover Lease',
                            hintStyle: FlutterFlowTheme.of(context).bodyText1,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).lineGray,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
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
                                    0.0, 12.0, 0.0, 12.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      
                                    ),
                                        OutlinedButton(
                                  onPressed: () async {
                              var confirmDialogResponse = await showDialog<bool>(
                        context: context,
                        builder: (alertDialogContext) {
                          return AlertDialog(
                            title: Text('Edit Listing'),
                            content: Text('Are you sure you want to edit the property?'),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(alertDialogContext, false),
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(alertDialogContext, true),
                                child: Text('Confirm'),
                              ),
                            ],
                          );
                        },
                      );
                        
           // context.pop();
          
                                  },
                                  child: Text(
                                    'Save Changes',
                                    style: TextStyle(
                                      fontFamily: 'Helvetica-Neue',
                                      color: Colors.white,
                                    ),
                                  ),
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(2),
                                    fixedSize: MaterialStateProperty.all(
                                        Size(270, 50)),
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.all(0)),
                                    backgroundColor: MaterialStateProperty.all(
                                        Color(0xFFF64668)),
                                    side: MaterialStateProperty.all(
                                      BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                    ),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                  ),
                                ),


                                   /* FFButtonWidget(
                                      onPressed: () async {
                                        context.pushNamed(
                                          'createProperty_2',
                                          queryParams: {
                                            'description': serializeParam(
                                              _model
                                                  .propertyDescriptionController
                                                  .text,
                                              ParamType.String,
                                            ),
                                            'neighbourhood': serializeParam(
                                              _model
                                                  .propertyNeighborhoodController
                                                  .text,
                                              ParamType.String,
                                            ),
                                            'address': serializeParam(
                                              _model.propertyAddressController
                                                  .text,
                                              ParamType.String,
                                            ),
                                            'owner': serializeParam(
                                              widget.owner,
                                              ParamType.DocumentReference,
                                            ),
                                          }.withoutNulls,
                                        );
                                      },
                                      text: 'NEXT',
                                      options: FFButtonOptions(
                                        width: 120.0,
                                        height: 50.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: Color(0xFFFB4668),
                                        textStyle: FlutterFlowTheme.of(context)
                                            .subtitle2
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                            ),
                                        elevation: 2.0,
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(60.0),
                                      ),
                                    ),*/
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }
}
