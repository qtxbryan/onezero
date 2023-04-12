import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmailScreen extends StatelessWidget {
  final String emailRecipient = 'weihao868@gmail.com';
  final String emailSubject = '[Enquiry]: Interest in block 258 Punggol Field';
  final String emailBody = 'TESTING EMAIL BODY';

  void _sendEmail() async {
    String url = 'mailto:$emailRecipient?subject=$emailSubject&body=$emailBody';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch email';
    }
  }

  Future sendEmail({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Email'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _sendEmail,
          child: Text('Send Email'),
        ),
      ),
    );
  }
}
