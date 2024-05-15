import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diety/features/Home/view/view/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;

import '../../../../Core/utils/Colors.dart';

class Exercise extends StatefulWidget {
  const Exercise({Key? key}) : super(key: key);

  @override
  _ExerciseState createState() => _ExerciseState();
}

// Change the type to List<dynamic>
bool _isLoading = false;
String gender = '';
String age = '0';
String height = '0';
late int Height;
late int Age;
late int Weight;

String weight = '0';
final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
late String _uid;
Map<String, dynamic>? day1;
Map<String, dynamic>? day2;
Map<String, dynamic>? day3;
Map<String, dynamic>? day4;
Map<String, dynamic>? day5;
Map<String, dynamic>? day6;
Map<String, dynamic>? day7;

String? description2;
String? dd;

class _ExerciseState extends State<Exercise> {
  late double _predictionResult;
  @override
  void initState() {
    super.initState();
    _fetchPrediction();
    _getUserdData();
   // _getUserdExercise();
  }

  // ignore: unused_element
  // Future<void> _getUserdExercise() async {
  //   User? user = _auth.currentUser;
  //   if (user != null) {
  //     setState(() {
  //       _uid = user.uid;
  //     });

  //     try {
        
  //       DocumentSnapshot planDoc = await _firestore
  //           .collection('exercise_plans')
  //           .doc('plan1') // Assuming 'plan1' is under the user's document
  //           .get();

  //       // Adjust the path if 'plan1' is not directly under the user's document
  //       // Example: .collection('exercise_plans').doc(_uid).collection('plan1').get();

  //       setState(() {
  //         dd = planDoc.get('dd') ?? 'Not available';

  //         day1 = planDoc.get('day1') ?? 'Not available';
  //         description2 = planDoc.get('Description2') ?? 'Not available';
  //       });
  //     } catch (error) {
  //       // Handle any errors that occur during fetching
  //       print('Error fetching exercise plan: $error');
  //       setState(() {
  //         description2 = 'Not available';
  //       });
  //     }
  //   }
  // }
//   Future<void> readNestedField() async {
// 	CollectionReference plansCollection = 	FirebaseFirestore.instance.collection('exercise_plans');
// 	DocumentReference planDocument = 	plansCollection.doc('plan1');
// 	DocumentSnapshot planSnapshot = await planDocument.get();
// 	dynamic activity1Value = planSnapshot.data()['day1'].activity1;
// 	print('Value of activity1: $activity1Value');
// }

  Future<void> _getUserdData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        _uid = user.uid;
      });

      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(_uid).get();
      setState(() {
        height = userDoc.get('height') ?? '0';
        weight = userDoc.get('weight') ?? '0';
        age = userDoc.get('age') ?? '0';
        gender = userDoc.get('gender') ?? '';
        Weight = int.parse(weight);
        Age = int.parse(age);
        Height = int.parse(height);
      });
    }
  }

  // ignore: unused_element

  Future<void> _fetchPrediction() async {
    setState(() {
      _isLoading = true;
    });
    var url = Uri.parse('http://10.0.2.2:5000/predict');
    var data = {
      'Weight': [Weight],
      'Height': [Height],
      'Gender': [gender.toString()],
      'Age': [Age]
    };
    try {
      var jsonData = jsonEncode(data);
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonData,
      );

      if (response.statusCode == 200) {
        // Decode the JSON response
        var decodedResponse = jsonDecode(response.body);
        // Access the 'predictions' key as a List<dynamic>
        var predictions = decodedResponse['predictions'];
        if (predictions is List && predictions.isNotEmpty) {
          // If predictions is a non-empty list, take the first element as double
          setState(() {
            _predictionResult = predictions[0].toDouble();
          });
        } else {
          // If predictions is empty or not a list, set _predictionResult to 0
          setState(() {
            _predictionResult = 0;
          });
        }
      } else {
        // If response status code is not 200, set _predictionResult to 0
        setState(() {
          _predictionResult = 0;
        });
      }
    } catch (error) {
      // If an error occurs during prediction fetching, set _predictionResult to 0
      setState(() {
        _predictionResult = 0;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Exercise',
          style: TextStyle(color: AppColors.white),
        ),
        backgroundColor: AppColors.background,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const Home(),
              ));
            },
            icon: Icon(Icons.arrow_back, color: AppColors.white)),
      ),
      body: Center(
        child: Column(
          children: [
            _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: Text(
                        "$_predictionResult"), // Convert the list to a string for display
                  ),
            Row(
              children: [
                Text('Age: $age '),
                const Gap(10),
                Text(' Height:$height'),
                const Gap(10),
                Text('Weight: $weight'),
                const Gap(10),
                Text('Gender: $gender'),
                const Gap(10),
              ],
            ),
            Text(dd.toString()),
            const Gap(10),
            Text(
                'Day2: ${day2 != null ? day2!['Activity1'] : 'Not available'}'),
            const Gap(10),
            Text(
                'Day3: ${day3 != null ? day3!['Activity1'] : 'Not available'}'),
            const Gap(10),
            Text(
                'Day4: ${day4 != null ? day4!['Activity1'] : 'Not available'}'),
            const Gap(10),
            Text(
                'Day5: ${day5 != null ? day5!['Activity1'] : 'Not available'}'),
            const Gap(10),
            Text(
                'Day6: ${day6 != null ? day6!['Activity1'] : 'Not available'}'),
            const Gap(10),
            Text(
                'Day7: ${day7 != null ? day7!['Activity1'] : 'Not available'}'),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}
