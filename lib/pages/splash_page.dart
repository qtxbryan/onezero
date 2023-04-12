import 'package:flutter/material.dart';
import 'package:onezero/models/LocationModel.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:onezero/pages/new_login.dart';
import 'package:onezero/constants.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';

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
                bottom: 400,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/flatfinder.png',
                      width: 200,
                      fit: BoxFit.fitWidth,
                    ),
                  ],
                ),
              ),
              Positioned(
                  bottom: 40,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: GestureDetector(
                      onTap: null,
                      child: Column(
                        children: [
                          Center(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 40),
                              child: Text(
                                'FlatFinderSG is the ultimate e-commerce solution for buying and selling flats in Singapore. Finding your dream home has never been easier!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Helvetica Neue-Regular',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 300.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              color:
                                  FlutterFlowTheme.of(context).primaryBtnText,
                            ),
                            child: FFButtonWidget(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (((context) =>
                                            LoginPageWidget()))));
                              },
                              text: 'Get Started',
                              options: FFButtonOptions(
                                width: 300.0,
                                height: 40.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color:
                                    FlutterFlowTheme.of(context).primaryBtnText,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyText2
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: Color(PRIMARY_COLOR),
                                    ),
                                borderSide: BorderSide(
                                  color: Color(PRIMARY_COLOR),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
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
