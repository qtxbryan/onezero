import 'package:flutter/material.dart';
import 'package:onezero/widget_tree.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:onezero/pages/create_listing.dart';
import 'package:onezero/pages/landing_page.dart';
import 'package:onezero/pages/test_read_listing.dart';
import 'package:onezero/pages/profile_page.dart';
import 'package:onezero/pages/test_register.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TestRegisterPage(),
    );
  }
}
