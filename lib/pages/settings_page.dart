import 'package:onezero/pages/landing_page.dart';
import 'package:onezero/pages/create_property1_test_widget.dart';
import 'package:onezero/pages/myProperties.dart';
import 'package:onezero/pages/reset_password_page.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onezero/pages/edit_profile_page.dart';
import 'package:onezero/pages/my_likes.dart';
import 'package:flutter/services.dart';
import 'package:onezero/auth.dart';
Future<void> signOut() async {
    await Auth().signOut();
  }

 Widget _signOutButton() {
    return ElevatedButton(
      
      onPressed: signOut,
      
      child: const Text('Sign Out'),
      style: ElevatedButton.styleFrom(
    primary: Color(0xFFF64668),) 
    );
  }
class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  int _selected = 3;
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
      backgroundColor: Color(0xFFF1F4F8),
      appBar: AppBar(
        backgroundColor: Color(0xFF41436A),
        automaticallyImplyLeading: false,
        title: Text(
          'Profile',
          style: FlutterFlowTheme.of(context).subtitle2.override(
                fontFamily: 'Outfit',
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.w500,
              ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFF41436A),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 0.0,
                        color: Color(0xFF41436A),
                        offset: Offset(0.0, 1.0),
                      )
                    ],
                  ),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: Color(0xFF36B4FF),
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                2.0, 2.0, 2.0, 0.0),
                            // child: AuthUserStreamWidget(
                            //   builder: (context) => ClipRRect(
                            //     borderRadius: BorderRadius.circular(40.0),
                            //     child: CachedNetworkImage(
                            //       imageUrl: currentUserPhoto,
                            //       width: 60.0,
                            //       height: 60.0,
                            //       fit: BoxFit.cover,
                            //     ),
                            //   ),
                            // ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 0.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            
                            children: [
                              // AuthUserStreamWidget(
                              //   builder: (context) => Text(
                              //     currentUserDisplayName,
                              //     style: FlutterFlowTheme.of(context)
                              //         .title3
                              //         .override(
                              //           fontFamily: 'Plus Jakarta Sans',
                              //           color: Color(0xFF14181B),
                              //           fontSize: 20.0,
                              //           fontWeight: FontWeight.w500,
                              //         ),
                              //   ),
                              // ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 4.0, 0.0, 0.0),
                                child: Text(
                                  // currentUserEmail,
                                  'UserName',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText2
                                      .override(
                                        fontFamily: 'Outfit',
                                        color: Colors.white,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 0.0, 0.0),
                child: Text(
                  'Account',
                  style: FlutterFlowTheme.of(context).subtitle2.override(
                        fontFamily: 'Outfit',
                        color: Color(0xFF14181B),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    ChangePasswordWidget())));
                  },
                child: Container(
                  width: double.infinity,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5.0,
                        color: Color(0x3416202A),
                        offset: Offset(0.0, 2.0),
                      )
                    ],
                    borderRadius: BorderRadius.circular(12.0),
                    shape: BoxShape.rectangle,
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                    child: Row(
                      
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        
                        Icon(
                          Icons.edit_sharp,
                          color: Color(0xFF57636C),
                          size: 24.0,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              12.0, 0.0, 0.0, 0.0),
                              
                          child: Text(
                            'Change Password',
                            style:
                                FlutterFlowTheme.of(context).bodyText2.override(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF57636C),
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: AlignmentDirectional(0.9, 0.0),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xFF57636C),
                              size: 18.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                 child: InkWell(
                  onTap: (){
                    Navigator.push(context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    myProperties())));
                  },
                child: Container(
                  
                  width: double.infinity,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5.0,
                        color: Color(0x3416202A),
                        offset: Offset(0.0, 2.0),
                      )
                    ],
                    borderRadius: BorderRadius.circular(12.0),
                    shape: BoxShape.rectangle,
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.language_outlined,
                          color: Color(0xFF57636C),
                          size: 24.0,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              12.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'My Properties',
                            style:
                                FlutterFlowTheme.of(context).bodyText2.override(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF57636C),
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: AlignmentDirectional(0.9, 0.0),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xFF57636C),
                              size: 18.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                 child: InkWell(
                  onTap: (){
                    Navigator.push(context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    EditProfileWidget())));
                  },
                child: Container(
                  width: double.infinity,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5.0,
                        color: Color(0x3416202A),
                        offset: Offset(0.0, 2.0),
                      )
                    ],
                    borderRadius: BorderRadius.circular(12.0),
                    shape: BoxShape.rectangle,
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfileWidget()));
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(
                            Icons.account_circle_outlined,
                            color: Color(0xFF57636C),
                            size: 24.0,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 0.0, 0.0),
                            child: Text(
                              'Edit Profile',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText2
                                  .override(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF57636C),
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional(0.9, 0.0),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Color(0xFF57636C),
                                size: 18.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                 ),
              ),
             
              SizedBox(height:40),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                child: Container(
                  width: double.infinity,
                  height: 60.0,
                  
                  
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                         _signOutButton(),
                        
                      ]
                    ),
                  ),
                ),
                  ),
            ],
          ),
        ),
      ),
     bottomNavigationBar: BottomNavigationBar(
           type: BottomNavigationBarType.fixed, // Fixed 
  backgroundColor: Color(0xFF41436A),
  
          
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'
            ,
            backgroundColor: Colors.white,
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Likes',
            
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Add Listing',
           
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile',
           
          ),
         
        ],
        
        currentIndex: _selected,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
        onTap: (int index) {
          switch (index) {
            case 0:
            Navigator.push(context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    LandingPage())));
                break;
                case 1: 
                Navigator.push(context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    myLikes())));
                break;
                case 2: 
                Navigator.push(context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    CreateProperty1TestWidget())));
                break;
                case 3: 
                Navigator.push(context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    SettingPage())));
                break;
                }
        }         
              // only scroll to top when current index is selected.
             
              
      ),
      );
    
  }
}

