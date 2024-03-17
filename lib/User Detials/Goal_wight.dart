import 'package:diety/Core/Colors.dart';
import 'package:diety/User%20Detials/wishes.dart';
import 'package:flutter/material.dart';

class Goal_Weight extends StatefulWidget {
  const Goal_Weight({super.key});

  @override
  State<Goal_Weight> createState() => _Goal_WeightState();
}

class _Goal_WeightState extends State<Goal_Weight> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const Wishes(),
              ));
            },
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.text,
              size: 30,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
                width: double.infinity,
                height: 70,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.button, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Lose 0.25 Kg Per Week',
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColors.text,
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
