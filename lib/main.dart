import 'package:flutter/material.dart';
import 'package:onezero/models/create_property0_model.dart';
import 'package:onezero/pages/create_property0_widget.dart';
import 'package:onezero/pages/create_property1_test_widget.dart';
import 'package:onezero/pages/create_property2_widget.dart';
import 'package:onezero/pages/myProperties.dart';
import 'package:onezero/pages/my_likes.dart';
import 'package:onezero/pages/edit_profile_page.dart';
import 'package:onezero/pages/home_page.dart';
import 'package:onezero/pages/landing_page.dart';
import 'package:onezero/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:onezero/pages/new_user_page.dart';
import 'package:onezero/pages/profile_page.dart';
import 'package:onezero/pages/search_page.dart';
import 'package:onezero/pages/test_api_page.dart';
import 'package:onezero/pages/test_grant.dart';
import 'package:onezero/pages/test_read_listing.dart';
import 'package:onezero/pages/test_register.dart';
import 'package:onezero/pages/test_individual_page.dart';
import 'package:onezero/pages/splash_page.dart';
import 'package:onezero/components/GrantCard.dart';
import 'package:onezero/pages/create_listing.dart';
import 'package:onezero/pages/settings_page.dart';
import 'package:onezero/pages/reset_password_page.dart';
import 'package:onezero/pages/edit_property.dart';

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
      home: SettingPage(),
    );
  }
}
