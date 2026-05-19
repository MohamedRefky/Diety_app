import 'package:diety/Core/model/UserInfoProvider.dart';
import 'package:diety/Core/utils/Colors.dart';
import 'package:diety/Core/widget/Custom_Button.dart';
import 'package:diety/features/Asks/cubit/user_info_cubit.dart';
import 'package:diety/features/Asks/cubit/user_info_state.dart';
import 'package:diety/features/Asks/view/Height.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Gender extends StatelessWidget {
  const Gender({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserInfoCubit, UserInfoState>(
      builder: (context, state) {
        final cubit = context.read<UserInfoCubit>();
        final bool isMale = cubit.gender == 'Male';

        return Scaffold(
          backgroundColor: AppColors.background,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Choose your gender.. ",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(
                      height: 280,
                      width: double.infinity,
                      child: Lottie.asset('assets/Images/Gender.json'),
                    ),
                    SizedBox(
                      width: 320,
                      height: 80,
                      child: ElevatedButton(
                        onPressed: () {
                          cubit.selectGender('Male');
                        },
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(color: AppColors.button, width: 2),
                          backgroundColor:
                              isMale ? AppColors.button : AppColors.background,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Male',
                          style: TextStyle(
                            color: AppColors.text,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const Gap(15),
                    SizedBox(
                      width: 320,
                      height: 80,
                      child: ElevatedButton(
                        onPressed: () {
                          cubit.selectGender('Female');
                        },
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(color: AppColors.button, width: 2),
                          backgroundColor:
                              !isMale ? AppColors.button : AppColors.background,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Female',
                          style: TextStyle(
                            color: AppColors.text,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const Gap(30),
                    Custom_Button(
                      text: 'Continue',
                      onPressed: () async {
                        await cubit.saveGender();

                        final userInfoProvider = Provider.of<UserInfoProvider>(
                            context,
                            listen: false);
                        userInfoProvider.updateUserInfo(gender: cubit.gender);

                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const Height(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
