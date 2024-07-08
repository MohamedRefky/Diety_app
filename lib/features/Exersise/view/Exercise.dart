import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diety/features/Exersise/view/Day1.dart';
import 'package:diety/features/Exersise/view/Day2.dart';
import 'package:diety/features/Exersise/view/Day3.dart';
import 'package:diety/features/Exersise/view/Day4.dart';
import 'package:diety/features/Exersise/view/Day5.dart';
import 'package:diety/features/Exersise/view/Day6.dart';
import 'package:diety/features/Exersise/view/Day7.dart';
import 'package:diety/features/Exersise/widget/Container_Exercise.dart';
import 'package:diety/features/Home/view/view/Home.dart';
import 'package:diety/features/Home/view/widget/navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;

import '../../../Core/utils/Colors.dart';

class Exercise extends StatefulWidget {
  const Exercise({Key? key}) : super(key: key);

  @override
  _ExerciseState createState() => _ExerciseState();
}

//DAY 1
String? D1_activity1;
String? D1_activity2;
String? D1_activity3;
String? D1_description1;
String? D1_description2;
String? D1_description3;
String? D1_duration1;
String? D1_duration2;
String? D1_duration3;
String? D1_image;
//DAY 2
String? D2_activity1;
String? D2_description1;
String? D2_duration1;
String? D2_image;
//DAY 3
String? D3_activity1;
String? D3_activity2;
String? D3_description1;
String? D3_description2;
String? D3_duration1;
String? D3_duration2;
String? D3_image;
//DAY 4
String? D4_activity1;
String? D4_activity2;
String? D4_description1;
String? D4_description2;
String? D4_duration2;
String? D4_image;
//DAY 5
String? D5_activity1;
String? D5_activity2;
String? D5_activity3;
String? D5_description1;
String? D5_description2;
String? D5_description3;
String? D5_duration3;
String? D5_image;
//DAY 6
String? D6_activity1;
String? D6_description1;
String? D6_duration1;
String? D6_image;
//DAY 7
String? D7_activity1;
String? D7_description1;
String? D7_duration1;
String? D7_image;

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

class _ExerciseState extends State<Exercise> {
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

  String _getHealthState(double? prediction) {
    if (prediction == null) return 'Loading...';
    if (prediction == 1.0) return 'Severely Underweight';
    if (prediction == 2.0) return 'Underweight';
    if (prediction == 3.0) return 'Mildly Underweight';
    if (prediction == 4.0) return 'Normal Weight';
    if (prediction == 5.0) return ' Overweight';
    if (prediction == 6.0 || prediction == 7.0) return 'Obesity';
    return 'Unknown';
  }

