import 'package:onezero/controller/textInputFormatter.dart';
import 'package:onezero/controller/validations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../auth.dart';
import 'package:onezero/backend/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:onezero/pages/change_photo.dart';

class EditProfileWidget extends StatefulWidget {
  const EditProfileWidget({
    Key? key,
  }) : super(key: key);

  @override
  _EditProfileWidgetState createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  Database db = Database();

  File? _imageFile;
  String? _imageURL;

  final picker = ImagePicker();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = File(pickedFile!.path);
    });
  }

  Future uploadImageToFirebase() async {
    final storage = FirebaseStorage.instance;
    final snapshot = await storage
        .ref()
        .child('${DateTime.now().microsecondsSinceEpoch}.jpg')
        .putFile(_imageFile!);

    final downloadURL = await snapshot.ref.getDownloadURL();

    setState(() {
      _imageURL = downloadURL;
    });
  }

  Widget buildProfileImage() {
    if (_imageFile != null) {
      return Image.file(_imageFile!);
    } else if (_imageURL != null) {
      return Image.network(_imageURL!);
    } else {
      return Placeholder();
    }
  }

  Widget buildChangePhotoButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFF64668)),
      onPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          barrierColor: Color(0xB2090F13),
          context: context,
          builder: (BuildContext context) {
            return ChangePhotoWidget(
              onUploadImage: () {
                getImageFromGallery();
              },
              onSaveImage: () async {
                await uploadImageToFirebase();
                Navigator.pop(context);
              },
              onCancel: () {
                Navigator.pop(context);
              },
            );
          },
        );
      },
      child: Text('Change Photo'),
    );
  }

  String? _citizenship;
  final martialController = TextEditingController();
  final addressController = TextEditingController();
  final ageController = TextEditingController();
  String? applicationType;
  final monthlyHouseholdController = TextEditingController();
  final displayNameController = TextEditingController();
  final emailAddressController = TextEditingController();
  String? firstTime;
  final phoneNumberController = TextEditingController();

  String? firstTimeChange;
  String? applicationTypeChange;
  String? _citizenshipChange;

  late final User? _user;
  late final Stream<DocumentSnapshot> _userDocStream;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    _user = Auth().currentUser;
    _userDocStream = db.readSingleDocument('users', _user!.uid);

    FirebaseFirestore.instance
        .collection('users')
        .doc(_user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          Map<String, dynamic> data =
              documentSnapshot.data() as Map<String, dynamic>;
          _imageURL = data['photo_url'];
        });
      }
    });

    buildProfileImage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("IMAGE URL ${_imageURL}");

    return StreamBuilder<DocumentSnapshot>(
        stream: _userDocStream,
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          print(snapshot.data!);

          if (snapshot.hasData) {
            final userProfileData =
                snapshot.data!.data() as Map<String, dynamic>;

            // Check if only email, age and displayName contains data
            // display blank edit profile page with those 3 fields filled up

            //

            martialController.text =
                userProfileData['Martial']?.toString() ?? '';
            addressController.text =
                userProfileData['address']?.toString() ?? '';
            ageController.text = userProfileData['age']?.toString() ?? '';
            _citizenship = userProfileData['Citizenship']?.toString() ?? '';

            applicationType =
                userProfileData['applicationType']?.toString() ?? '';
            monthlyHouseholdController.text =
                userProfileData['averageMonthlyHousehold']?.toString() ?? '';
            displayNameController.text =
                userProfileData['displayName']?.toString() ?? '';
            emailAddressController.text =
                userProfileData['email']?.toString() ?? '';
            firstTime = userProfileData['firstTime']?.toString() ?? '';
            phoneNumberController.text =
                userProfileData['phoneNumber']?.toString() ?? '';

            print('addressController: ${addressController.text}');
            print('maritial : ${martialController.text}');
            print('firstTime : ${firstTime}');
            print('applicationType : ${applicationType}');
            print('_citizenship : ${_citizenship}');

            return Scaffold(
              key: scaffoldKey,
              backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
              appBar: AppBar(
                backgroundColor: Color(0xFF41436A),
                automaticallyImplyLeading: false,
                leading: InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                    size: 24.0,
                  ),
                ),
                title: Align(
                  alignment: AlignmentDirectional(-1.0, 0.0),
                  child: Text(
                    'Edit Profile',
                    textAlign: TextAlign.start,
                    style: FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'Urbanist',
                          color: Colors.white,
                        ),
                  ),
                ),
                actions: [],
                centerTitle: true,
                elevation: 0.0,
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: Color(0xFFDBE2E7),
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    2.0, 2.0, 2.0, 2.0),
                                child: Container(
                                  width: 90.0,
                                  height: 90.0,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: buildProfileImage(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 12.0, 0.0, 16.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [buildChangePhotoButton()],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 0.0, 20.0, 16.0),
                          child: TextFormField(
                            validator: validateFullName,
                            controller: displayNameController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Full Name',
                              labelStyle:
                                  FlutterFlowTheme.of(context).bodyText1,
                              hintText: 'Your full name...',
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
                              20.0, 0.0, 20.0, 12.0),
                          child: TextFormField(
                            validator: validateEmail,
                            controller: emailAddressController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Email Address',
                              labelStyle:
                                  FlutterFlowTheme.of(context).bodyText1,
                              hintText: 'Your email..',
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
                              20.0, 0.0, 20.0, 12.0),
                          child: TextFormField(
                            validator: validatePhoneNumber,
                            controller: phoneNumberController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              labelStyle:
                                  FlutterFlowTheme.of(context).bodyText1,
                              hintText: 'Your Phone Number..',
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
                              20.0, 0.0, 20.0, 12.0),
                          child: TextFormField(
                            validator: validateAddress,
                            controller: addressController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Address',
                              labelStyle:
                                  FlutterFlowTheme.of(context).bodyText1,
                              hintText: 'Where You Live...',
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
                              0.0, 0.0, 0.0, 12.0),
                          child: Container(
                            width: 370.0,
                            height: 70.0,
                            child: InputDecorator(
                              decoration: InputDecoration(
                                labelText: 'First Time Applicant',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        FlutterFlowTheme.of(context).lineGray,
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
                                contentPadding: EdgeInsets.all(10),
                              ),
                              child: DropdownButtonFormField<String>(
                                value: firstTime,
                                items: ['Yes', 'No']
                                    .map<DropdownMenuItem<String>>((val) {
                                  return DropdownMenuItem<String>(
                                    value: val,
                                    child: Text(val),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  setState(() {
                                    print(firstTime);
                                    firstTimeChange = val;
                                  });
                                },
                                onSaved: (val) {
                                  setState(() {
                                    print(firstTime);
                                    firstTimeChange = val;
                                  });
                                },
                                isExpanded: true,
                                icon: const Icon(Icons.arrow_downward),
                                iconSize: 24,
                                elevation: 2,
                                hint: Text(
                                  'First Time Applicants',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Urbanist',
                                        color: Colors.black,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 0.0, 20.0, 12.0),
                          child: TextFormField(
                            validator: validateHouseholdIncome,
                            controller: monthlyHouseholdController,
                            inputFormatters: [ThousandFormatter()],
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Household Income',
                              labelStyle:
                                  FlutterFlowTheme.of(context).bodyText1,
                              hintText: '[Income Ceiling]',
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
                              0.0, 0.0, 0.0, 12.0),
                          child: Container(
                            width: 370.0,
                            height: 70.0,
                            child: InputDecorator(
                              decoration: InputDecoration(
                                labelText: 'Marital Status',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        FlutterFlowTheme.of(context).lineGray,
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
                                contentPadding: EdgeInsets.all(10),
                              ),
                              child: DropdownButtonFormField<String>(
                                value: applicationType,
                                isExpanded: true,
                                items: [
                                  DropdownMenuItem<String>(
                                    value: 'Single',
                                    child: Text('Single'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Couple',
                                    child: Text('Couple'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Family',
                                    child: Text('Family'),
                                  ),
                                ],
                                onChanged: (val) => setState(() {
                                  applicationTypeChange = val;
                                }),
                                onSaved: (val) => setState(() {
                                  applicationTypeChange = val;
                                }),
                                hint: Text(
                                  'Single / Couple / Family',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Urbanist',
                                        color: Colors.black,
                                      ),
                                ),
                                icon: const Icon(Icons.arrow_downward),
                                iconSize: 24,
                                elevation: 2,
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Urbanist',
                                      color: Colors.black,
                                    ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 0.0, 20.0, 12.0),
                          child: TextFormField(
                            validator: validateAge,
                            controller: ageController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Age',
                              labelStyle:
                                  FlutterFlowTheme.of(context).bodyText1,
                              hintText: '[Age]',
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
                              0.0, 0.0, 0.0, 12.0),
                          child: Container(
                            width: 370.0,
                            height: 70.0,
                            child: InputDecorator(
                              decoration: InputDecoration(
                                labelText: 'Citizenship',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        FlutterFlowTheme.of(context).lineGray,
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
                                contentPadding: EdgeInsets.all(10),
                              ),
                              child: DropdownButtonFormField<String>(
                                value: _citizenship,
                                onChanged: (val) => setState(() {
                                  _citizenshipChange = val;
                                }),
                                onSaved: (val) => setState(() {
                                  _citizenshipChange = val;
                                }),
                                items: [
                                  DropdownMenuItem<String>(
                                    value: 'Singaporean',
                                    child: Text('Singaporean'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Permanent Resident',
                                    child: Text('Permanent Resident'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Others',
                                    child: Text('Others'),
                                  ),
                                ],
                                hint: Text(
                                  'Citizenship',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Urbanist',
                                        color: Colors.black,
                                      ),
                                ),
                                isExpanded: true,
                                icon: const Icon(Icons.arrow_downward),
                                iconSize: 24,
                                elevation: 2,
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Urbanist',
                                      color: Colors.black,
                                    ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.05),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 24.0, 0.0, 0.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                // Test form validate
                                if (!formKey.currentState!.validate()) {
                                  return;
                                }

                                if (firstTimeChange == null) {
                                  firstTimeChange = firstTime;
                                }
                                if (applicationTypeChange == null) {
                                  applicationTypeChange = applicationType;
                                }
                                if (_citizenshipChange == null) {
                                  _citizenshipChange = _citizenship;
                                }
                                await db.updateProfile(
                                    _user!.uid,
                                    displayNameController.text,
                                    emailAddressController.text,
                                    phoneNumberController.text,
                                    addressController.text,
                                    ageController.text,
                                    monthlyHouseholdController.text,
                                    applicationTypeChange!,
                                    firstTimeChange!,
                                    martialController.text,
                                    _citizenshipChange!,
                                    _imageURL!);

                                Navigator.pop(context);
                              },
                              text: 'Save Changes',
                              options: FFButtonOptions(
                                width: 340.0,
                                height: 60.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).redApple,
                                textStyle: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                elevation: 2.0,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              key: scaffoldKey,
              backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
              appBar: AppBar(
                backgroundColor: FlutterFlowTheme.of(context).cultured,
                automaticallyImplyLeading: false,
                leading: InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_rounded,
                    color: FlutterFlowTheme.of(context).gunmetal,
                    size: 24.0,
                  ),
                ),
                title: Align(
                  alignment: AlignmentDirectional(-1.0, 0.0),
                  child: Text(
                    'Edit Profile',
                    textAlign: TextAlign.start,
                    style: FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'Urbanist',
                          color: FlutterFlowTheme.of(context).gunmetal,
                        ),
                  ),
                ),
                actions: [],
                centerTitle: true,
                elevation: 0.0,
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: Color(0xFFDBE2E7),
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    2.0, 2.0, 2.0, 2.0),
                                child: Container(
                                  width: 90.0,
                                  height: 90.0,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: _imageURL == ''
                                      ? Image(
                                          image: AssetImage(
                                              'assets/images/icon.png'),
                                          fit: BoxFit.fitWidth)
                                      : Image.network(_imageURL!,
                                          fit: BoxFit.fitWidth),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 12.0, 0.0, 16.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [buildChangePhotoButton()],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 0.0, 20.0, 16.0),
                          child: TextFormField(
                            validator: validateFullName,
                            controller: displayNameController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Full Name',
                              labelStyle:
                                  FlutterFlowTheme.of(context).bodyText1,
                              hintText: 'Your full name...',
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
                              20.0, 0.0, 20.0, 12.0),
                          child: TextFormField(
                            validator: validateEmail,
                            controller: emailAddressController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Email Address',
                              labelStyle:
                                  FlutterFlowTheme.of(context).bodyText1,
                              hintText: 'Your email..',
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
                              20.0, 0.0, 20.0, 12.0),
                          child: TextFormField(
                            validator: validatePhoneNumber,
                            controller: phoneNumberController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              labelStyle:
                                  FlutterFlowTheme.of(context).bodyText1,
                              hintText: 'Your email..',
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
                              20.0, 0.0, 20.0, 12.0),
                          child: TextFormField(
                            validator: validateAddress,
                            controller: addressController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Address',
                              labelStyle:
                                  FlutterFlowTheme.of(context).bodyText1,
                              hintText: 'Where You Live...',
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
                              0.0, 0.0, 0.0, 12.0),
                          child: Container(
                            width: 335.0,
                            height: 70.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(8.0),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).lineGray,
                                width: 2.0,
                              ),
                            ),
                            child: DropdownButton<String>(
                              value: firstTime,
                              onChanged: (val) => setState(() {
                                firstTime = val;
                              }),
                              items: ['Yes', 'No']
                                  .map<DropdownMenuItem<String>>((val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val),
                                );
                              }).toList(),
                              hint: Text('First Time Applicant'),
                              underline: Container(
                                height: 1.0,
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 0.0, 20.0, 12.0),
                          child: TextFormField(
                            validator: validateHouseholdIncome,
                            controller: monthlyHouseholdController,
                            inputFormatters: [ThousandFormatter()],
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Household Income',
                              labelStyle:
                                  FlutterFlowTheme.of(context).bodyText1,
                              hintText: '[Income Ceiling]',
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
                              0.0, 0.0, 0.0, 12.0),
                          child: Container(
                            width: 335.0,
                            height: 70.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(8.0),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).lineGray,
                                width: 2.0,
                              ),
                            ),
                            child: DropdownButton<String>(
                              value: applicationType,
                              onChanged: (val) => setState(() {
                                applicationType = val;
                              }),
                              items: [
                                DropdownMenuItem<String>(
                                  value: 'Single',
                                  child: Text('Single'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Couple',
                                  child: Text('Couple'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Family',
                                  child: Text('Family'),
                                ),
                              ],
                              hint: Text(
                                'Single / Couple / Family',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Urbanist',
                                      color: Colors.black,
                                    ),
                              ),
                              icon: const Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 2,
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Urbanist',
                                    color: Colors.black,
                                  ),
                              underline: Container(
                                height: 1,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 0.0, 20.0, 12.0),
                          child: TextFormField(
                            validator: validateHouseholdIncome,
                            controller: ageController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Age',
                              labelStyle:
                                  FlutterFlowTheme.of(context).bodyText1,
                              hintText: '[Age]',
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
                              0.0, 0.0, 0.0, 12.0),
                          child: Container(
                            width: 335.0,
                            height: 70.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(8.0),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).lineGray,
                                width: 2.0,
                              ),
                            ),
                            child: DropdownButton<String>(
                              value: _citizenship,
                              onChanged: (val) => setState(() {
                                _citizenship = val;
                              }),
                              items: [
                                DropdownMenuItem<String>(
                                  value: 'Singaporean',
                                  child: Text('Singaporean'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Permanent Resident',
                                  child: Text('Permanent Resident'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Others',
                                  child: Text('Others'),
                                ),
                              ],
                              hint: Text(
                                'Citizenship',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Urbanist',
                                      color: Colors.black,
                                    ),
                              ),
                              icon: const Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 2,
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Urbanist',
                                    color: Colors.black,
                                  ),
                              underline: Container(
                                height: 1,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.05),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 24.0, 0.0, 0.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  return;
                                }
                                // Validation passed, perform action
                                await db.updateProfile(
                                    _user!.uid,
                                    displayNameController.text,
                                    emailAddressController.text,
                                    phoneNumberController.text,
                                    addressController.text,
                                    ageController.text,
                                    monthlyHouseholdController.text,
                                    applicationType!,
                                    firstTime!,
                                    martialController.text,
                                    _citizenship!,
                                    _imageURL!);

                                Navigator.pop(context);
                              },
                              text: 'Save Changes',
                              options: FFButtonOptions(
                                width: 340.0,
                                height: 60.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).redApple,
                                textStyle: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                elevation: 2.0,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } // End of streambuilder
        });
  }
}
