import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:onezero/pages/new_individual_page.dart';
import 'package:onezero/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoritePropertiesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
// Get the current user's ID
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
// If the user is not signed in, show an error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text('You must be signed in to view your favorite properties.'),
      ));
      return Scaffold();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
          child: Text(
            'Favorite Properties',
            style: TextStyle(
              fontFamily: 'Urbanist',
              color: Color(TEXT_COLOR),
              fontSize: 18,
            ),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('favorites')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final favoriteProperties =
              snapshot.data!.docs.map((doc) => doc.data()).toList();
          if (favoriteProperties.isEmpty) {
            return Center(
              child: Text('You have no favorite properties.'),
            );
          }

          return ListView.builder(
            itemCount: favoriteProperties.length,
            itemBuilder: (context, index) {
              final favoriteProperty =
                  favoriteProperties[index] as Map<String, dynamic>;

              return Padding(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: FavoritePropertyListItem(
                    propertyId: favoriteProperty['id'],
                    property: favoriteProperty),
              );
            },
          );
        },
      ),
    );
  }
}

class FavoritePropertyListItem extends StatefulWidget {
  final String propertyId;
  final Map<String, dynamic> property;

  FavoritePropertyListItem({required this.propertyId, required this.property});

  @override
  _FavoritePropertyListItemState createState() =>
      _FavoritePropertyListItemState();
}

class _FavoritePropertyListItemState extends State<FavoritePropertyListItem> {
  bool isFavorite = true;

  void _showRemovedFromFavoritesSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Removed from favorites.'),
    ));
  }

  void _removeFromFavorites(BuildContext context) async {
// Get the current user's ID
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
// If the user is not signed in, show an error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'You must be signed in to remove properties from your favorites.'),
      ));
      return;
    }
// Remove the property from the user's favorites collection in Firestore
    final favoritesRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('favorites');
    await favoritesRef.doc(widget.propertyId).delete();

// Update the state to indicate that the property is no longer a favorite
    if (mounted) {
      // Check if the widget is still mounted before calling setState()
      setState(() {
        isFavorite = false;
      });
    }

// Show a success message
    _showRemovedFromFavoritesSnackbar(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 12.0),
      child: InkWell(
        onTap: () async {
          //PUSH INDIVIDUAL PAGE
          Navigator.of(context).push(MaterialPageRoute(
            builder: ((context) => IndividualPropertyPageWidget(
                  id: widget.property['id'],
                  propertyName: widget.property['propertyName'],
                  price: double.parse(widget.property['price']),
                  numOfBedroom: int.parse(widget.property['numOfBedroom']),
                  dimension: int.parse(widget.property['dimension']),
                  lease: int.parse(
                    widget.property['lease'],
                  ),
                  lat: widget.property['lat'],
                  long: widget.property['long'],
                  url: widget.property['upload_url'],
                )),
          ));
        },
        child: Container(
          width: 100.0,
          height: 160.0,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 5.0,
                color: Color(0x1F000000),
                offset: Offset(0.0, 2.0),
              )
            ],
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Align(
                  alignment: AlignmentDirectional(-0.3, 0),
                  child: Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      shape: BoxShape.rectangle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        widget.property['upload_url'],
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-1, 0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                  child: Container(
                    width: 200,
                    height: 150,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(-0.05, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(8, 10, 16, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  widget.property['propertyName'],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText2
                                      .override(
                                        fontFamily: 'Outfit',
                                        color: Color(ALTERNATE_COLOR),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(8, 0, 16, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.property['address'],
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText2
                                      .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF57636C),
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 10, 16, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 10, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Icon(
                                                    Icons.single_bed,
                                                    color:
                                                        Color(ALTERNATE_COLOR),
                                                    size: 24,
                                                  ),
                                                  Text(
                                                    widget.property[
                                                            'numOfBedroom']
                                                        .toString(),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 10, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Icon(
                                                  Icons.bathtub_outlined,
                                                  color: Color(ALTERNATE_COLOR),
                                                  size: 24,
                                                ),
                                                Text(
                                                  '2',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 10, 0, 0),
                                      child: Flexible(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment:
                                                  AlignmentDirectional(0, 0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 3, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Icon(
                                                      Icons.attach_money,
                                                      color: Color(
                                                          ALTERNATE_COLOR),
                                                      size: 24,
                                                    ),
                                                    Text(
                                                      widget.property['price'],
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.black,
                                                            fontSize: 12,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 10, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                60, 0, 0, 0),
                                                    child: IconButton(
                                                      icon: Icon(
                                                        isFavorite
                                                            ? Icons.favorite
                                                            : Icons
                                                                .favorite_border,
                                                        color: isFavorite
                                                            ? Colors.red
                                                            : null,
                                                      ),
                                                      onPressed: () {
                                                        if (isFavorite) {
                                                          _removeFromFavorites(
                                                              context);
                                                        }
                                                      },
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
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
