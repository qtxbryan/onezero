import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThousandFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newValueText = newValue.text;
    if (newValueText.isEmpty) {
      return newValue;
    }

    // Remove all non-numeric characters
    newValueText = newValueText.replaceAll(RegExp(r'[^0-9]'), '');

    // Add commas after every 3 zeros
    String formattedValue = '';
    int count = 0;
    for (int i = newValueText.length - 1; i >= 0; i--) {
      count++;
      formattedValue = '${newValueText[i]}$formattedValue';
      if (count == 3 && i > 0) {
        formattedValue = ',$formattedValue';
        count = 0;
      }
    }

    return newValue.copyWith(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }
}
