import 'package:diety/Core/utils/Colors.dart';
import 'package:diety/features/main/MainNavBarScreen.dart';
import 'package:diety/features/Search_Food/widget/AppBar.dart';
import 'package:diety/features/Search_Food/widget/CustomSearchFood.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Dinner extends StatefulWidget {
  const Dinner({super.key, this.response});
  final NotificationResponse? response;
  @override
  State<Dinner> createState() => _DinnerState();
}

class _DinnerState extends State<Dinner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBarFood(
        text: 'Dinner',
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
