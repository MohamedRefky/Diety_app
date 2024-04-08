import 'package:diety/Core/utils/Colors.dart';
import 'package:diety/Core/widget/Custom_Button.dart';
import 'package:diety/features/Asks/Activates.dart';
import 'package:diety/features/Asks/Weight.dart';
import 'package:diety/features/Asks/cubit/cubit.dart';
import 'package:diety/features/Asks/cubit/stateManagemen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: unused_import
import 'package:gap/gap.dart';

class Age extends StatefulWidget {
  const Age({super.key});

  @override
  State<Age> createState() => _AgeState();
}

class _AgeState extends State<Age> {
  TextEditingController age = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //AgeStateCubit ageStateCubit = AgeStateCubit(age: 0.0);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AgeStateCubit, AgeState>(
      listener: (context, state) {
        //ageStateCubit.age = double.parse(age.text);
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              backgroundColor: AppColors.background,
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const Weight(),
                    ));
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: AppColors.text,
                    size: 30,
                  )),
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
                            child: Image(image: AssetImage('Images/age.jpg'))),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'PLease Enter Your Age';
                            } else {
                              final age = double.tryParse(value);
                              if (age == null || age > 70) {
                                return 'Please Enter A Valid Age';
                              } else if (age <= 18) {
                                return 'You should be atleast 18 years old';
                              }
                            }
                            return null;
                          },
                          controller: age,
                          onTap: () {},
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: AppColors.text),
                          decoration: InputDecoration(
                              hintText: 'Enter Your age',
                              hintStyle: TextStyle(
                                  fontSize: 20, color: AppColors.text),
                              border: const UnderlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: AppColors.button)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: AppColors.button)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      const BorderSide(color: Colors.red)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      const BorderSide(color: Colors.red))),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Custom_Button(
                            text: 'Continue',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) => const Activates(),
                                ));
                              }
                            })
                      ]),
                ),
              ),
            ));
      },
    );
  }
}
