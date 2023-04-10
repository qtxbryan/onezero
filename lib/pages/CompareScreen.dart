import 'package:onezero/models/resale.dart';
import 'package:onezero/components/remote_service.dart';
import 'dart:developer';
import 'package:flutter/material.dart';

class ComparePage extends StatefulWidget {
  ComparePage({key, required this.listingData}) : super(key: key);
  final Map<String, dynamic> listingData;

  @override
  _ComparePageState createState() => _ComparePageState();
}

class _ComparePageState extends State<ComparePage> {
  Resale? resale;
  List records = [];
  List filterRecords = [];
  //var neighbourhood = "YISHUN"; FOR TESTING
  //var numberOfRooms = "4 ROOM"; FOR TESTING
  var isLoaded = false;
  var average = '';
  var avg;
  var nh = '';
  var nor = '';

  @override
  void initState() {
    super.initState();

    //access passed data here
    final listingData = widget.listingData;
    var neighbourhood = listingData['neighbourhood'].toString().toUpperCase();
    var numberOfRooms = listingData['numOfBedroom'].toString() + " ROOM";
    //var price = listingData['price'].toString();
    //fetch data from API
    getResaleData(neighbourhood, numberOfRooms); // resale contains the data
  }

  getResaleData(neighbourhood, numberOfRooms) async {
    resale = await RemoteService().getResale();
    records = resale!.result.records;
    nh = neighbourhood;
    nor = numberOfRooms;
    //var test1 = records[1].town.toString().split('.').last;
    //var test2 = test1.replaceAll("_", " ");
    //var testtype = test2.runtimeType;
    //log('Data: $test1, $test2, $testtype'); PRINTS(BUKIT_MERAH, BUKIT MERAH, String) !!
    //log('Testing parameter passing: $neighbourhood, $numberOfRooms');
    filterRecords = records
        .where((record) =>
            (record.town.toString().split('.').last.replaceAll("_", " ") ==
                neighbourhood) &&
            (record.flatType
                    .toString()
                    .split('.')
                    .last
                    .replaceAll("THE_", "")
                    .replaceAll("_", " ") ==
                numberOfRooms))
        .toList();
    //log('Data: $filterRecords');

    // Average Calculation
    if (filterRecords.isNotEmpty) {
      avg = (filterRecords
                  .map((record) => int.parse(record.resalePrice))
                  .reduce((a, b) => a + b) /
              filterRecords.length)
          .toDouble()
          .ceil();
    }
    average = avg.toString();
    //var test = average.runtimeType;
    //log('Avg: $average, $test');

    if (resale != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compare Price'),
        backgroundColor: Color.fromRGBO(65, 67, 106, 1.0),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                    child: Container(
                      width: 100,
                      height: 70.2,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(65, 67, 106, 1.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(10, 20, 10, 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .center, //Center Row contents horizontally,
                            crossAxisAlignment: CrossAxisAlignment
                                .center, //Center Row contents vertically,
                            children: [
                              Text(
                                nh.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                    child: Container(
                      width: 100,
                      height: 70.4,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(65, 67, 106, 1.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(10, 20, 10, 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .center, //Center Row contents horizontally,
                            crossAxisAlignment: CrossAxisAlignment
                                .center, //Center Row contents vertically,
                            children: [
                              Text(
                                nor.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                    child: Container(
                      width: 100,
                      height: 70.4,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(65, 67, 106, 1.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(10, 20, 10, 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .center, //Center Row contents horizontally,
                            crossAxisAlignment: CrossAxisAlignment
                                .center, //Center Row contents vertically,
                            children: [
                              Text(
                                '\$',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                average.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                    child: Container(
                      width: 100,
                      height: 70.4,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(246, 70, 104, 1.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(10, 20, 10, 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .center, //Center Row contents horizontally,
                            crossAxisAlignment: CrossAxisAlignment
                                .center, //Center Row contents vertically,
                            children: [
                              Text(
                                '\$',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                average.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Visibility(
              visible: isLoaded,
              child: ListView.builder(
                itemCount: filterRecords.length, //resale!.result.records.length
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey[300],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                filterRecords[index]
                                        .town
                                        .toString()
                                        .split('.')
                                        .last
                                        .replaceAll("_", " ") ??
                                    '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                filterRecords[index]
                                        .flatType
                                        .toString()
                                        .split('.')
                                        .last
                                        .replaceAll("THE_", "")
                                        .replaceAll("_", " ") ??
                                    '',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "\$ ",
                                  ),
                                  Text(
                                    filterRecords[index].resalePrice ?? '',
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
