
// import 'package:tflite/tflite.dart';
// import 'package:flutter/material.dart';

// class MyModelLoader extends StatefulWidget {
//   @override
//   _MyModelLoaderState createState() => _MyModelLoaderState();
// }

// class _MyModelLoaderState extends State<MyModelLoader> {
//   @override
//   void initState() {
//     super.initState();
//     loadModel();
//   }

//   Future<void> loadModel() async {
//     try {
//       String modelPath = 'Images/decision_tree_model.tflite';
//       await Tflite.loadModel(model: modelPath);
//       print('Model loaded successfully');
//     } catch (e) {
//       print('Failed to load model: $e');
//     }
//   }

//   @override
//   void dispose() {
//     Tflite.close(); // Dispose TFLite resources
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(); // Placeholder widget
//   }
// }
