import 'package:diety/Core/utils/Colors.dart';
import 'package:diety/features/main/MainNavBarScreen.dart';
import 'package:diety/features/Search_Food/widget/AppBar.dart';
import 'package:diety/features/Search_Food/widget/CustomSearchFood.dart';
import 'package:diety/features/Search_Food/cubit/search_food_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocProvider(
          create: (context) => SearchFoodCubit(),
          child: const CustomSearchFood(),
        ),
      ),
    );
  }
}
