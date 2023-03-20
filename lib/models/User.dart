class User {
  late final String? uid;
  late final String? displayName;
  late final String? emailAddress;
  late final int? age;
  late final String? citizenship;
  late final String? martial;
  late final String? applicationStatus;
  late final String? applicationType;
  late final int? averageMontlyHousehold;
  late final bool? firstTime;

  User({
    required this.uid,
    required this.displayName,
    required this.emailAddress,
    required this.age,
    this.citizenship,
    this.martial,
    this.applicationStatus,
    this.applicationType,
    this.averageMontlyHousehold,
    this.firstTime,
  });
}
