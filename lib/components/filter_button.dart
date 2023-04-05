import 'package:flutter/material.dart';

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
        primary: isActive ? Colors.blue : Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(title),
    );
  }
}
