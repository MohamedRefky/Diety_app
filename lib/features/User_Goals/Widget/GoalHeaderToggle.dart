import 'package:diety/Core/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class GoalHeaderToggle extends StatelessWidget {
  const GoalHeaderToggle({
    super.key,
    required this.isLoseMode,
    required this.onToggle,
  });

  final bool isLoseMode;
  final ValueChanged<bool> onToggle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Determine your Goal',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColors.white,
            fontSize: 30,
          ),
        ),
        const Gap(30),
        Container(
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.background,
            border: Border.all(color: AppColors.button, width: 1.5),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => onToggle(true),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isLoseMode ? AppColors.button : Colors.transparent,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Text(
                      'Lose Weight',
                      style: TextStyle(
                        color: AppColors.text,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => onToggle(false),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color:
                          !isLoseMode ? AppColors.button : Colors.transparent,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Text(
                      'Gain Weight',
                      style: TextStyle(
                        color: AppColors.text,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
