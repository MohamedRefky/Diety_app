import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diety/Core/utils/Colors.dart';
import 'package:diety/features/Home/view/widget/Custom-Container.dart';
import 'package:diety/features/Search_Food/view/Breakfast.dart';
import 'package:diety/features/Search_Food/view/Dinner.dart';
import 'package:diety/features/Search_Food/view/Lunch.dart';
import 'package:diety/features/Search_Food/view/Snacks.dart';
import 'package:diety/features/Exersise/view/Exercise.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:gap/gap.dart';

class HomeMealSlots extends StatelessWidget {
  const HomeMealSlots({super.key});

  Future<void> _addDataFromFileToFirestore() async {
    try {
      String fileContent = await rootBundle.loadString('assets/plan.json');
      List<dynamic> jsonDataList = jsonDecode(fileContent);
      if (jsonDataList.isNotEmpty) {
        Map<String, dynamic> jsonData = jsonDataList.first;
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        await firestore.collection('exercise_plans').doc('plan6').set(jsonData);
        print('Data from file added to Firestore successfully');
      } else {
        print('No data found in the file.');
      }
    } catch (error) {
      print('Error adding data from file to Firestore: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomContainer(
          onTap: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const Breakfast(),
            ));
          },
          text: 'Breakfast',
          iconData1: CupertinoIcons.sun_dust_fill,
          iconColor: Colors.yellow,
          iconData2: CupertinoIcons.plus,
          style: TextStyle(
            fontSize: 20,
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(10),
        CustomContainer(
          onTap: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const Lunch(),
            ));
          },
          text: 'Lunch',
          iconData1: CupertinoIcons.sun_max_fill,
          iconColor: const Color(0xff00b4f2),
          iconData2: CupertinoIcons.plus,
          style: TextStyle(
            fontSize: 20,
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(10),
        CustomContainer(
          onTap: () {
            _addDataFromFileToFirestore();
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const Dinner(),
            ));
          },
          text: 'Dinner',
          iconData1: CupertinoIcons.sun_haze,
          iconColor: const Color(0xfff69875),
          iconData2: CupertinoIcons.plus,
          style: TextStyle(
            fontSize: 20,
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(10),
        CustomContainer(
          onTap: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const Snacks(),
            ));
          },
          text: 'Snacks/Other',
          iconData1: Icons.dark_mode,
          iconColor: const Color(0xff915bbf),
          iconData2: CupertinoIcons.plus,
          style: TextStyle(
            fontSize: 20,
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(10),
        CustomContainer(
          onTap: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const Exercise(),
            ));
          },
          text: 'Add Exercise/Sleep',
          iconData1: Icons.directions_run_outlined,
          iconColor: const Color.fromRGBO(105, 111, 125, 1.0),
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey.shade400,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
