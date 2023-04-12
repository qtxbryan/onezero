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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
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
                      width: 415.6,
                      height: 283.2,
                      fit: BoxFit.cover,
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: Text(
                        'Welcome!',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 32,
                          fontFamily: 'Outfit',
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
                              'FlatFinderSG is the ultimate e-commerce solution for buying and selling flats in Singapore. Finding your dream home has never been easier!',
                              textAlign: TextAlign.left,
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
                                  color: Color.fromRGBO(65, 67, 106, 1.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40)),
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
                                    child: Text('Get started!',
                                        style: TextStyle(
                                          fontFamily: 'Outfit',
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          fontSize: 19,
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
