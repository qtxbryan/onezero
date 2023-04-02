import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';

class SearchPageModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.
  // State field(s) for fieldSearch widget.
  final fieldSearchKey = GlobalKey();
  TextEditingController? fieldSearchController;
  String? fieldSearchSelectedOption;
  String? Function(BuildContext, String?)? fieldSearchControllerValidator;
  // State field(s) for ChoiceChips widget.
  List<String>? choiceChipsValues;
  FormFieldController<List<String>>? choiceChipsController;

  /// Initialization and disposal methods.
  void initState(BuildContext context) {}

  void dispose() {}

  /// Additional helper methods are added here.
}
