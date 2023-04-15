import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:onezero/controller/grantController.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:onezero/models/grant.dart';
import '../controller/auth.dart';
import 'package:onezero/controller/database.dart';
import 'package:onezero/controller/userController.dart';
import '../constants.dart';

class EditGrantProfileWidget extends StatefulWidget {
  Database db = Database();
  bool grant;
  final int numOfBedroom;
  final int lease;

  EditGrantProfileWidget({
    Key? key,
    required this.grant,
    required this.numOfBedroom,
    required this.lease,
  }) : super(key: key);

  @override
  State<EditGrantProfileWidget> createState() => _EditGrantProfileWidgetState();
}

class _EditGrantProfileWidgetState extends State<EditGrantProfileWidget> {
  // late final User? _user;
  // late final Stream<DocumentSnapshot> _userDocStream;

  UserController userController = UserController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _user = Auth().currentUser;
    // _userDocStream = widget.db.readSingleDocument('users', _user!.uid);
  }

  Widget getGrant(List grants) {
    return new Column(
      children: grants
          .map((item) => new Text(
                item.toString(),
                style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Poppins',
                      fontSize: 10.0,
                      color: Color(TEXT_COLOR),
                    ),
              ))
          .toList(),
    );
  }

  Widget getGrantAward(List grants) {
    return new Column(
      children: grants
          .map((item) => new Text(
                item.toString(),
                style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Poppins',
                      fontSize: 12.0,
                      color: Color(TEXT_COLOR),
                    ),
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: userController.getUserDocStream(),
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

          if (snapshot.hasData && snapshot.data!.exists) {
            final userProfileData =
                snapshot.data!.data() as Map<String, dynamic>;

            bool hasEmptyFields;

            GrantController grantController =
                GrantController(userProfileData: userProfileData);

            hasEmptyFields = grantController.hasEmptyFields(
                widget.numOfBedroom, widget.lease);

            if (hasEmptyFields) {
              return Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text(
                    'No Profile Data Found',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      color: Color(ALTERNATE_COLOR),
                    ),
                  ));
            } else {
              List grants = grantController.getGrantAwarded();

              //True to dispaly grantAwarded
              if (widget.grant == true) {
                return new Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [getGrant(grants[0])],
                    ));
              }
              return new Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [getGrantAward(grants[1])],
                  ));
            }
          } else {
            return Center(child: Text("No profile record!"));
          }
        });
  }
}
