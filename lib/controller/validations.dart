import 'package:email_validator/email_validator.dart';

// VALIDATE EMAIL
String? validateEmail(String? value) {
  bool isEmail(String input) => EmailValidator.validate(input);
  if (value == null || value.isEmpty) {
    return 'Please enter an email';
  } else if (!isEmail(value)) {
    return 'Please enter a valid email';
  }
  return null;
}

// VALIDATE PASSWORD
String? validatePassword(String? value) {
  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  if (value == null || value.isEmpty) {
    return 'Please enter a password';
  } else if (!regex.hasMatch(value)) {
    return 'Please enter a valid password';
  }
  return null;
}

// VALIDATE DISPLAY NAME
String? validateText(String? value) {
  (value) {
    if (value == null || value.isEmpty) {
      print(value);
      return 'Please enter display name';
    }
    return null;
  };
}

// VALIDATE AGE
String? validateAge(String? value) {
  RegExp regex = RegExp(r'^[0-9]+$');
  if (value == null || value.isEmpty) {
    return 'Please enter an age';
  } else if (!regex.hasMatch(value)) {
    return 'Please enter a valid age';
  }
  return null;
}
