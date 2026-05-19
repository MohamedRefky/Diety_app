import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../Core/utils/Colors.dart';
import '../widget/styles.dart';

class HealthDataCard extends StatelessWidget {
  final Map<String, dynamic> userData;

  const HealthDataCard({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bmi = userData['BMI']?.toString() ?? '';
    final waterIntake = userData['waterIntake']?.toString() ?? '';
    final sleepDuration = userData['sleepDuration']?.toString() ?? '';

    return Container(
      width: double.infinity,
      color: const Color(0xff151724),
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'More Important Data',
            style: getTitleStyle(fontSize: 20),
          ),
          const Gap(15),
          Text(
            'Your BMI',
            style: getbodyStyle(fontSize: 18),
          ),
          Text(
            bmi,
            style: getsmallStyle(color: AppColors.grey),
          ),
          const Gap(15),
          Text(
            'Water Intake',
            style: getbodyStyle(fontSize: 18),
          ),
          Text(
            '$waterIntake per day',
            style: getsmallStyle(color: AppColors.grey),
          ),
          const Gap(15),
          Text(
            'Sleep Duration',
            style: getbodyStyle(fontSize: 18),
          ),
          Text(
            '$sleepDuration Hours',
            style: getsmallStyle(color: AppColors.grey),
          ),
        ],
      ),
    );
  }
}
