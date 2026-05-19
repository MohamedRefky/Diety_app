import 'package:diety/Core/model/UserInfoProvider.dart';
import 'package:diety/Core/utils/Colors.dart';
import 'package:diety/Core/widget/Custom_Button.dart';
import 'package:diety/features/Asks/cubit/user_info_cubit.dart';
import 'package:diety/features/Asks/view/Gender.dart';
import 'package:diety/features/Asks/view/Weight.dart';
import 'package:diety/features/Asks/widget/textFormfield.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class Height extends StatefulWidget {
  const Height({super.key});

  @override
  State<Height> createState() => _HeightState();
}

class _HeightState extends State<Height> {
  final TextEditingController _heightController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _heightController.dispose();
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
                builder: (context) => const Gender(),
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
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "What's your height ?",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                const Gap(10),
                const SizedBox(
                  width: double.infinity,
                  height: 290,
                  child: Image(image: AssetImage('assets/Images/height2.jpg')),
                ),
                const Gap(30),
                textFormField(
                  onChanged: (value) {
                    if (value != null && value.isNotEmpty) {
                      cubit.selectHeight(double.tryParse(value) ?? 170.0);
                    }
                    return null;
                  },
                  hintText: 'Enter your Height',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Your Height';
                    } else {
                      final h = double.tryParse(value);
                      if (h == null || h < 90 || h > 210) {
                        return 'Please Enter A Valid Height';
                      }
                    }
                    return null;
                  },
                  mycontroller: _heightController,
                ),
                const SizedBox(
                  height: 30,
                ),
                Custom_Button(
                  text: 'Continue',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final parsedHeight =
                          double.tryParse(_heightController.text) ?? 170.0;
                      cubit.selectHeight(parsedHeight);
                      await cubit.saveHeight();
                      if (!context.mounted) return;

                      // Update legacy provider
                      final userInfoProvider =
                          Provider.of<UserInfoProvider>(context, listen: false);
                      userInfoProvider.updateUserInfo(height: parsedHeight);

                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const Weight(),
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
