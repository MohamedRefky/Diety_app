// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diety/Core/utils/Colors.dart';
import 'package:diety/Core/widget/Custom_Button.dart';
import 'package:diety/features/Admin/view/DeletePlanes.dart';
import 'package:diety/features/Asks/widget/textFormfield.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ManagePlane extends StatefulWidget {
  const ManagePlane({super.key});

  @override
  _ManagePlaneState createState() => _ManagePlaneState();
}

class _ManagePlaneState extends State<ManagePlane> {
  final TextEditingController _collectionController = TextEditingController();
  final TextEditingController _docController = TextEditingController();
  final TextEditingController _fieldController = TextEditingController();
  final TextEditingController _mapKeyController = TextEditingController();
  final TextEditingController _mapValueController = TextEditingController();

  Future<void> addOrUpdateDocument(
    String collectionName,
    String docName,
    String fieldName,
    String mapKey,
    String mapValue,
  ) async {
    try {
      DocumentReference docRef =
          FirebaseFirestore.instance.collection(collectionName).doc(docName);
      DocumentSnapshot docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        // Update the existing map with new key-value pair
        await docRef.update({
          '$fieldName.$mapKey': mapValue,
        });
      } else {
        // Create a new document with the map
        await docRef.set({
          fieldName: {mapKey: mapValue},
        });
      }

      // Clear the text fields after operation
      _collectionController.clear();
      _docController.clear();
      _fieldController.clear();
      _mapKeyController.clear();
      _mapValueController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data added/updated successfully')),
      );
    } catch (e) {
      print('Error adding/updating document: $e');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add/update data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.white),
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Manage Plans',
              style: TextStyle(
                  color: AppColors.white, fontWeight: FontWeight.bold),
            ),
            const Gap(5),
            Icon(
              Icons.admin_panel_settings_outlined,
              color: AppColors.white,
              size: 30,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Gap(10),
              textFormField(
                keyboardType: TextInputType.text,
                labelText: 'Collection Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a collection name';
                  }
                  return null;
                },
                mycontroller: _collectionController,
              ),
              const Gap(15),
              textFormField(
                keyboardType: TextInputType.text,
                labelText: 'Document Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a document name';
                  }
                  return null;
                },
                mycontroller: _docController,
              ),
              const Gap(15),
              textFormField(
                keyboardType: TextInputType.text,
                labelText: 'Field Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a field name';
                  }
                  return null;
                },
                mycontroller: _fieldController,
              ),
              const Gap(10),
              textFormField(
                keyboardType: TextInputType.text,
                labelText: 'Map Key',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a map key';
                  }
                  return null;
                },
                mycontroller: _mapKeyController,
              ),
              const Gap(15),
              textFormField(
                keyboardType: TextInputType.text,
                labelText: 'Map Value',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a map value';
                  }
                  return null;
                },
                mycontroller: _mapValueController,
              ),
              const Gap(20),
              Custom_Button(
                width: 350,
                text: 'Add or Update Document',
                onPressed: () {
                  String collectionName = _collectionController.text.trim();
                  String docName = _docController.text.trim();
                  String fieldName = _fieldController.text.trim();
                  String mapKey = _mapKeyController.text.trim();
                  String mapValue = _mapValueController.text.trim();

                  if (collectionName.isNotEmpty &&
                      docName.isNotEmpty &&
                      fieldName.isNotEmpty &&
                      mapKey.isNotEmpty &&
                      mapValue.isNotEmpty) {
                    addOrUpdateDocument(
                        collectionName, docName, fieldName, mapKey, mapValue);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Please fill in all fields')),
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              Custom_Button(
                width: 350,
                icon: Icons.delete,
                iconColor: Colors.red,
                text: 'Delete Plans',
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const Deleteplanes();
                  }));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
