import 'package:diety/Core/model/UserInfoProvider.dart';
import 'package:diety/Core/utils/Colors.dart';
import 'package:diety/Core/widget/Custom_Button.dart';
import 'package:diety/features/Asks/cubit/user_info_cubit.dart';
import 'package:diety/features/Asks/view/Age.dart';
import 'package:diety/features/Asks/view/Height.dart';
import 'package:diety/features/Asks/widget/textFormfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Weight extends StatefulWidget {
  const Weight({super.key});

  @override
  State<Weight> createState() => _WeightState();
}

class _WeightState extends State<Weight> {
  final TextEditingController weightController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    weightController.dispose();
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
                builder: (context) => const Height(),
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
                  "What's your Weight ?",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(
                  width: double.infinity,
                  height: 290,
                  child: Image(image: AssetImage('assets/Images/weight.jpg')),
                ),
                textFormField(
                  onChanged: (value) {
                    if (value != null && value.isNotEmpty) {
                      cubit.selectWeight(double.tryParse(value) ?? 70.0);
                    }
                    return null;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Your Weight';
                    } else {
                      final w = double.tryParse(value);
                      if (w == null || w > 400 || w <= 20) {
                        return 'Please Enter A Valid Weight';
                      }
                    }
                    return null;
                  },
                  hintText: 'Enter your Weight',
                  mycontroller: weightController,
                ),
                const SizedBox(
                  height: 30,
                ),
                Custom_Button(
                  text: 'Continue',
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      final parsedWeight =
                          double.tryParse(weightController.text) ?? 70.0;
                      cubit.selectWeight(parsedWeight);
                      await cubit.saveWeight();
                      if (!context.mounted) return;

                      // Update legacy provider
                      final userInfoProvider =
                          Provider.of<UserInfoProvider>(context, listen: false);
                      userInfoProvider.updateUserInfo(weight: parsedWeight);

                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const Age(),
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
