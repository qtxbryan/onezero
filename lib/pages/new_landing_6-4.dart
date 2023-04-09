import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:onezero/constants.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:onezero/backend/database.dart';
import 'package:onezero/auth.dart';
import 'package:onezero/models/LocationModel.dart';
import 'package:geocoding/geocoding.dart';
import 'favorite_page.dart';
import 'package:onezero/components/property_card.dart';
import 'package:onezero/components/filter_button.dart';
import 'settings_page.dart';
import 'new_add_property_page.dart';
import 'my_properties_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  final Auth _auth = Auth();

  @override
  bool get wantKeepAlive => true;

  String _searchText = '';
  int _selectedFilterIndex = -1;
  late TextEditingController _searchController;

  Database db = Database();

  String country = '';
  String name = '';
  String street = '';
  String postalCode = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> getLocation() async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(UserLocation.lat, UserLocation.long);

    print(placemark[0].country);
    print(placemark[0].name);
    print(placemark[0].street);
    print(placemark[0].postalCode);

    setState(() {
      country = placemark[0].country!;
      name = placemark[0].name!;
      street = placemark[0].street!;
      postalCode = placemark[0].postalCode!;
    });
  }

  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    User? user = _auth.currentUser;
    if (name == null) {
      return Container(
        color: FlutterFlowTheme.of(context).primaryBackground,
        child: Center(
          child: SizedBox(
            width: 50.0,
            height: 50.0,
            child: CircularProgressIndicator(
              color: FlutterFlowTheme.of(context).primaryColor,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF0F0F0),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedTabIndex,
        onTap: (index) => setState(() => _selectedTabIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color(PRIMARY_COLOR),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourite',
            backgroundColor: Color(PRIMARY_COLOR),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
            backgroundColor: Color(PRIMARY_COLOR),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
            backgroundColor: Color(PRIMARY_COLOR),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: Color(PRIMARY_COLOR),
          ),
        ],
      ),
      body: _buildBody(user),
    );
  }

  Widget _buildBody(User? user) {
    switch (_selectedTabIndex) {
      case 0:
        return _buildHome(user);
      case 1:
        return FavoritePropertiesPage();
      case 2:
        return AddPropertyPageWidget();

      case 3:
        return MyPropertiesWidget();
      case 4:
        return SettingPage();
      default:
        return Container();
    }
  }

  Widget _buildHome(User? user) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                height: 250.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color(0xFFF3F3F3), width: 1.0),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0, 0.0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 20, 0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Welcome',
                                    style: FlutterFlowTheme.of(context)
                                        .title1
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: Colors.grey,
                                          fontSize: 14.0,
                                        ),
                                  ),
                                  Text(
                                    user!.email!,
                                    style: FlutterFlowTheme.of(context)
                                        .title1
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: FlutterFlowTheme.of(context)
                                              .backgroundComponents,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 16.0, 16.0, 0.0),
                        child: Container(
                          width: double.infinity,
                          height: 45.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFE5E5E5),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 0.0, 10.0, 0.0),
                              child: TextFormField(
                                controller: _searchController,
                                onChanged: (value) {
                                  setState(() {
                                    _searchText = value;
                                  });
                                },
                                obscureText: false,
                                decoration: InputDecoration(
                                    hintText: 'Search',
                                    hintStyle:
                                        FlutterFlowTheme.of(context).bodyText2,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1.0,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1.0,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1.0,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedErrorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1.0,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.search,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.clear),
                                      onPressed: () {
                                        _searchController.clear();
                                        setState(() {
                                          _searchText = '';
                                        });
                                      },
                                    )),
                                style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            10.0, 20.0, 10.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FilterButton(
                              title: '2 Rooms',
                              isActive: _selectedFilterIndex == 0,
                              onPressed: () {
                                setState(() {
                                  if (_selectedFilterIndex == 0) {
                                    _selectedFilterIndex = -1;
                                  } else {
                                    _selectedFilterIndex = 0;
                                  }
                                });
                              },
                            ),
                            FilterButton(
                              title: '3 Rooms',
                              isActive: _selectedFilterIndex == 1,
                              onPressed: () {
                                setState(() {
                                  if (_selectedFilterIndex == 1) {
                                    _selectedFilterIndex = -1;
                                  } else {
                                    _selectedFilterIndex = 1;
                                  }
                                });
                              },
                            ),
                            FilterButton(
                              title: '4 Rooms',
                              isActive: _selectedFilterIndex == 2,
                              onPressed: () {
                                setState(() {
                                  if (_selectedFilterIndex == 2) {
                                    _selectedFilterIndex = -1;
                                  } else {
                                    _selectedFilterIndex = 2;
                                  }
                                });
                              },
                            ),
                            FilterButton(
                              title: '5 Rooms',
                              isActive: _selectedFilterIndex == 3,
                              onPressed: () {
                                setState(() {
                                  if (_selectedFilterIndex == 3) {
                                    _selectedFilterIndex = -1;
                                  } else {
                                    _selectedFilterIndex = 3;
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(30.0, 10.0, 0.0, 10.0),
                    child: Text(
                      'Nearby',
                      textAlign: TextAlign.start,
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 50),
                    child: SafeArea(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('listing')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          final properties = snapshot.data!.docs;
                          final filteredProperties =
                              properties.where((property) {
                            // Filter by search text
                            final propertyName = property['propertyName']
                                .toString()
                                .toLowerCase();
                            final searchText = _searchText.toLowerCase();
                            if (searchText.isNotEmpty &&
                                !propertyName.contains(searchText)) {
                              return false;
                            }
                            // Filter by number of rooms
                            final numRooms = property['numOfBedroom'];
                            if (_selectedFilterIndex == 0 && numRooms != "2") {
                              return false;
                            }
                            if (_selectedFilterIndex == 1 && numRooms != "3") {
                              return false;
                            }
                            if (_selectedFilterIndex == 2 && numRooms != "4") {
                              return false;
                            }
                            if (_selectedFilterIndex == 3 && numRooms != "5") {
                              return false;
                            }

                            return true;
                          }).toList();

                          if (filteredProperties.isEmpty) {
                            return Center(
                              child: Text('Property not found.'),
                            );
                          }

                          return Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: filteredProperties.length,
                              itemBuilder: (context, index) {
                                final property = filteredProperties[index]
                                    .data() as Map<String, dynamic>;
                                return PropertyListItem(property: property);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
