import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onezero/models/Listing.dart';
import 'package:onezero/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:onezero/pages/add_property_page.dart';
import 'package:onezero/pages/edit_property_page.dart';

class PropertyListingPage extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Auth _auth = Auth();

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text("Property Listing"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection("listing").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final properties = snapshot.data!.docs
              .map((doc) => Listing(
                    id: doc.id,
                    address: doc['address'],
                    description: doc['description'],
                    dimension: doc['dimension'],
                    lease: doc['lease'],
                    neighbourhood: doc['neighbourhood'],
                    numOfBedroom: doc['numOfBedroom'],
                    price: doc['price'],
                    propertyName: doc['propertyName'],
                    listed_by_email: user!.email,
                    upload_url: doc['upload_url'],
                  ))
              .toList();

          return ListView.builder(
            itemCount: properties.length,
            itemBuilder: (context, index) {
              final property = properties[index];
              return ListTile(
                title: Text(property.propertyName!),
                subtitle: Text(property.address!),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => editProperty(context, property),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => deleteProperty(property),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => addProperty(context),
      ),
    );
  }

  void addProperty(BuildContext context) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: ((context) => AddPropertyPage())));
    if (result == true) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Property added successfully!"),
      ));
    }
  }

  void editProperty(BuildContext context, Listing property) async {
    final result = await Navigator.push(context,
        MaterialPageRoute(builder: ((context) => EditPropertyPage(property))));
    if (result == true) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Property updated successfully!"),
      ));
    }
  }

  void deleteProperty(Listing property) async {
    await FirebaseFirestore.instance
        .collection("listing")
        .doc(property.id)
        .delete();
  }
}

// class AddPropertyPage extends StatefulWidget {
//   @override
//   _AddPropertyPageState createState() => _AddPropertyPageState();
// }

// class _AddPropertyPageState extends State<AddPropertyPage> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Add Property"),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               controller: nameController,
//               decoration: InputDecoration(
//                 labelText: "Property Name",
//               ),
//             ),
//             TextField(
//               controller: addressController,
//               decoration: InputDecoration(
//                 labelText: "Property Address",
//               ),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               child: Text("Add Property"),
//               onPressed: () => addProperty(context),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void addProperty(BuildContext context) async {
//     final name = nameController.text.trim();
//     final address = addressController.text.trim();

//     if (name.isNotEmpty && address.isNotEmpty) {
//       await FirebaseFirestore.instance.collection("properties").add({
//         "name": name,
//         "address": address,
//       });
//       Navigator.pop(context, true);
//     }
//   }
// }

// class EditPropertyPage extends StatefulWidget {
//   final Listing property;

//   EditPropertyPage(this.property);

//   @override
//   _EditPropertyPageState createState() => _EditPropertyPageState();
// }

// class _EditPropertyPageState extends State<EditPropertyPage> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     nameController.text = widget.property.name;
//     addressController.text = widget.property.address;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Edit Property"),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               controller: nameController,
//               decoration: InputDecoration(
//                 labelText: "Property Name",
//               ),
//             ),
//             TextField(
//               controller: addressController,
//               decoration: InputDecoration(
//                 labelText: "Property Address",
//               ),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               child: Text("Save Changes"),
//               onPressed: () => saveChanges(context),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void saveChanges(BuildContext context) async {
//     final name = nameController.text.trim();
//     final address = addressController.text.trim();
//     if (name.isNotEmpty && address.isNotEmpty) {
//       await FirebaseFirestore.instance
//           .collection("properties")
//           .doc(widget.property.id)
//           .update({
//         "propertyName": name,
//         "address": address,
//       });
//       Navigator.pop(context, true);
//     }
//   }
// }
