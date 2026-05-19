import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../Core/utils/Colors.dart';

class DayDetailsHeader extends StatelessWidget {
  final String dayName;

  const DayDetailsHeader({Key? key, required this.dayName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              dayName,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.button.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.button.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.flash_on, color: AppColors.button, size: 16),
                  const Gap(4),
                  Text(
                    'Today\'s Goal',
                    style: TextStyle(
                      color: AppColors.button,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Gap(8),
        Text(
          'Follow these exercises designed specifically for your physical condition.',
          style: TextStyle(
            color: AppColors.grey,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
