import 'package:onezero/models/resale.dart';
import 'package:onezero/controller/remote_service.dart';
import 'package:flutter/material.dart';

class ComparePage extends StatefulWidget {
  ComparePage({key, required this.listingData, required this.priceData})
      : super(key: key);
  final Map<String, dynamic> listingData;
  final double priceData;

  @override
  _ComparePageState createState() => _ComparePageState();
}

class _ComparePageState extends State<ComparePage> {
  Resale? resale;
  List records = [];
  List filterRecords = [];
  var isLoaded = false;
  var average = '';
  var avg;
  var nh = '';
  var nor = '';
  var indivPrice = '';

  @override
  void initState() {
    super.initState();

    //access passed data here
    final listingData = widget.listingData;
    final price = widget.priceData;
    var neighbourhood = listingData['neighbourhood'].toString().toUpperCase();
    var numberOfRooms = listingData['numOfBedroom'].toString() + " ROOM";
    var tprice = price.toInt().toString();

    //fetch data from API
    getResaleData(
        neighbourhood, numberOfRooms, tprice); // resale contains the data
  }

  getResaleData(neighbourhood, numberOfRooms, tprice) async {
    resale = await RemoteService().getResale();
    records = resale!.result.records;
    nh = neighbourhood;
    nor = numberOfRooms;
    indivPrice = '\$' + tprice;
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

    // Average Calculation
    if (filterRecords.isNotEmpty) {
      avg = (filterRecords
                  .map((record) => int.parse(record.resalePrice))
                  .reduce((a, b) => a + b) /
              filterRecords.length)
          .toDouble()
          .ceil();
    }
    average = '\$' + avg.toString();

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
                      height: 90,
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
                                softWrap: false,
                                maxLines: 2,
                                overflow: TextOverflow.fade,
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
                      height: 90,
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
                      height: 90,
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
                                indivPrice.toString(),
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
                      height: 90,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(246, 70, 104, 1.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(10, 20, 10, 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment
                                .center, //Center Column contents vertically,
                            crossAxisAlignment: CrossAxisAlignment
                                .center, //Center Column contents horizontally,
                            children: [
                              Text(
                                'Average:',
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
                        Icon(
                          Icons.house,
                          size: 50,
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
