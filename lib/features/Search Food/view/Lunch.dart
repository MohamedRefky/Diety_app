import 'package:diety/Core/utils/Colors.dart';
import 'package:diety/features/Home/view/view/Home.dart';
import 'package:diety/features/Search%20Food/widget/AppBar.dart';
import 'package:diety/features/Search%20Food/widget/CustomSearchFood.dart';
import 'package:flutter/material.dart';

class Lunch extends StatefulWidget {
  const Lunch({super.key});

  @override
  State<Lunch> createState() => _LunchState();
}

class _LunchState extends State<Lunch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBarFood(
        text: 'Lunch',
        onPressed: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const Home(),
          ));
        },
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: CustomSearchFood(),
      ),
    );
  }
}
