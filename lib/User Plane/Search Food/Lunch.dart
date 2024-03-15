import 'package:diety/User%20Plane/plane.dart';
import 'package:diety/User%20Plane/widget/AppBar.dart';
import 'package:diety/User%20Plane/widget/CustomSearchFood.dart';
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
      backgroundColor: const Color(0xff030b18),
      appBar: CustomAppBarFood(
        text: 'Lunch',
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