  String _getAdvanceHealthState(double? prediction) {
    if (prediction == null || _isLoading) return 'Loading...';
    if (prediction == 1.0) {
      return 'This Program is for People with Severely Underweight. It is designed to help you Gain Weight and build muscle.';
    }
    if (prediction == 2.0) {
      return 'This Program is for People with Underweight. It is designed to help you Gain Weight and build muscle.';
    }
    if (prediction == 3.0) {
      return 'This Program is for People with Mildly Underweight. It is designed to help you to Maintain Weight and build muscle.';
    }
    if (prediction == 4.0) return 'Normal Weight';
    if (prediction == 5.0) {
      return 'This Program is for People with Overweight. It is designed to help you Lose Weight and build muscle.';
    }
    if (prediction == 6.0 || prediction == 7.0) {
      return 'This Program is for People with Obesity. It is designed to help you Lose Weight and build muscle.';
    }
    return 'Unknown';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Exersise Plan',
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
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
      bottomNavigationBar: const salomon_bottom_bar(),
      body: Center(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                color: AppColors.button,
              ))
            : Padding(
                padding: const EdgeInsets.all(15),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                              'Health State : ${_getHealthState(_predictionResult)}',
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const Gap(10),
                      Text(
                        _getAdvanceHealthState(_predictionResult),
                        style: TextStyle(
                            color: AppColors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      const Gap(10),
                      Container_Exercise(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Day1(),
                            ));
                          },
                          Day: 'Day 1',
                          activity1: '$D1_activity1',
                          activity2: '$D1_activity2',
                          activity3: '$D1_activity3 ',
                          description1: '$D1_description1',
                          description2: '$D1_description2',
                          description3: '$D1_description3',
                          duration1: '$D1_duration1',
                          duration2: '$D1_duration2',
                          duration3: '$D1_duration3',
                          image: '$D1_image'),
                      const Gap(10),
                      Container_Exercise(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Day2(),
                          ));
                        },
                        Day: 'Day 2',
                        activity1: '$D2_activity1',
                        description1: '$D2_description1',
                        duration1: '$D2_duration1',
                        image: '$D2_image',
                      ),
                      const Gap(10),
                      Container_Exercise(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Day3(),
                          ));
                        },
                        Day: 'Day 3',
                        activity1: '$D3_activity1',
                        activity2: '$D3_activity2',
                        description1: '$D3_description1',
                        description2: '$D3_description2',
                        duration1: '$D3_duration1',
                        duration2: '$D3_duration2',
                        image: '$D3_image',
                      ),
                      const Gap(10),
                      Container_Exercise(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Day4(),
                          ));
                        },
                        Day: 'Day 4',
                        activity1: '$D4_activity1',
                        activity2: '$D4_activity2',
                        description1: '$D4_description1',
                        description2: '$D4_description2',
                        duration1: '$D4_duration1',
                        duration2: '$D4_duration2',
                        image: '$D4_image',
                      ),
                      const Gap(10),
                      Container_Exercise(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Day5(),
                          ));
                        },
                        Day: 'Day 5',
                        activity1: '$D5_activity1',
                        activity2: '$D5_activity2',
                        activity3: '$D5_activity3 ',
                        description1: '$D5_description1',
                        description2: '$D5_description2',
                        description3: '$D5_description3',
                        duration1: '$D5_duration1',
                        duration2: '$D5_duration2',
                        duration3: '$D5_duration3',
                        image: '$D5_image',
                      ),
                      const Gap(10),
                      Container_Exercise(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Day6(),
                          ));
                        },
                        Day: 'Day 6',
                        activity1: '$D6_activity1',
                        description1: '$D6_description1',
                        duration1: '$D6_duration1',
                        image: '$D6_image',
                      ),
                      const Gap(10),
                      Container_Exercise(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Day7(),
                          ));
                        },
                        Day: 'Day 7',
                        activity1: '$D7_activity1',
                        description1: '$D7_description1',
                        duration1: '$D7_duration1',
                        image: '$D7_image',
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Future<void> fetchActivityData() async {
    try {
      if (_predictionResult != null && _predictionResult != 0.0) {
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
          .doc('plan2')
          .get();

      if (doc.exists) {
        print('Document exists');

        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        print('Document data: $data');

        var day1 = data['Day1'];
        var day2 = data['Day2'];
        var day3 = data['Day3'];
        var day4 = data['Day4'];
        var day5 = data['Day5'];
        var day6 = data['Day6'];
        var day7 = data['Day7'];

        if (day1 is Map<String, dynamic>) {
          if (!_isDisposed) {
            setState(() {
              // DAY 1
              D1_activity1 = day1['Activity1'] ?? ' ';
              D1_activity2 = day1['Activity2'] ?? ' ';
              D1_activity3 = day1['Activity3'] ?? ' ';
              D1_description1 = day1['Description1'] ?? ' ';
              D1_description2 = day1['Description2'] ?? ' ';
              D1_description3 = day1['Description3'] ?? ' ';
              D1_duration1 = day1['Duration1'] ?? ' ';
              D1_duration2 = day1['Duration2'] ?? ' ';
              D1_duration3 = day1['Duration3'] ?? ' ';
              D1_image = day1['image'];
              // DAY 2
              D2_activity1 = day2['Activity1'] ?? ' ';
              D2_description1 = day2['Description1'] ?? ' ';
              D2_duration1 = day2['Duration1'] ?? ' ';
              D2_image = day2['image'];
              // DAY 3
              D3_activity1 = day3['Activity1'] ?? ' ';
              D3_activity2 = day3['Activity2'] ?? ' ';
              D3_description1 = day3['Description1'] ?? ' ';
              D3_description2 = day3['Description2'] ?? ' ';
              D3_duration1 = day3['Duration1'] ?? ' ';
              D3_duration2 = day3['Duration2'] ?? ' ';
              D3_image = day3['image'];
              // DAY 4
              D4_activity1 = day4['Activity1'] ?? ' ';
              D4_activity2 = day4['Activity2'] ?? ' ';
              D4_description1 = day4['Description1'] ?? ' ';
              D4_description2 = day4['Description2'] ?? ' ';
              D4_duration1 = day4['Duration1'] ?? ' ';
              D4_duration2 = day4['Duration2'] ?? ' ';
              D4_image = day4['image'];
              // DAY 5
              D5_activity1 = day5['Activity1'] ?? ' ';
              D5_activity2 = day5['Activity2'] ?? ' ';
              D5_activity3 = day5['Activity3'] ?? ' ';
              D5_description1 = day5['Description1'] ?? ' ';
              D5_description2 = day5['Description2'] ?? ' ';
              D5_description3 = day5['Description3'] ?? ' ';
              D5_duration3 = day5['Duration3'] ?? ' ';
              D5_image = day5['image'];
              // DAY 6
              D6_activity1 = day6['Activity1'] ?? ' ';
              D6_description1 = day6['Description1'] ?? ' ';
              D6_duration1 = day6['Duration1'] ?? ' ';
              D6_image = day6['image'];
              // DAY 7
              D7_activity1 = day7['Activity1'] ?? ' ';
              D7_description1 = day7['Description1'] ?? ' ';
              D7_duration1 = day7['Duration1'] ?? ' ';
              D7_image = day7['image'];
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
