// ignore_for_file: depend_on_referenced_packages
import 'package:diety/Core/utils/Colors.dart';
import 'package:diety/features/Admin/view/AdminHome.dart';
import 'package:diety/features/Home/widget/HomeCaloriesIndicator.dart';
import 'package:diety/features/Home/widget/HomeChallenges.dart';
import 'package:diety/features/Home/widget/HomeMealSlots.dart';
import 'package:diety/features/Home/widget/HomeSummary.dart';
import 'package:diety/features/Home/widget/watertracker.dart';
import 'package:diety/features/Home/cubit/home_cubit.dart';
import 'package:diety/features/Home/cubit/home_state.dart';
import 'package:diety/features/User_Detials/view/UserDitails.dart';
import 'package:diety/features/profile/view/gemini.dart';
import 'package:diety/features/profile/widget/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class Home extends StatelessWidget {
  final NotificationResponse? response;
  static const route = "/Homee";

  const Home({super.key, this.response});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit()..init(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.status == HomeStatus.loading ||
            state.status == HomeStatus.initial) {
          return Scaffold(
            backgroundColor: AppColors.background,
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final cubit = context.read<HomeCubit>();

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            actions: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const GeminiAi(),
                  ));
                },
                child: Row(
                  children: [
                    Text(
                      'AI Coach',
                      style: getbodyStyle(fontSize: 18),
                    ),
                    const Gap(5),
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: AppColors.white,
                      backgroundImage:
                          const AssetImage('assets/Images/gemini logo.png'),
                    ),
                  ],
                ),
              ),
            ],
            leadingWidth: 190,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const UserDitails(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.white,
                      size: 25,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 7)),
                      ).then((value) {
                        if (value != null) {
                          cubit.changeSelectedDate(value);
                        }
                      });
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Today',
                          style: TextStyle(
                            color: AppColors.white,
                          ),
                        ),
                        Text(
                          state.selectedDate.isNotEmpty
                              ? state.selectedDate
                              : DateFormat.yMEd().format(DateTime.now()),
                          style: TextStyle(color: AppColors.white),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: RefreshIndicator(
              onRefresh: () => cubit.fetchUserData(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    HomeCaloriesIndicator(
                      caloriesRemaining: state.caloriesRemaining,
                      caloriesConsumed: state.caloriesConsumed,
                      remainingCal: state.remainingCal,
                      percent: state.percent,
                    ),
                    const Gap(10),
                    const HomeMealSlots(),
                    const Gap(10),
                    HomeSummary(
                      caloriesRemaining: state.caloriesRemaining,
                      caloriesConsumed: state.caloriesConsumed,
                      percent: state.percent,
                    ),
                    const Gap(10),
                    const WaterTrackerWidget(),
                    const Gap(10),
                    const HomeChallenges(),
                    const Gap(8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const Admin_Home(),
                                  ),
                                );
                              },
                              icon: Icon(
                                CupertinoIcons.chart_bar_alt_fill,
                                color: AppColors.button,
                                size: 50,
                              ),
                            ),
                            Text(
                              "Album",
                              style: TextStyle(color: AppColors.button),
                            )
                          ],
                        ),
                      ],
                    )
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
