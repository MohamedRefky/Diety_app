// ignore_for_file: library_private_types_in_public_api

import 'package:diety/Core/utils/Colors.dart';
import 'package:diety/features/Search_Food/cubit/search_food_cubit.dart';
import 'package:diety/features/Search_Food/cubit/search_food_state.dart';
import 'package:diety/features/Search_Food/widget/calorie_calculator_card.dart';
import 'package:diety/features/Search_Food/widget/food_suggestions_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CustomSearchFood extends StatefulWidget {
  const CustomSearchFood({Key? key}) : super(key: key);

  @override
  _CustomSearchFoodState createState() => _CustomSearchFoodState();
}

class _CustomSearchFoodState extends State<CustomSearchFood> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _gramsController = TextEditingController(text: '100');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchTextChanged);
    _gramsController.addListener(_onGramsChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _gramsController.dispose();
    super.dispose();
  }

  void _onSearchTextChanged() {
    context.read<SearchFoodCubit>().filterValues(_searchController.text);
  }

  void _onGramsChanged() {
    final double grams = double.tryParse(_gramsController.text) ?? 0.0;
    context.read<SearchFoodCubit>().updateGrams(grams);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchFoodCubit, SearchFoodState>(
      listener: (context, state) {
        if (state.status == SearchFoodStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.successMessage),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
          // Block listener calls clear, temporarily remove listeners to avoid dispatching empty search queries
          _searchController.removeListener(_onSearchTextChanged);
          _gramsController.removeListener(_onGramsChanged);
          
          _searchController.clear();
          _gramsController.text = '100';
          
          _searchController.addListener(_onSearchTextChanged);
          _gramsController.addListener(_onGramsChanged);
        } else if (state.status == SearchFoodStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state.status == SearchFoodStatus.loading;

        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Sleek Search Input
              TextFormField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                cursorColor: AppColors.button,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter food or drink name';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Search foods (e.g. apple, egg, milk)',
                  hintStyle: TextStyle(color: Colors.white.withAlpha(128), fontSize: 16),
                  prefixIcon: Icon(Icons.search_rounded, color: AppColors.button),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded, color: Colors.white60),
                          onPressed: () {
                            _searchController.clear();
                            context.read<SearchFoodCubit>().resetSearch();
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: const Color(0xff1b222e),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.white.withAlpha(13)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: AppColors.button.withAlpha(128), width: 1.5),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
                  ),
                ),
              ),
              const Gap(16),

              // 2. Loading Indicator or Suggestions
              if (isLoading)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(child: CircularProgressIndicator(color: Colors.greenAccent)),
                ),

              if (state.suggestions.isNotEmpty && state.selectedFoodName.isEmpty)
                FoodSuggestionsList(
                  suggestedValues: state.suggestions,
                  onSuggestionTapped: (suggestion) {
                    _searchController.text = suggestion;
                    context.read<SearchFoodCubit>().selectAndSearchFood(suggestion);
                  },
                ),

              // 3. Premium Interactive Food Calorie Calculator Card
              if (state.selectedFoodName.isNotEmpty)
                CalorieCalculatorCard(
                  selectedFoodName: state.selectedFoodName,
                  baseCaloriesPer100g: state.baseCaloriesPer100g,
                  calculatedCalories: state.calculatedCalories,
                  gramsController: _gramsController,
                  onAddFoodLogged: () {
                    if (formKey.currentState!.validate()) {
                      context.read<SearchFoodCubit>().addFoodLogged();
                    }
                  },
                  onQuickGramsSelected: (amount) {
                    _gramsController.text = amount.toInt().toString();
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
