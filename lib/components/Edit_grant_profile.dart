import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:onezero/components/GrantCard.dart';
import '/flutter_flow/flutter_flow_theme.dart';

import '../auth.dart';
import 'package:onezero/backend/database.dart';
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
  late final User? _user;
  late final Stream<DocumentSnapshot> _userDocStream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _user = Auth().currentUser;
    _userDocStream = widget.db.readSingleDocument('users', _user!.uid);
  }

  Widget getGrant(List grants) {
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

          if (snapshot.hasData && snapshot.data!.exists) {
            final userProfileData =
                snapshot.data!.data() as Map<String, dynamic>;

            final hasEmptyFields = userProfileData['displayName'] == null ||
                userProfileData['displayName'].isEmpty ||
                userProfileData['Citizenship'] == null ||
                userProfileData['Citizenship'].isEmpty ||
                userProfileData['Martial'] == null ||
                userProfileData['Martial'].isEmpty ||
                userProfileData['age'] == null ||
                userProfileData['age'].isEmpty ||
                userProfileData['applicationStatus'] == null ||
                userProfileData['applicationStatus'].isEmpty ||
                userProfileData['averageMonthlyHousehold'] == null ||
                userProfileData['averageMonthlyHousehold'].isEmpty ||
                userProfileData['applicationType'] == null ||
                userProfileData['applicationType'].isEmpty;

            if (hasEmptyFields) {
              return ElevatedButton(
                onPressed: null, //GO to edit profile page
                child: Text('Edit Profile'),
              );
            } else {
              /// Calculating grant logic

              List<int> grantAmount = [];
              List<String> grantAwarded = [];

              String applicationType = userProfileData['applicationType'];
              String firstTime = userProfileData['firstTime'];
              int averageMonthlyHousehold =
                  int.parse(userProfileData['averageMonthlyHousehold']);
              String citizenship = userProfileData['Citizenship'];
              int age = int.parse(userProfileData['age']);

              //Logic for grant

              if (applicationType == 'Couple' &&
                  firstTime == 'Yes' &&
                  averageMonthlyHousehold <= 14000 &&
                  citizenship == 'Singaporean' &&
                  age >= 21 &&
                  widget.lease > 20) {
                print('Hit first inner loop for couple');

                if (averageMonthlyHousehold < 9000) {
                  grantAmount.add(ENHANCED_CPF_HOUSING_AMOUNT);
                  grantAwarded.add(ENHANCED_CPF_HOUSING);
                }

                if (widget.numOfBedroom <= 4) {
                  grantAmount.add(CPF_HOUSING_GRANT_AMOUNT);
                  grantAwarded.add(CPF_HOUSING_GRANT);
                  print('hit inner loop for 4 room');
                } else {
                  grantAmount.add(CPF_HOUSING_GRANT_AMOUNT_5RM);
                  grantAwarded.add(CPF_HOUSING_GRANT_5RM);
                }
              } else if (applicationType == 'Family' &&
                  firstTime == 'Yes' &&
                  averageMonthlyHousehold <= 21000 &&
                  citizenship == 'Singaporean' &&
                  age >= 21 &&
                  widget.lease > 20) {
                if (averageMonthlyHousehold < 4500) {
                  grantAmount.add(ENHANCED_CPF_HOUSING_AMOUNT);
                  grantAwarded.add(ENHANCED_CPF_HOUSING);
                }

                if (widget.numOfBedroom <= 4) {
                  grantAmount.add(CPF_HOUSING_GRANT_AMOUNT_FAMILY);
                  grantAwarded.add(CPF_HOUSING_GRANT_FAMILY);
                } else {
                  grantAmount.add(CPF_HOUSING_GRANT_AMOUNT_FAMILY_5RM);
                  grantAwarded.add(CPF_HOUSING_GRANT_FAMILY_5RM);
                }
              } else if (applicationType == 'Singles' &&
                  firstTime == "Yes" &&
                  averageMonthlyHousehold <= 7000 &&
                  citizenship == 'Singaporean' &&
                  age >= 35 &&
                  widget.lease > 20) {
                if (widget.numOfBedroom <= 4) {
                  grantAmount.add(SINGLE_GRANT_AMOUNT);
                  grantAwarded.add(SINGLE_GRANT);
                } else {
                  grantAmount.add(SINGLE_GRANT_5RM_AMOUNT);
                  grantAwarded.add(SINGLE_GRANT_5RM);
                }
              }

              if (widget.grant == true) {
                return new Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [getGrant(grantAwarded)],
                    ));
              }
              return new Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [getGrantAward(grantAmount)],
                  ));

              // RETURN WIDGET HERE
            }
          } else {
            return Center(child: Text("No profile record!"));
          }
        });
  }
}
