import 'package:flutter/material.dart';

class GrantCard extends StatelessWidget {
  final String grantDetails;
  final int grantAmount;

  const GrantCard({required this.grantDetails, required this.grantAmount});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Grant awarded details:',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14.0,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            grantDetails,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12.0),
          Text(
            'Grant Amount:',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14.0,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            '\$${grantAmount.toStringAsFixed(2)}',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
