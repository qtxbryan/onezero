import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CreateProperty1TestModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // State field(s) for propertyAddress widget.
  TextEditingController? propertyAddressController;
  String? Function(BuildContext, String?)? propertyAddressControllerValidator;
  // State field(s) for propertyNeighborhood widget.
  TextEditingController? propertyNeighborhoodController;
  String? Function(BuildContext, String?)?
      propertyNeighborhoodControllerValidator;
  // State field(s) for propertyDescription widget.
  TextEditingController? propertyDescriptionController;
  String? Function(BuildContext, String?)?
      propertyDescriptionControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    propertyAddressController?.dispose();
    propertyNeighborhoodController?.dispose();
    propertyDescriptionController?.dispose();
  }

  /// Additional helper methods are added here.

}
