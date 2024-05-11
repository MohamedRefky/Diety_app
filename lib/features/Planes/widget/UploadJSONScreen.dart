import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UploadJSONScreen extends StatefulWidget {
  const UploadJSONScreen({super.key});

  @override
  _UploadJSONScreenState createState() => _UploadJSONScreenState();
}

class _UploadJSONScreenState extends State<UploadJSONScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadData() async {
    final String response = await rootBundle.loadString('Images/json.json');
    final data = await json.decode(response);
    List<dynamic> entries = data as List<dynamic>;

    for (var entry in entries) {
      await _firestore.collection('fitnessPlans').add(entry);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload JSON to Firestore'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: uploadData,
          child: const Text('Upload Data'),
        ),
      ),
    );
  }
}
