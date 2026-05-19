import 'package:diety/Core/utils/Colors.dart';
import 'package:flutter/material.dart';

class FoodSuggestionsList extends StatelessWidget {
  final List<String> suggestedValues;
  final Function(String) onSuggestionTapped;

  const FoodSuggestionsList({
    super.key,
    required this.suggestedValues,
    required this.onSuggestionTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff1b222e),
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: suggestedValues.length,
          separatorBuilder: (context, index) => Divider(
            color: Colors.white.withAlpha(13),
            height: 1,
          ),
          itemBuilder: (context, index) {
            final suggestion = suggestedValues[index];
            return ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.button.withAlpha(25),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.restaurant_menu_rounded, color: AppColors.button, size: 18),
              ),
              title: Text(
                suggestion,
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white30, size: 14),
              onTap: () => onSuggestionTapped(suggestion),
            );
          },
        ),
      ),
    );
  }
}
