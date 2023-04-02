import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onezero/auth.dart';
import 'package:onezero/models/Listing.dart';
import 'package:onezero/constants.dart';
import 'package:onezero/backend/database.dart';
import 'package:onezero/pages/create_property1_test_widget.dart';
import 'package:onezero/pages/edit_property.dart';
import 'package:onezero/pages/home_page.dart';
import 'package:onezero/pages/individual_property_page.dart';
import 'package:onezero/pages/search_page.dart';
import 'package:onezero/pages/settings_page.dart';
import 'package:flutter/services.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:onezero/pages/landing_page.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';

class myProperties extends StatefulWidget {
  
  myProperties({super.key});

  @override
  State<myProperties> createState() => _myPropertiesState();
}

class _myPropertiesState extends State<myProperties> {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
int _selected = 0;
  Database db = Database();

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }
void OnBeingTapped(int index) {
    setState(() {
      _selected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xFF41436A),
    statusBarColor: Color(0xFF41436A),
  ));
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
                  height: 60,
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
                  child: Row(
                   
                    children: [
                     FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30.0,
          borderWidth: 1.0,
          buttonSize: 60.0,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 30.0,
          ),
         onPressed: () async {
                    Navigator.pop(context);
                  },
                     ), 
                      
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 12, 6, 8),
                        child: Text(
                              'My Properties ',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            ),
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
                                        ClipRRect(
                           borderRadius: BorderRadius.circular(10),
                           child: Image.asset(
                             'assets/images/239183274_1205782896609021_3013960168526323226_n.jpeg',
                             width: double.infinity,
                             fit: BoxFit.cover,
                           ),
                         ),
                         Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16, 12, 16, 8),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Expanded(
                                                child: Text(listingsData[
                                                    'propertyName'],
                                                    style: TextStyle(
                                                    fontFamily: 'Helvetica-Neue-Regular',
                                                    color: Colors.black,
                                                    fontSize: 20,),
                                                ),    
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
                                                child: Text('S\$' +
                                                  listingsData['price']
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontFamily: 'Helvetica-Neue-Regular',
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
                                                fontFamily: 'Helvetica-Neue-Regular',
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
                                                    16, 0, 8, 12),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Spacer(),
                                                Padding( 
                                                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                                                 child: OutlinedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                EditPropertyWidget())));
                                  },
                                  child: Text(
                                    'Edit',
                                    style: TextStyle(
                                      fontFamily: 'Helvetica-Neue',
                                      color: Colors.white,
                                    ),
                                  ),
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(2),
                                    fixedSize: MaterialStateProperty.all(
                                        Size(50, 40)),
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.all(0)),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.green),
                                    side: MaterialStateProperty.all(
                                      BorderSide(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                                ),
                                                ),
                                OutlinedButton(
                                  onPressed: () async {
                                    var confirmDialogResponse = await showDialog<bool>(
                        context: context,
                        builder: (alertDialogContext) {
                          return AlertDialog(
                            title: Text('Remove Listing'),
                            content: Text('Are you sure you want to remove a property?'),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(alertDialogContext, false),
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(alertDialogContext, true),
                                child: Text('Confirm'),
                              ),
                            ],
                          );
                        },
                      );
                                  },
                                  child: Text(
                                    'Remove',
                                    style: TextStyle(
                                      fontFamily: 'Helvetica-Neue',
                                      color: Colors.white,
                                    ),
                                  ),
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(2),
                                    fixedSize: MaterialStateProperty.all(
                                        Size(50, 40)),
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.all(0)),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.red),
                                    side: MaterialStateProperty.all(
                                      BorderSide(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
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
                                color: Colors.pink,
                              ),
                            ),
                          );
                        }
                      },
                    )),
              ],
            )),
          ),
        ),
       
        
      )
        ;
        
       
  }
  
}


