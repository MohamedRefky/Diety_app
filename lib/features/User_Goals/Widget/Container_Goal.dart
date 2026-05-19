import 'package:diety/Core/utils/Colors.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class Container_Goal extends StatelessWidget {
  const Container_Goal({
    super.key,
    required this.text,
    required this.onTap,
    required this.color,
  });

  final String text;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    // Determine if this goal is selected
    final bool isSelected = color == AppColors.button;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          decoration: BoxDecoration(
            color: color,
            border: Border.all(
              color: isSelected
                  ? AppColors.button
                  : AppColors.button.withValues(alpha: 0.3),
              width: isSelected ? 1.8 : 1.0,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.button.withValues(alpha: 0.25),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    )
                  ]
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.w500,
                      color: isSelected ? Colors.white : AppColors.text,
                      height: 1.3,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? Colors.white
                          : AppColors.button.withValues(alpha: 0.5),
                      width: 2,
                    ),
                    color: isSelected ? Colors.white : Colors.transparent,
                  ),
                  child: isSelected
                      ? Icon(
                          Icons.check,
                          size: 14,
                          color: AppColors.button,
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
