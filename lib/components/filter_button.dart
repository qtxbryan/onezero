import 'package:flutter/material.dart';
import 'package:onezero/constants.dart';

class FilterButton extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onPressed;

  FilterButton(
      {required this.title, required this.isActive, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: isActive ? Color(ALTERNATE_COLOR) : Color(PRIMARY_COLOR),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(title),
    );
  }
}
