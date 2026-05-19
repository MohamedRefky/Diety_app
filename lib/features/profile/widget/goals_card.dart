import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../Core/utils/Colors.dart';
import '../widget/styles.dart';

class GoalsCard extends StatelessWidget {
  final Map<String, dynamic> userData;

  const GoalsCard({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dailyCalories = userData['dailyCalories']?.toString() ?? '';
    final caloriesRemaining = userData['Calories Remining']?.toString() ?? '';
    final idealWeight = userData['idealWeight']?.toString() ?? '';
    final goalWeight = userData['Goal Weight']?.toString() ?? '';

    return Container(
      width: double.infinity,
      color: const Color(0xff151724),
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Goals',
            style: getTitleStyle(fontSize: 20),
          ),
          const Gap(15),
          Text(
            'Daily Calories',
            style: getbodyStyle(fontSize: 18),
          ),
          Text(
            '$dailyCalories Cal',
            style: getsmallStyle(color: AppColors.grey),
          ),
          const Gap(15),
          Text(
            'Calories Remaining',
            style: getbodyStyle(fontSize: 18),
          ),
          Text(
            '$caloriesRemaining Cal',
            style: getsmallStyle(color: AppColors.grey),
          ),
          const Gap(15),
          Text(
            'Ideal Weight',
            style: getbodyStyle(fontSize: 18),
          ),
          Text(
            '$idealWeight kg',
            style: getsmallStyle(color: AppColors.grey),
          ),
          const Gap(15),
          Text(
            'Weekly Goal',
            style: getbodyStyle(fontSize: 18),
          ),
          Text(
            goalWeight,
            style: getsmallStyle(color: AppColors.grey),
          ),
        ],
      ),
    );
  }
}
