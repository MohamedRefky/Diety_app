import 'package:diety/Core/utils/Colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomeCaloriesIndicator extends StatelessWidget {
  const HomeCaloriesIndicator({
    super.key,
    required this.caloriesRemaining,
    required this.caloriesConsumed,
    required this.remainingCal,
    required this.percent,
  });

  final String caloriesRemaining;
  final String caloriesConsumed;
  final double remainingCal;
  final double percent;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.button.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Calories ',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          Row(
            children: [
              Text(
                'Remining = Goal - Food ',
                style: TextStyle(
                  color: AppColors.grey,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const Gap(10),
          Row(
            children: [
              CircularPercentIndicator(
                animationDuration: 1000,
                animation: true,
                radius: 60,
                lineWidth: 12,
                percent: percent,
                progressColor: Colors.blue,
                backgroundColor: AppColors.background,
                circularStrokeCap: CircularStrokeCap.round,
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      remainingCal.toStringAsFixed(1),
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    Text(
                      'Remining ',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
              ),
              const Gap(70),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    FontAwesomeIcons.bolt,
                    color: Colors.yellow,
                  ),
                  Gap(20),
                  Icon(
                    FontAwesomeIcons.utensils,
                    color: Colors.blueAccent,
                  ),
                ],
              ),
              const Gap(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Base Goal',
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.white,
                    ),
                  ),
                  Text(
                    caloriesRemaining,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                  const Gap(5),
                  Text(
                    'Food',
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.white,
                    ),
                  ),
                  Text(
                    caloriesConsumed,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
