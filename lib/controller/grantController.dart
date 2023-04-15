import 'package:onezero/constants.dart';
import 'package:onezero/models/grant.dart';

class GrantController {
  late Grant grant;
  final userProfileData;

  GrantController({this.userProfileData});

  // Check for empty fields
  bool hasEmptyFields(int numOfBedroom, int lease) {
    if (userProfileData['displayName'] == null ||
        userProfileData['displayName'].isEmpty ||
        userProfileData['citizenship'] == null ||
        userProfileData['citizenship'].isEmpty ||
        userProfileData['Martial'] == null ||
        userProfileData['Martial'].isEmpty ||
        userProfileData['age'] == null ||
        userProfileData['age'].isEmpty ||
        userProfileData['averageMonthlyHousehold'] == null ||
        userProfileData['averageMonthlyHousehold'].isEmpty ||
        userProfileData['applicationType'] == null ||
        userProfileData['applicationType'].isEmpty) {
      return true;
    }

    grant = Grant(
        numOfBedroom: numOfBedroom,
        lease: lease,
        applicationType: userProfileData['applicationType'],
        firstTime: userProfileData['firstTime'],
        averageMonthlyHousehold: userProfileData['averageMonthlyHousehold'],
        citizenship: userProfileData['citizenship'],
        age: userProfileData['age']);

    return false;
  }

  // Return grant awarded
  List getGrantAwarded() {
    List<String> grantAwarded = [];
    List<int> grantAmount = [];

    List grants = [];
    if (grant.applicationType == 'Couple' &&
        grant.firstTime == 'Yes' &&
        grant.averageMonthlyHousehold <= 14000 &&
        grant.citizenship == 'Singaporean' &&
        grant.age >= 21 &&
        grant.lease > 20) {
      if (grant.averageMonthlyHousehold < 9000) {
        grantAmount.add(ENHANCED_CPF_HOUSING_AMOUNT);
        grantAwarded.add(ENHANCED_CPF_HOUSING);
      }

      if (grant.numOfBedroom <= 4) {
        grantAmount.add(CPF_HOUSING_GRANT_AMOUNT);
        grantAwarded.add(CPF_HOUSING_GRANT);
        print('hit inner loop for 4 room');
      } else {
        grantAmount.add(CPF_HOUSING_GRANT_AMOUNT_5RM);
        grantAwarded.add(CPF_HOUSING_GRANT_5RM);
      }
    } else if (grant.applicationType == 'Family' &&
        grant.firstTime == 'Yes' &&
        grant.averageMonthlyHousehold <= 21000 &&
        grant.citizenship == 'Singaporean' &&
        grant.age >= 21 &&
        grant.lease > 20) {
      if (grant.averageMonthlyHousehold < 4500) {
        grantAmount.add(ENHANCED_CPF_HOUSING_AMOUNT);
        grantAwarded.add(ENHANCED_CPF_HOUSING);
      }

      if (grant.numOfBedroom <= 4) {
        grantAmount.add(CPF_HOUSING_GRANT_AMOUNT_FAMILY);
        grantAwarded.add(CPF_HOUSING_GRANT_FAMILY);
      } else {
        grantAmount.add(CPF_HOUSING_GRANT_AMOUNT_FAMILY_5RM);
        grantAwarded.add(CPF_HOUSING_GRANT_FAMILY_5RM);
      }
    } else if (grant.applicationType == 'Single' &&
        grant.firstTime == "Yes" &&
        grant.averageMonthlyHousehold <= 7000 &&
        grant.citizenship == 'Singaporean' &&
        grant.age >= 35 &&
        grant.lease > 20) {
      if (grant.numOfBedroom <= 4) {
        grantAmount.add(SINGLE_GRANT_AMOUNT);
        grantAwarded.add(SINGLE_GRANT);
      } else {
        grantAmount.add(SINGLE_GRANT_5RM_AMOUNT);
        grantAwarded.add(SINGLE_GRANT_5RM);
      }
    } else {
      grantAmount.add(0);
      grantAwarded.add("Not Applicable");
    }

    grants.add(grantAwarded);
    grants.add(grantAmount);

    return grants;
  }
}
