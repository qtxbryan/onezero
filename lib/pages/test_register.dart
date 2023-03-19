import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onezero/pages/new_user_page.dart';
import '../auth.dart';

class TestRegisterPage extends StatefulWidget {
  const TestRegisterPage({super.key});

  @override
  State<TestRegisterPage> createState() => _TestRegisterPageState();
}

class _TestRegisterPageState extends State<TestRegisterPage> {
  String? errorMessage = '';

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );

      // Get the current user and create a new document with their data
      User? user = Auth().currentUser;
      await FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
        'email': user?.email,
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _entryField(String title, TextEditingController controller) {
    return TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: title, //
        ));
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Humm ? ${errorMessage}');
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: ((context) => NewUserPageWidget(
                email: _controllerEmail.text,
                password: _controllerPassword.text))));
      },
      child: Text('Register'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('test register page'),
        ),
        body: Container(
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _entryField('email', _controllerEmail),
                _entryField('password', _controllerPassword),
                _errorMessage(),
                _submitButton(),
              ],
            )));
  }
}
