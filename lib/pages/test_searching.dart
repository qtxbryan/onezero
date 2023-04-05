import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:onezero/models/Listing_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // create a dummy list of listings
  static List<ListingModel> main_listing_list = [
    ListingModel(
        'Hougang', 'testDesc', 100, 80, 'Hougang', 3, 58880, 'Hougang Ave 1'),
    ListingModel('Sengkang', 'testDesc', 100, 80, 'Sengkang', 3, 58880,
        'Sengkang Ave 1'),
    ListingModel(
        'Punggol', 'testDesc', 100, 80, 'Punggol', 3, 58880, 'Punggol Ave 1'),
    ListingModel('Serangoon', 'testDesc', 100, 80, 'Hougang', 3, 58880,
        'Serangoon Ave 1'),
  ];

  //creating the list that we are going to display
  List<ListingModel> display_list = List.from(main_listing_list);

  void updateList(String value) {
    //this is the function that will filter our list

    setState(() {
      display_list = main_listing_list
          .where((element) =>
              element.propertyName!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.purple.shade900,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.purple.shade900,
        ),
        body: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Search for a house ",
                      style: TextStyle(color: Colors.white)),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    onChanged: (value) => updateList(value),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xff302360),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Eg: The House',
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) => ListTile(
                        title: Text(display_list[index].propertyName!),
                        subtitle: Text(display_list[index].description!),
                      ),
                      itemCount: display_list.length,
                    ),
                  )
                ])));
  }
}
