import 'package:onezero/pages/landing_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '/backend/database.dart';
import '/flutter_flow/flutter_flow_autocomplete_options_list.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:onezero/constants.dart';
import 'package:onezero/pages/individual_property_page.dart';
import 'package:easy_debounce/easy_debounce.dart';
import '/models/search_page_model.dart';
export '/models/search_page_model.dart';

class SearchPageWidget extends StatefulWidget {
  const SearchPageWidget({Key? key}) : super(key: key);

  @override
  _SearchPageWidgetState createState() => _SearchPageWidgetState();
}

class _SearchPageWidgetState extends State<SearchPageWidget> {
  late SearchPageModel _model;

  Database db = Database();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchPageModel());

    _model.fieldSearchController ??= TextEditingController();
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: Color(0xFF41436A),
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30.0,
          buttonSize: 46.0,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 24.0,
          ),
          onPressed: () async {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (((context) =>
                        LandingPage())))); //Use navigator for navigation
          },
        ),
        title: Text(
          'Search',
          style: FlutterFlowTheme.of(context).subtitle1.override(
                fontFamily: 'Lexend Deca',
                color: FlutterFlowTheme.of(context).tertiaryColor,
                fontSize: 22.0,
                fontWeight: FontWeight.w500,
              ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3.0,
                        color: Color(0x39000000),
                        offset: Offset(0.0, 1.0),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 4.0, 0.0),
                    child: Container(
                      width: double.infinity,
                      height: 60.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  4.0, 0.0, 4.0, 0.0),
                              child: Autocomplete<String>(
                                initialValue: TextEditingValue(),
                                optionsBuilder: (textEditingValue) {
                                  if (textEditingValue.text == '') {
                                    return const Iterable<String>.empty();
                                  }
                                  return [
                                    'Blk 123A Rivervale Drive',
                                    'Blk 121 Hougang Ave 1'
                                  ].where((option) {
                                    final lowercaseOption =
                                        option.toLowerCase();
                                    return lowercaseOption.contains(
                                        textEditingValue.text.toLowerCase());
                                  });
                                },
                                optionsViewBuilder:
                                    (context, onSelected, options) {
                                  return AutocompleteOptionsList(
                                    textFieldKey: _model.fieldSearchKey,
                                    textController:
                                        _model.fieldSearchController!,
                                    options: options.toList(),
                                    onSelected: onSelected,
                                    textStyle:
                                        FlutterFlowTheme.of(context).bodyText1,
                                    textHighlightStyle: TextStyle(),
                                    elevation: 4.0,
                                    optionBackgroundColor:
                                        FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                    optionHighlightColor:
                                        FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                    maxHeight: 200.0,
                                  );
                                },
                                onSelected: (String selection) {
                                  setState(() => _model
                                      .fieldSearchSelectedOption = selection);
                                  FocusScope.of(context).unfocus();
                                },
                                fieldViewBuilder: (
                                  context,
                                  textEditingController,
                                  focusNode,
                                  onEditingComplete,
                                ) {
                                  _model.fieldSearchController =
                                      textEditingController;
                                  return TextFormField(
                                    key: _model.fieldSearchKey,
                                    controller: textEditingController,
                                    focusNode: focusNode,
                                    onEditingComplete: onEditingComplete,
                                    onChanged: (_) => EasyDebounce.debounce(
                                      '_model.fieldSearchController',
                                      Duration(milliseconds: 100),
                                      () => setState(() {}),
                                    ),
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: 'Search address here...',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      prefixIcon: Icon(
                                        Icons.search_sharp,
                                        color: FlutterFlowTheme.of(context)
                                            .grayIcon,
                                      ),
                                      suffixIcon: _model.fieldSearchController!
                                              .text.isNotEmpty
                                          ? InkWell(
                                              onTap: () async {
                                                _model.fieldSearchController
                                                    ?.clear();
                                                setState(() {});
                                              },
                                              child: Icon(
                                                Icons.clear,
                                                color: Color(0xFF757575),
                                                size: 22.0,
                                              ),
                                            )
                                          : null,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Urbanist',
                                          color: FlutterFlowTheme.of(context)
                                              .tertiaryColor,
                                        ),
                                    validator: _model
                                        .fieldSearchControllerValidator
                                        .asValidator(context),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                  child: FlutterFlowChoiceChips(
                    options: [
                      ChipData('2-room'),
                      ChipData('3-room'),
                      ChipData('4-room'),
                      ChipData('5-room')
                    ],
                    onChanged: (val) =>
                        setState(() => _model.choiceChipsValues = val),
                    selectedChipStyle: ChipStyle(
                      backgroundColor: Color(0xFF41436A),
                      textStyle:
                          FlutterFlowTheme.of(context).bodyText1.override(
                                fontFamily: 'Urbanist',
                                color: Colors.white,
                              ),
                      iconColor: FlutterFlowTheme.of(context).background,
                      iconSize: 18.0,
                      elevation: 4.0,
                    ),
                    unselectedChipStyle: ChipStyle(
                      backgroundColor: Color(0xFFBFB9B9),
                      textStyle:
                          FlutterFlowTheme.of(context).bodyText2.override(
                                fontFamily: 'Urbanist',
                                color: FlutterFlowTheme.of(context).background,
                              ),
                      iconColor: FlutterFlowTheme.of(context).background,
                      iconSize: 18.0,
                      elevation: 4.0,
                    ),
                    chipSpacing: 20.0,
                    multiselect: true,
                    initialized: _model.choiceChipsValues != null,
                    alignment: WrapAlignment.start,
                    controller: _model.choiceChipsController ??=
                        FormFieldController<List<String>>(
                      [],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
