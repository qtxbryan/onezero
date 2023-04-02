import '/backend/database.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CreateProperty2Model extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  // State field(s) for pricePerNight widget.
  TextEditingController? pricePerNightController;
  String? Function(BuildContext, String?)? pricePerNightControllerValidator;
  // State field(s) for taxRate widget.
  TextEditingController? taxRateController1;
  String? Function(BuildContext, String?)? taxRateController1Validator;
  // State field(s) for taxRate widget.
  TextEditingController? taxRateController2;
  String? Function(BuildContext, String?)? taxRateController2Validator;
  // State field(s) for taxRate widget.
  TextEditingController? taxRateController3;
  String? Function(BuildContext, String?)? taxRateController3Validator;
  // State field(s) for taxRate widget.
  TextEditingController? taxRateController4;
  String? Function(BuildContext, String?)? taxRateController4Validator;
  // State field(s) for propertyAddress widget.
  TextEditingController? propertyAddressController;
  String? Function(BuildContext, String?)? propertyAddressControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  //ListingRecord? newProperty;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    pricePerNightController?.dispose();
    taxRateController1?.dispose();
    taxRateController2?.dispose();
    taxRateController3?.dispose();
    taxRateController4?.dispose();
    propertyAddressController?.dispose();
  }

  /// Additional helper methods are added here.

}
