import 'package:diety/Core/utils/Colors.dart';
import 'package:diety/features/Home/view/view/MainNavBarScreen.dart';
import 'package:diety/features/Search_Food/widget/AppBar.dart';
import 'package:diety/features/Search_Food/widget/CustomSearchFood.dart';
import 'package:flutter/material.dart';

class Breakfast extends StatefulWidget {
  const Breakfast({super.key});

  @override
  State<Breakfast> createState() => _BreakfastState();
}

class _BreakfastState extends State<Breakfast> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBarFood(
        text: 'Breakfast',
        onPressed: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const MainNavBarScreen(),
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
