import 'package:diety/Core/Colors.dart';
import 'package:diety/Search%20Food/widget/AppBar.dart';
import 'package:diety/Search%20Food/widget/CustomSearchFood.dart';
import 'package:diety/User%20Plane/view/view/plane.dart';
import 'package:flutter/material.dart';

class Snacks extends StatefulWidget {
  const Snacks({super.key});

  @override
  State<Snacks> createState() => _SnacksState();
}

class _SnacksState extends State<Snacks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBarFood(
        text: 'Snacks/Other',
        onPressed: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const Plane(),
          ));
        },
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            CustomSearchFood(
              hintText: 'Search for Food',
            )
          ],
        ),
      ),
    );
  }
}