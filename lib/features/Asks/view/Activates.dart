import 'package:diety/Core/model/UserInfoProvider.dart';
import 'package:diety/Core/utils/Colors.dart';
import 'package:diety/Core/widget/Container_Activites.dart';
import 'package:diety/Core/widget/Custom_Button.dart';
import 'package:diety/features/Asks/cubit/user_info_cubit.dart';
import 'package:diety/features/Asks/cubit/user_info_state.dart';
import 'package:diety/features/Asks/model/activity_option.dart';
import 'package:diety/features/Asks/view/Age.dart';
import 'package:diety/features/User_Detials/view/UserDitails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class Activates extends StatelessWidget {
  const Activates({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserInfoCubit, UserInfoState>(
      builder: (context, state) {
        final cubit = context.read<UserInfoCubit>();
        final String currentActivity = cubit.activity;
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const Age(),
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
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...activityOptions.map((option) {
                    final isSelected = currentActivity == option.key;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Countainer_activites(
                        onTap: () {
                          cubit.selectActivity(option.key);
                        },
                        color: isSelected
                            ? AppColors.button
                            : AppColors.background,
                        height: option.height,
                        title: option.title,
                        text: option.description,
                      ),
                    );
                  }),
                  const SizedBox(height: 5),
                  Custom_Button(
                    text: 'Body Details',
                    onPressed: () async {
                      await cubit.saveActivity();
                      if (!context.mounted) return;

                      // Update legacy provider
                      final userInfoProvider =
                          Provider.of<UserInfoProvider>(context, listen: false);
                      userInfoProvider.updateUserInfo(
                        activity: cubit.activity,
                      );

                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const UserDitails(),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
