import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onezero/models/LocationModel.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:onezero/pages/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    locationService();
  }

  Future<void> locationService() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionLocation;
    LocationData _locData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionLocation = await location.hasPermission();
    if (_permissionLocation == PermissionStatus.denied) {
      _permissionLocation = await location.requestPermission();
      if (_permissionLocation != PermissionStatus.granted) {
        return;
      }
    }

    _locData = await location.getLocation();

    print(_locData.latitude);
    print(_locData.longitude);

    setState(() {
      UserLocation.lat = _locData.latitude!;
      UserLocation.long = _locData.longitude!;
    });

    Timer(Duration(milliseconds: 500), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        color: Color(0xffF7F1F1),
        child: Center(
          child: Stack(
            children: [
              Positioned(
                bottom: 350,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/icon.png',
                      width: 130,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: Text(
                        'OneZero',
                        style: TextStyle(
                          fontSize: 32,
                          fontFamily: 'Helvetica Neue',
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                  bottom: 40,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: GestureDetector(
                      onTap: null,
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              'OneZero is reimagining real estate to make it easier to unlock life next chapter.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Helvetica Neue-Regular',
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                            child: Container(
                                height: 50,
                                decoration: const BoxDecoration(
                                  color: Color(0xD9B43C42),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (((context) =>
                                                LoginPage()))));
                                  },
                                  child: const Center(
                                    child: Text('Create Account',
                                        style: TextStyle(
                                          fontFamily: 'Helvetica-Neue-Regular',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                          fontSize: 18,
                                        )),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
