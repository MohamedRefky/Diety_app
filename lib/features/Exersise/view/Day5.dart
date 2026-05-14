import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diety/features/Exersise/view/Exercise.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;

import '../../../Core/utils/Colors.dart';

class Day5 extends StatefulWidget {
  const Day5({
    Key? key,
  }) : super(key: key);

  @override
  _ExerciseState createState() => _ExerciseState();
}

//DAY 5
String? D5_activity1;
String? D5_activity2;
String? D5_activity3;
String? D5_description1;
String? D5_description2;
String? D5_description3;
String? D5_duration1;
String? D5_duration2;
String? D5_duration3;

// ignore: unused_element
bool _isLoading = false;
String gender = '';
String age = '0';
String height = '0';
int? Height;
int? Age;
int? Weight;
String weight = '0';
final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
String? _uid;
String? plan;

class _ExerciseState extends State<Day5> {
  String? activityData;
  final bool _isDisposed = false;
  double? _predictionResult;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await _getUserdData();
    await _fetchPrediction();
    await fetchActivityData();
  }

  Future<void> _getUserdData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      _uid = user.uid;

      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(_uid).get();
      setState(() {
        height = userDoc.get('height') ?? '0';
        weight = userDoc.get('weight') ?? '0';
        age = userDoc.get('age') ?? '0';
        gender = userDoc.get('gender') ?? '';
        Weight = int.tryParse(weight) ?? 0;
        Age = int.tryParse(age) ?? 0;
        Height = int.tryParse(height) ?? 0;
      });
    }
  }

  Future<void> _fetchPrediction() async {
    if (Weight == null || Height == null || Age == null) {
      return;
    }

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
        var decodedResponse = jsonDecode(response.body);
        var predictions = decodedResponse['predictions'];
        if (predictions is List && predictions.isNotEmpty) {
          setState(() {
            _predictionResult = predictions[0].toDouble();
          });
        } else {
          setState(() {
            _predictionResult = 0;
          });
        }
      } else {
        setState(() {
          _predictionResult = 0;
        });
      }
    } catch (error) {
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
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Exercise Details',
          style: TextStyle(color: AppColors.white),
        ),
        backgroundColor: AppColors.background,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(MaterialPageRoute(
                builder: (context) => const Exercise(),
              ));
            },
            icon: Icon(Icons.arrow_back, color: AppColors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Day 5',
              style: TextStyle(
                  color: AppColors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold),
            ),
            const Gap(10),
            if ( D5_activity1 != null && D5_activity1!.isNotEmpty)
              Text(
                '$D5_activity1 : $D5_duration1',
                style: TextStyle(
                    color: AppColors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            const Gap(15),
            if (D5_description1 != null)
            Text(
              '$D5_description1',
              style: TextStyle(
                color: AppColors.grey,
                fontSize: 18,
              ),
            ),
            const Gap(25),
            if (D5_activity2 != null && D5_activity2!.isNotEmpty)
              Text(
                '$D5_activity2 : $D5_duration2',
                style: TextStyle(
                    color: AppColors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            const Gap(15),
            if (D5_description2 != null)
            Text(
              '$D5_description2',
              style: TextStyle(
                color: AppColors.grey,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchActivityData() async {
    try {
      if (_predictionResult != null) {
        switch (_predictionResult) {
          case 1.0:
            plan = 'plan1';
            break;
          case 2.0:
            plan = 'plan2';
            break;
          case 3.0:
            plan = 'plan3';
            break;
          case 4.0:
            plan = 'plan4';
            break;
          case 5.0:
            plan = 'plan5';
            break;
          case 6.0:
          case 7.0:
            plan = 'plan6';
            break;
          default:
            plan = 'plan4';
        }
      }

      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('exercise_plans')
          .doc(plan)
          .get();

      if (doc.exists) {
        print('Document exists');

        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        print('Document data: $data');

        var day5 = data['Day5'];

        if (day5 is Map<String, dynamic>) {
          if (!_isDisposed) {
            setState(() {
              // DAY 5
              D5_activity1 = day5['Activity1'] ?? ' ';
              D5_activity2 = day5['Activity2'] ?? ' ';
              D5_activity3 = day5['Activity3'] ?? ' ';
              D5_description1 = day5['Description1'] ?? ' ';
              D5_description2 = day5['Description2'] ?? ' ';
              D5_description3 = day5['Description3'] ?? ' ';
              D5_duration1 = day5['Duration1'] ?? '10 minutes';
              D5_duration2 = day5['Duration2'] ?? '10 minutes';
              D5_duration3 = day5['Duration3'] ?? '10 minutes';
            });
            print('$D2_activity1'); // This should print the activity data
          }
        } else {
          print('Day1 is not a map!');
        }
      } else {
        print('plan $plan');
        print('Document does not exist!');
      }
    } catch (e) {
      print('Error retrieving data: $e');
    }
  }
}
