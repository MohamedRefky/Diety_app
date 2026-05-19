import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../Core/utils/Colors.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import '../view/gemini.dart';
import '../widget/styles.dart';
import '../widget/profile_header.dart';
import '../widget/personal_data_card.dart';
import '../widget/goals_card.dart';
import '../widget/health_data_card.dart';
import '../../../Core/widget/challenges_carousel.dart';
import '../widget/profile_actions.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..fetchUserData(),
      child: const ProfileView(),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff030b18),
        appBar: AppBar(
          backgroundColor: const Color(0xff151724),
          title: Text(
            'Profile',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
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
                    backgroundImage: const AssetImage('assets/Images/gemini logo.png'),
                  ),
                ],
              ),
            )
          ],
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileInitial || state is ProfileLoading || state is ProfileActionLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }

            if (state is ProfileError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, color: Colors.redAccent, size: 48),
                    const SizedBox(height: 16),
                    Text(
                      'Error Loading Profile',
                      style: getTitleStyle(),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        state.message,
                        style: getsmallStyle(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => context.read<ProfileCubit>().fetchUserData(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (state is ProfileLoaded) {
              final userData = state.userData;
              final profileUrl = state.profileUrl;

              return Column(
                children: [
                  ProfileHeader(userData: userData, profileUrl: profileUrl),
                  const Gap(8),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          PersonalDataCard(userData: userData),
                          const Gap(8),
                          GoalsCard(userData: userData),
                          const Gap(8),
                          HealthDataCard(userData: userData),
                          const Gap(8),
                          ChallengesCarousel(),
                          const Gap(8),
                          const ProfileActions(),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
