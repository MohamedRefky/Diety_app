// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diety/Core/utils/Colors.dart';
import 'package:diety/Core/widget/Custom_Button.dart';
import 'package:diety/features/Asks/widget/textFormfield.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Deleteplanes extends StatefulWidget {
  const Deleteplanes({Key? key}) : super(key: key);

  @override
  _DeleteplanesState createState() => _DeleteplanesState();
}

class _DeleteplanesState extends State<Deleteplanes> {
  final TextEditingController _collectionController = TextEditingController();
  final TextEditingController _docController = TextEditingController();
  final TextEditingController _fieldController = TextEditingController();
  final TextEditingController _mapKeyController = TextEditingController();

  Future<void> deleteCollection(String collectionName) async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection(collectionName).get();
      for (DocumentSnapshot docSnapshot in querySnapshot.docs) {
        await docSnapshot.reference.delete();
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Collection deleted successfully')),
      );
      _collectionController.clear();
    } catch (e) {
      print('Error deleting collection: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete collection')),
      );
    }
  }

  Future<void> deleteDocument(String collectionName, String docName) async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(docName)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Document deleted successfully')),
      );
      _collectionController.clear();
      _docController.clear();
    } catch (e) {
      print('Error deleting document: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete document')),
      );
    }
  }

  Future<void> deleteField(
      String collectionName, String docName, String fieldName) async {
    try {
      DocumentReference docRef =
          FirebaseFirestore.instance.collection(collectionName).doc(docName);
      DocumentSnapshot docSnapshot = await docRef.get();

      if (!docSnapshot.exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Document does not exist')),
        );
        return;
      }

      Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;
      if (data != null && data.containsKey(fieldName)) {
        data.remove(fieldName);
        await docRef.set(data);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Field deleted successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Field does not exist')),
        );
      }
      _collectionController.clear();
      _docController.clear();
      _fieldController.clear();
    } catch (e) {
      print('Error deleting field: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete field')),
      );
    }
  }

  Future<void> deleteMapKey(String collectionName, String docName,
      String mapFieldName, String mapKey) async {
    try {
      DocumentReference docRef =
          FirebaseFirestore.instance.collection(collectionName).doc(docName);
      DocumentSnapshot docSnapshot = await docRef.get();

      if (!docSnapshot.exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Document does not exist')),
        );
        return;
      }

      Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;
      if (data != null &&
          data.containsKey(mapFieldName) &&
          data[mapFieldName] is Map &&
          data[mapFieldName].containsKey(mapKey)) {
        data[mapFieldName].remove(mapKey);
        await docRef.set(data);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Map key deleted successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Map key does not exist')),
        );
      }
      _collectionController.clear();
      _docController.clear();
      _fieldController.clear();
      _mapKeyController.clear();
    } catch (e) {
      print('Error deleting map key: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete map key')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.white,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Delete Planes',
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Gap(10),
              textFormField(
                keyboardType: TextInputType.text,
                labelText: 'Collection Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a map value';
                  }
                  return null;
                },
                mycontroller: _collectionController,
              ),
              const Gap(10),
              textFormField(
                keyboardType: TextInputType.text,
                labelText: 'Document Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a map value';
                  }
                  return null;
                },
                mycontroller: _docController,
              ),
              const Gap(10),
              Custom_Button(
                width: 350,
                height: 60,
                icon: Icons.delete,
                iconColor: Colors.red,
                text: 'Delete Document',
                onPressed: () {
                  String collectionName = _collectionController.text.trim();
                  String docName = _docController.text.trim();

                  if (collectionName.isNotEmpty && docName.isNotEmpty) {
                    deleteDocument(collectionName, docName);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                        'Please fill in all fields',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                    );
                  }
                },
              ),
              const Gap(10),
              const Divider(
                color: Colors.grey,
                thickness: 0.5,
              ),
              const Gap(10),
              textFormField(
                keyboardType: TextInputType.text,
                labelText: 'Field Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a map value';
                  }
                  return null;
                },
                mycontroller: _fieldController,
              ),
              const Gap(10),
              Custom_Button(
                width: 350,
                height: 60,
                icon: Icons.delete,
                iconColor: Colors.red,
                text: 'Delete Field',
                onPressed: () {
                  String collectionName = _collectionController.text.trim();
                  String docName = _docController.text.trim();
                  String fieldName = _fieldController.text.trim();

                  if (collectionName.isNotEmpty &&
                      docName.isNotEmpty &&
                      fieldName.isNotEmpty) {
                    deleteField(collectionName, docName, fieldName);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Please fill in all fields',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                    );
                  }
                },
              ),
              const Gap(10),
              const Divider(
                color: Colors.grey,
                thickness: 0.5,
              ),
              const Gap(10),
              textFormField(
                keyboardType: TextInputType.text,
                labelText: 'Map Key (for map deletion)',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a map value';
                  }
                  return null;
                },
                mycontroller: _mapKeyController,
              ),
              const Gap(10),
              Custom_Button(
                width: 350,
                height: 60,
                icon: Icons.delete,
                iconColor: Colors.red,
                text: 'Delete Map Key',
                onPressed: () {
                  String collectionName = _collectionController.text.trim();
                  String docName = _docController.text.trim();
                  String mapFieldName = _fieldController.text.trim();
                  String mapKey = _mapKeyController.text.trim();

                  if (collectionName.isNotEmpty &&
                      docName.isNotEmpty &&
                      mapFieldName.isNotEmpty &&
                      mapKey.isNotEmpty) {
                    deleteMapKey(collectionName, docName, mapFieldName, mapKey);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Please fill in all fields',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                    );
                  }
                },
              ),
              const Gap(10),
              Custom_Button(
                width: 200,
                height: 60,
                icon: Icons.delete,
                iconColor: Colors.red,
                text: 'Delete Collection',
                onPressed: () {
                  String collectionName = _collectionController.text.trim();
                  if (collectionName.isNotEmpty) {
                    deleteCollection(collectionName);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Please enter collection name',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
