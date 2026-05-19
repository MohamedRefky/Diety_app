import 'package:diety/Core/utils/Colors.dart';
import 'package:diety/Core/widget/Custom_Button.dart';
import 'package:diety/features/User_Goals/Widget/Container_Goal.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class GoalPaceSelector extends StatelessWidget {
  const GoalPaceSelector({
    super.key,
    required this.options,
    required this.selectedIndex,
    required this.onSelect,
    required this.onContinue,
  });

  final List<String> options;
  final int selectedIndex;
  final ValueChanged<int> onSelect;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'What is your weekly goal?',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: AppColors.white,
            fontSize: 20,
          ),
        ),
        const Gap(20),
        Column(
          children: options.asMap().entries.map((entry) {
            final index = entry.key;
            final text = entry.value;
            final isSelected = selectedIndex == index;

            return Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Container_Goal(
                onTap: () => onSelect(index),
                color: isSelected ? AppColors.button : AppColors.background,
                text: text,
              ),
            );
          }).toList(),
        ),
        const Gap(30),
        Custom_Button(
          width: double.infinity,
          text: 'Continue',
          onPressed: onContinue,
        ),
      ],
    );
  }
}
