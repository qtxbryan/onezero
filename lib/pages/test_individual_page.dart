import 'package:flutter/material.dart';
import 'package:onezero/components/post_app_bar.dart';
import 'package:onezero/components/post_bottom_bar.dart';

class IndividualPropertyPage extends StatefulWidget {
  const IndividualPropertyPage({super.key});

  @override
  State<IndividualPropertyPage> createState() => _IndividualPropertyPageState();
}

class _IndividualPropertyPageState extends State<IndividualPropertyPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/images/city6.jpg'),
        fit: BoxFit.cover,
        opacity: 0.7,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: PostAppBar(),
        ),
        bottomNavigationBar: PostBottomBar(),
      ),
    );
  }
}
