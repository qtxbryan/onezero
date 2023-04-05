import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Property {
  final String id;
  final String name;
  final String address;

  Property(this.id, this.name, this.address);
}

class PropertyListingPage extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Property Listing"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection("properties").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final properties = snapshot.data.docs
              .map((doc) => Property(doc.id, doc["name"], doc["address"]))
              .toList();

          return ListView.builder(
            itemCount: properties.length,
            itemBuilder: (context, index) {
              final property = properties[index];
              return ListTile(
                title: Text(property.name),
                subtitle: Text(property.address),
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
    final result = await Navigator.pushNamed(context, "/addProperty");
    if (result == true) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Property added successfully!"),
      ));
    }
  }

  void editProperty(BuildContext context, Property property) async {
    final result = await Navigator.pushNamed(context, "/editProperty",
        arguments: property);
    if (result == true) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Property updated successfully!"),
      ));
    }
  }

  void deleteProperty(Property property) async {
    await FirebaseFirestore.instance
        .collection("properties")
        .doc(property.id)
        .delete();
  }
}

class AddPropertyPage extends StatefulWidget {
  @override
  _AddPropertyPageState createState() => _AddPropertyPageState();
}

class _AddPropertyPageState extends State<AddPropertyPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Property"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Property Name",
              ),
            ),
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: "Property Address",
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text("Add Property"),
              onPressed: () => addProperty(context),
            ),
          ],
        ),
      ),
    );
  }

  void addProperty(BuildContext context) async {
    final name = nameController.text.trim();
    final address = addressController.text.trim();

    if (name.isNotEmpty && address.isNotEmpty) {
      await FirebaseFirestore.instance.collection("properties").add({
        "name": name,
        "address": address,
      });
      Navigator.pop(context, true);
    }
  }
}

class EditPropertyPage extends StatefulWidget {
  final Property property;

  EditPropertyPage(this.property);

  @override
  _EditPropertyPageState createState() => _EditPropertyPageState();
}

class _EditPropertyPageState extends State<EditPropertyPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.property.name;
    addressController.text = widget.property.address;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Property"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Property Name",
              ),
            ),
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: "Property Address",
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text("Save Changes"),
              onPressed: () => saveChanges(context),
            ),
          ],
        ),
      ),
    );
  }

  void saveChanges(BuildContext context) async {
    final name = nameController.text.trim();
    final address = addressController.text.trim();
    if (name.isNotEmpty && address.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection("properties")
          .doc(widget.property.id)
          .update({
        "name": name,
        "address": address,
      });
      Navigator.pop(context, true);
    }
  }
}
