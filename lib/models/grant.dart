class Grant {
  int numOfBedroom;
  int lease;
  String applicationType;
  String firstTime;
  int averageMonthlyHousehold;
  String citizenship;
  int age;

  int get getNumOfBedroom => this.numOfBedroom;

  set setNumOfBedroom(int numOfBedroom) => this.numOfBedroom = numOfBedroom;

  get getLease => this.lease;

  set setLease(lease) => this.lease = lease;

  get getApplicationType => this.applicationType;

  set setApplicationType(applicationType) =>
      this.applicationType = applicationType;

  get getFirstTime => this.firstTime;

  set setFirstTime(firstTime) => this.firstTime = firstTime;

  get getAverageMonthlyHousehold => this.averageMonthlyHousehold;

  set setAverageMonthlyHousehold(averageMonthlyHousehold) =>
      this.averageMonthlyHousehold = averageMonthlyHousehold;

  get getCitizenship => this.citizenship;

  set setCitizenship(citizenship) => this.citizenship = citizenship;

  get getAge => this.age;

  set setAge(age) => this.age = age;

  Grant({
    required this.numOfBedroom,
    required this.lease,
    required this.applicationType,
    required this.firstTime,
    required this.averageMonthlyHousehold,
    required this.citizenship,
    required this.age,
  });
}
