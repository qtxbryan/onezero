import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth.dart';
import 'package:onezero/backend/database.dart';
import '../constants.dart';

class EditProfileWidget extends StatefulWidget {
  Database db = Database();
  final int numOfBedroom;
  final int lease;

  EditProfileWidget({
    Key? key,
    required this.numOfBedroom,
    required this.lease,
  }) : super(key: key);

  @override
  State<EditProfileWidget> createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
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
    return new Row(
      children: grants.map((item) => new Text(item)).toList(),
    );
  }

  Widget getGrantAward(List grants) {
    return new Row(
      children: grants.map((item) => new Text(item.toString())).toList(),
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
              ///
              ///
              ///

              print('This is displayName: ${userProfileData['displayName']}');
              print(
                  'This is applicationType: ${userProfileData['applicationType']}');
              print(
                  'This is averageMonthlyHousehold: ${userProfileData['averageMonthlyHousehold']}');
              print('This is citizenship: ${userProfileData['Citizenship']}');
              print('This is age: ${userProfileData['age']}');

              print('this is lease: ${widget.lease}');
              print('this is first time ${userProfileData['firstTime']}');

              List<int> grantAmount = [];
              List<String> grantAwarded = [];

              String applicationType = userProfileData['applicationType'];
              String firstTime = userProfileData['firstTime'];
              int averageMonthlyHousehold =
                  int.parse(userProfileData['averageMonthlyHousehold']);
              String citizenship = userProfileData['Citizenship'];
              int age = int.parse(userProfileData['age']);

              if (applicationType == 'Couple' &&
                  firstTime == 'true' &&
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
                  firstTime == 'true' &&
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
                  firstTime == true &&
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

              // RETURN WIDGET HERE
              return Column(
                children: [
                  getGrant(grantAwarded),
                  getGrantAward(grantAmount),
                ],
              );
            }
          } else {
            return Center(
                child: ElevatedButton(
              onPressed: null,
              child: Text('Edit Profile'),
            ));
          }
        });
  }
}
