import 'package:onezero/controller/auth.dart';
import 'package:onezero/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:onezero/pages/main_page.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // return HomePage();
          return MainPage();
        } else {
          return LoginPageWidget();
        }
      },
    );
  }
}
