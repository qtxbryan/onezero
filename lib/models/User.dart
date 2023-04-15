class UserModel {
  late final String? uid;
  late final String? displayName;
  late final String? emailAddress;
  late final int? age;
  late final String? citizenship;
  late final String? martial;
  late final String? applicationType;
  late final int? averageMontlyHousehold;
  late final bool? firstTime;

  UserModel({
    required this.uid,
    this.displayName,
    this.emailAddress,
    this.age,
    this.citizenship,
    this.martial,
    this.applicationType,
    this.averageMontlyHousehold,
    this.firstTime,
  });
}
