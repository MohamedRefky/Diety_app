import 'package:diety/Core/utils/Colors.dart';
import 'package:diety/Core/widget/Custom_Button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CalorieCalculatorCard extends StatelessWidget {
  final String selectedFoodName;
  final double baseCaloriesPer100g;
  final double calculatedCalories;
  final TextEditingController gramsController;
  final VoidCallback onAddFoodLogged;
  final Function(double amount) onQuickGramsSelected;

  const CalorieCalculatorCard({
    super.key,
    required this.selectedFoodName,
    required this.baseCaloriesPer100g,
    required this.calculatedCalories,
    required this.gramsController,
    required this.onAddFoodLogged,
    required this.onQuickGramsSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff1b222e), Color(0xff131822)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.button.withAlpha(40)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(51),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedFoodName.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      '$baseCaloriesPer100g cal per 100g',
                      style: TextStyle(
                        color: Colors.white.withAlpha(128),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.greenAccent.withAlpha(25),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$calculatedCalories kcal',
                  style: const TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const Gap(24),
          const Text(
            'Specify Portion size (Grams):',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Gap(10),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: gramsController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black.withAlpha(51),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    suffixText: 'grams',
                    suffixStyle: const TextStyle(color: Colors.white70, fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const Gap(12),
              _buildQuickGramsPill(50),
              const Gap(6),
              _buildQuickGramsPill(100),
              const Gap(6),
              _buildQuickGramsPill(200),
            ],
          ),
          const Gap(24),
          Custom_Button(
            color: AppColors.button,
            onPressed: onAddFoodLogged,
            text: 'Add to Daily Log',
          ),
        ],
      ),
    );
  }

  Widget _buildQuickGramsPill(double amount) {
    final isSelected = gramsController.text == amount.toInt().toString();
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => onQuickGramsSelected(amount),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.button.withAlpha(51) : Colors.white.withAlpha(10),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? AppColors.button : Colors.white.withAlpha(13),
          ),
        ),
        child: Text(
          '${amount.toInt()}g',
          style: TextStyle(
            color: isSelected ? AppColors.button : Colors.white70,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
