import 'package:onezero/models/resale.dart';
import 'package:onezero/components/remote_service.dart';
import 'dart:developer';
import 'package:flutter/material.dart';

class ComparePage extends StatefulWidget {
  const ComparePage({Key? key}) : super(key: key);

  @override
  _ComparePageState createState() => _ComparePageState();
}

class _ComparePageState extends State<ComparePage> {
  Resale? resale;
  List records = [];
  List filterRecords = [];
  var neighbourhood = "YISHUN";
  var numberOfRooms = "4 ROOM";
  var isLoaded = false;
  var average;
  var avg;

  @override
  void initState() {
    super.initState();

    //fetch data from API
    getData(); // resale contains the data
  }

  getData() async {
    resale = await RemoteService().getResale();
    records = resale!.result.records;

    //var test1 = records[1].town.toString().split('.').last;
    //var test2 = test1.replaceAll("_", " ");
    //var testtype = test2.runtimeType;
    //log('Data: $test1, $test2, $testtype'); PRINTS(BUKIT_MERAH, BUKIT MERAH, String) !!

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
    var test = average.runtimeType;
    log('Avg: $average, $test');

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
        title: const Text('Resale Data'),
      ),
      body: Visibility(
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
                        Text(
                          filterRecords[index].resalePrice ?? '',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
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
    );
  }
}
