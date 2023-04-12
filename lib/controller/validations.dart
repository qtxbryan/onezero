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
String? validateDisplayName(String? value) {
  (value) {
    if (value == null || value.isEmpty) {
      print(value);
      return 'Please enter display name';
    }
    return null;
  };
}

// VALIDATE PROPERTY NAME
String? validatePropertyName(String? value) {
  RegExp regex = RegExp(r'^[0-9A-Za-z\s.,#/-]+$');
  if (value == null) {
    return 'Property name cannot be null';
  } else if (!regex.hasMatch(value)) {
    return 'Invalid property name';
  } else {
    return null;
  }
}

// VALIDATE DESCRIPTION
String? validateDescription(String? value) {
  // Check if value is null, empty, or only consists of whitespace
  if (value == null || value.trim().isEmpty) {
    return 'Please enter description';
  } else {
    return null; // Return null if valid
  }
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

// VALIDATE POSTAL CODE
String? validatePostalCode(String? value) {
  RegExp regex = RegExp(r'^\d{6}$');
  if (value == null) {
    return 'Postal code cannot be null'; // Return an error message for null input
  } else if (!regex.hasMatch(value)) {
    return 'Invalid Singapore postal code'; // Return an error message for invalid postal code
  } else {
    return null; // Return null for valid postal code
  }
}

// VALIDATE BLOCK (auto filled)
String? validateBlock(String? value) {
  RegExp regex = RegExp(r'^Block [A-Za-z0-9]+$');
  if (value == null) {
    return 'Block cannot be null';
  } else if (!regex.hasMatch(value)) {
    return 'Invalid block';
  } else {
    return null;
  }
}

// VALIDATE LEVEL (1-50) there can be level 1 units max is 50 DUXTON
String? validateLevel(String? value) {
  RegExp regex = RegExp(r'^(?:[1-9]|[1-4][0-9]|50)$');
  if (value == null) {
    return 'Block cannot be null';
  } else if (!regex.hasMatch(value)) {
    return 'Floor must be between 1 and 50.';
  } else {
    return null;
  }
}

// VALIDATE UNIT (there can only be 3 digits)
String? validateUnit(String? value) {
  RegExp regex = RegExp(r'^\d{3}$');
  if (value == null) {
    return 'Unit cannot be null';
  } else if (!regex.hasMatch(value)) {
    return 'Unit must be 3 digits.';
  } else {
    return null;
  }
}

// VALIDATE LEASE (between 1 and 99)
String? validateLease(String? value) {
  RegExp regex = RegExp(r'^(?:[1-9]|[1-9][0-9])$');
  if (value == null) {
    return 'Lease cannot be null';
  } else if (!regex.hasMatch(value)) {
    return 'Lease must be between 1 and 99.';
  } else {
    return null;
  }
}

// VALIDATE DIMENSIONS (between 376 and 1614)
String? validateDimensions(String? value) {
  RegExp regex = RegExp(r'^(?:376|[3-9][0-9][0-9]|1[0-5][0-9]{2}|161[0-4])$');
  if (value == null) {
    return 'Dimensions cannot be null';
  } else if (!regex.hasMatch(value)) {
    return 'Dimension must be be between 376 and 1614';
  } else {
    return null;
  }
}

// VALIDATE PRICE
String? validatePrice(String? value) {
  RegExp regex = RegExp(r'^(?:0|[1-9][0-9]{0,5}|999999)$');
  if (value == null) {
    return 'Price cannot be null';
  } else if (!regex.hasMatch(value)) {
    return 'Price must be be between 0 and 999999';
  } else {
    return null;
  }
}

// VALIDATE NEIGHBOURHOOD (longest neighbourhood is 28 characters max)
String? validateNeighborhood(String? value) {
  RegExp regex = RegExp(r'^(?=.{1,28}$)[A-Za-z]+(?:[ -][A-Za-z]+)*$');
  if (value == null) {
    return 'Neighbourhood cannot be null';
  } else if (!regex.hasMatch(value)) {
    return 'Invalid neighbourhood';
  } else {
    return null;
  }
}

// VALIDATE NUMBER OF BEDROOMS
String? validateNumberOfBedrooms(String? value) {
  RegExp regex = RegExp(r'^(?:[2-5])$');
  if (value == null) {
    return 'Number of bedrooms cannot be null';
  } else if (!regex.hasMatch(value)) {
    return 'Invalid number of bedrooms';
  } else {
    return null;
  }
}

// VALIDATE FULL NAME
String? validateFullName(String? value) {
  RegExp regex = RegExp(r'^[a-zA-Z]+(?: [a-zA-Z]+)+$');
  if (value == null) {
    return 'Full Name cannot be null';
  } else if (!regex.hasMatch(value)) {
    return 'Invalid name';
  } else {
    return null;
  }
}

// VALIDATE PHONE NUMBER
String? validatePhoneNumber(String? value) {
  RegExp regex = RegExp(r'^\d{8}$');
  if (value == null) {
    return 'Phone number cannot be null';
  } else if (!regex.hasMatch(value)) {
    return 'Invalid phone number';
  } else {
    return null;
  }
}

// VALIDATE ADDRESS
String? validateAddress(String? value) {
  RegExp regex = RegExp(r'^[0-9A-Za-z\s.,#/-]+$');
  if (value == null) {
    return 'Address cannot be null';
  } else if (!regex.hasMatch(value)) {
    return 'Invalid address';
  } else {
    return null;
  }
}

// VALIDATE HOUSEHOLD INCOME (cannot be negative)
String? validateHouseholdIncome(String? value) {
  RegExp regex = RegExp(r'^\d+(\.\d{1,2})?$');
  if (value == null) {
    return 'Income cannot be null';
  } else if (!regex.hasMatch(value)) {
    return 'Invalid income';
  } else {
    return null;
  }
}

// VALIDATE AGE
String? validateValue(String? value) {
  RegExp regex = RegExp(r'^(?:100|[1-9][0-9]?)$');
  if (value == null) {
    return 'Age cannot be null';
  } else if (!regex.hasMatch(value)) {
    return 'Invalid age';
  } else {
    return null;
  }
}

String? validateStreet(String? value) {
  RegExp regex = RegExp(r'\s(\b\w*\b\s){1,2}\w*');
  if (value == null) {
    return 'Street cannot be null';
  } else if (!regex.hasMatch(value)) {
    return 'Invalid street';
  } else {
    return null;
  }
}
