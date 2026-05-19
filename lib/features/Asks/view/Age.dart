import 'package:diety/Core/model/UserInfoProvider.dart';
import 'package:diety/Core/utils/Colors.dart';
import 'package:diety/Core/widget/Custom_Button.dart';
import 'package:diety/features/Asks/cubit/user_info_cubit.dart';
import 'package:diety/features/Asks/view/Activates.dart';
import 'package:diety/features/Asks/view/Weight.dart';
import 'package:diety/features/Asks/widget/textFormfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class Age extends StatefulWidget {
  const Age({super.key});

  @override
  State<Age> createState() => _AgeState();
}

class _AgeState extends State<Age> {
  final TextEditingController ageController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserInfoCubit>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const Weight(),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.text,
            size: 30,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "What's your age ?",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(
                  width: double.infinity,
                  height: 290,
                  child: Image(image: AssetImage('assets/Images/age.jpg')),
                ),
                textFormField(
                  onChanged: (value) {
                    if (value != null && value.isNotEmpty) {
                      cubit.selectAge(double.tryParse(value) ?? 25.0);
                    }
                    return null;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Your Age';
                    } else {
                      final parsedAge = double.tryParse(value);
                      if (parsedAge == null || parsedAge > 70) {
                        return 'Please Enter A Valid Age';
                      } else if (parsedAge <= 18) {
                        return 'You should be at least 18 years old';
                      }
                    }
                    return null;
                  },
                  hintText: 'Enter Your age',
                  mycontroller: ageController,
                ),
                const SizedBox(
                  height: 30,
                ),
                Custom_Button(
                  text: 'Continue',
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      final parsedAge =
                          double.tryParse(ageController.text) ?? 25.0;
                      cubit.selectAge(parsedAge);
                      await cubit.saveAge();

                      // Update legacy provider
                      final userInfoProvider =
                          Provider.of<UserInfoProvider>(context, listen: false);
                      userInfoProvider.updateUserInfo(age: parsedAge);

                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const Activates(),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
