import 'package:diety/features/Asks/Age.dart';
// ignore: unused_import
import 'package:diety/features/User%20Detials/wishes.dart';
import 'package:diety/Core/Colors.dart';
import 'package:diety/Core/Container_Activites.dart';
import 'package:diety/Core/Custom_Button.dart';
import 'package:diety/features/User%20Detials/UserDitails.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Activates extends StatefulWidget {
  const Activates({super.key});

  @override
  State<Activates> createState() => _ActivatesState();
}

List<bool> isSelected = List.generate(5, (index) => false);

class _ActivatesState extends State<Activates> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const Age(),
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Countainer_activites(
                onTap: () {
                  setState(() {
                    isSelected = [true, false, false, false, false];
                  });
                },
                color: isSelected[0] ? AppColors.button : AppColors.background,
                height: 140,
                title: 'Sedentary 🪑',
                text:
                    'for people who spent most of their time \nsitting or lying down ex:Programmer, Bank\nTeller, Office Admin',
              ),
              const SizedBox(
                height: 15,
              ),
              Countainer_activites(
                onTap: () {
                  setState(() {
                    isSelected = [false, true, false, false, false];
                  });
                },
                color: isSelected[1] ? AppColors.button : AppColors.background,
                height: 170,
                title: 'Lightly Active 🚶',
                text:
                    'for people who engage in light physical \nactivities throughout the day, such as \nwalking or household chores ex:Teacher \nSalesman, school student',
              ),
              const SizedBox(
                height: 15,
              ),
              Countainer_activites(
                onTap: () {
                  setState(() {
                    isSelected = [false, false, true, false, false];
                  });
                },
                color: isSelected[2] ? AppColors.button : AppColors.background,
                height: 170,
                title: 'Moderately Active 🏃',
                text:
                    'for people who participate in moderate \nphysical activities regularly, such as \ncycling, or playing sports ex:Personal \nTrainer, Waiter University student',
              ),
              const SizedBox(
                height: 15,
              ),
              Countainer_activites(
                onTap: () {
                  setState(() {
                    isSelected = [false, false, false, true, false];
                  });
                },
                color: isSelected[3] ? AppColors.button : AppColors.background,
                height: 200,
                title: 'Very Active 🐎',
                text:
                    'for people who engage in intense physical\nactivities on a daily basis, such as high-\nintensity workouts, competitive sports, or\nphysically demanding occuptions\nex:Athlete, Constrution,Fitness\nInstractor',
              ),
              const SizedBox(
                height: 15,
              ),
              Countainer_activites(
                onTap: () {
                  setState(() {
                    isSelected = [false, false, false, false, true];
                  });
                },
                color: isSelected[4] ? AppColors.button : AppColors.background,
                height: 230,
                title: 'Extra active 🏋️',
                text:
                    'for people have an exceptionally active\nlifestyle, involving vigorous physical\nactivities for extended periods, such as\nprofessional athletes or indivduals with\nphyssioal athletes or individuals with\nphysically demanding jobs ex:policeman ,\nfirefighter',
              ),
              const SizedBox(
                height: 20,
              ),
              Custom_Button(
                  text: 'Continue',
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const UserDitails(),
                    ));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
