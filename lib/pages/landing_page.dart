import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onezero/auth.dart';
import 'package:onezero/models/Listing.dart';
import 'package:onezero/constants.dart';
import 'package:onezero/backend/database.dart';
import 'package:onezero/pages/individual_property_page.dart';
import 'package:onezero/pages/settings_page.dart';

class LandingPage extends StatefulWidget {
  LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Database db = Database();

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
            child: SingleChildScrollView(
                child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Color(0xFF41436A),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3,
                        color: Color(0x39000000),
                        offset: Offset(0, 2),
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Padding(
                      //   padding: EdgeInsetsDirectional.fromSTEB(100, 40, 0, 0),
                      //   child: ClipRRect(
                      //     borderRadius: BorderRadius.circular(10),
                      //     child: Image.asset(
                      //       'assets/images/290f65c315a14be1922fe186f2ad75b0.png',
                      //       width: 160,
                      //       height: 70,
                      //       fit: BoxFit.fitWidth,
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(24, 12, 24, 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Welcome, ',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0x4B39EF),
                                fontSize: 24,
                              ),
                            ),
                            //Authenticated user's display name
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                        child: Container(
                            width: double.infinity,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color(0x4B39EF),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            alignment: AlignmentDirectional(0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                OutlinedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                SettingPage())));
                                  },
                                  child: Text(
                                    'Search',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                    ),
                                  ),
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(2),
                                    fixedSize: MaterialStateProperty.all(
                                        Size(100, 40)),
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.all(0)),
                                    backgroundColor: MaterialStateProperty.all(
                                        Color(0xFFF64668)),
                                    side: MaterialStateProperty.all(
                                      BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                    ),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),

                //ADD IN THE LIST FOR PRINTED PROPERTIES
                Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 50),
                    child: StreamBuilder(
                      stream: db.listings.snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong! ${snapshot.data}');
                        } else if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              print("Item Builder Called");

                              final DocumentSnapshot listingsData =
                                  snapshot.data!.docs[index];

                              return Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 16, 12),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: ((context) =>
                                          IndividualPropertyPageWidget(
                                              id: listingsData['id'],
                                              propertyName:
                                                  listingsData['propertyName'],
                                              price: double.parse(
                                                  listingsData['price']),
                                              numOfBedroom: int.parse(
                                                  listingsData['numOfBedroom']),
                                              dimension: int.parse(
                                                  listingsData['dimension']),
                                              lease: int.parse(
                                                listingsData['lease'],
                                              ))),
                                    ));
                                  }, //push individual property page,
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(SECONDARY_COLOR),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 4,
                                          color: Color(0x32000000),
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        // ClipRRect(
                                        //   borderRadius: BorderRadius.only(
                                        //     bottomLeft: Radius.circular(0),
                                        //     bottomRight: Radius.circular(0),
                                        //     topLeft: Radius.circular(8),
                                        //     topRight: Radius.circular(8),
                                        //   ),
                                        //   child: Image.asset(
                                        //     'assets/images/239183274_1205782896609021_3013960168526323226_n.jpeg',
                                        //     width: double.infinity,
                                        //     height: 190,
                                        //     fit: BoxFit.cover,
                                        //   ),
                                        // ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16, 12, 16, 8),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Expanded(
                                                child: Text(listingsData[
                                                    'propertyName']),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16, 0, 16, 8),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  listingsData['price']
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(15, 0, 0, 0),
                                              child: Text(
                                                listingsData['numOfBedroom']
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(2, 0, 0, 0),
                                              child: Icon(
                                                Icons.king_bed_outlined,
                                                color: Colors.black,
                                                size: 20,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(7, 0, 0, 0),
                                              child: Text(
                                                '2',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(2, 0, 0, 5.5),
                                              child: Icon(
                                                Icons.bathtub_outlined,
                                                color: Colors.black,
                                                size: 20,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 0, 10, 5),
                                              child: Text(
                                                '|',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              listingsData['dimension']
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              'sqft',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: Colors.black,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 0, 10, 5),
                                              child: Text(
                                                '|',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              'S\$ 496.62 psf',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          height: 40,
                                          decoration: BoxDecoration(),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16, 0, 24, 12),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Icon(
                                                  Icons.favorite,
                                                  color: Color(0xFFE30E0E),
                                                  size: 24,
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(4, 0, 0, 0),
                                                  child: Text(
                                                    'Add to Likes',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(
                                color: Color(PRIMARY_COLOR),
                              ),
                            ),
                          );
                        }
                      },
                    )),
              ],
            )),
          ),
        ));
  }
}
