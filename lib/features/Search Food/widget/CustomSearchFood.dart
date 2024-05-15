// ignore_for_file: avoid_types_as_parameter_names, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diety/Core/utils/Colors.dart';
import 'package:diety/Core/widget/Custom_Button.dart';
import 'package:diety/features/Asks/view/Gender.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CustomSearchFood extends StatefulWidget {
  const CustomSearchFood({Key? key}) : super(key: key);

  @override
  _CustomSearchFoodState createState() => _CustomSearchFoodState();
}

class _CustomSearchFoodState extends State<CustomSearchFood> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _gramsController =
      TextEditingController(); // Add this line to initialize _gramsController
  String _searchResult = '';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<String> _suggestedValues = [];
  bool _isKeyboardVisible = false;
  String CaloriesConsumed = '';
  String? storedValue;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchTextChanged);
    _onAddPressed();
  }

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    _searchController.dispose();
    _gramsController.dispose(); // Add this line to dispose _gramsController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.background,
      body: Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(
              height: _searchController.text.isEmpty ? 50.0 : 70.0,
              width: double.infinity,
              child: TextFormField(
                onChanged: (value) {
                  _filterValues(value);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your food ';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                cursorColor: AppColors.button,
                style: const TextStyle(color: Colors.white, fontSize: 18),
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Enter your food or drink',
                  hintStyle: const TextStyle(color: Colors.white, fontSize: 18),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: AppColors.button,
                      size: 30,
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        _search();
                      }
                    },
                  ),
                  border: const UnderlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: AppColors.button),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: AppColors.button),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                ),
                //focusNode: FocusNode()..addListener(_onFocusChange),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              height: 60,
              width: double.infinity,
              color: AppColors.background,
              child: Text(
                _searchResult,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Visibility(
              visible: _searchResult.isNotEmpty,
              child: TextButton(
                onPressed: () => _showGramsBottomSheet(context),
                child: const Text(
                  'Add Grams',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _suggestedValues.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _suggestedValues[index],
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    onTap: () {
                      _searchController.text = _suggestedValues[index];
                      _search();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showGramsBottomSheet(BuildContext context) {
    showMaterialModalBottomSheet(
      expand: false,
      context: context,
      builder: (context) => Container(
        color: const Color(0xff202835),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Enter Grams',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Gap(20),
            TextFormField(
              style: const TextStyle(color: Colors.white),
              controller: _gramsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Grams',
                labelStyle: const TextStyle(color: Colors.white),
                hintText: '100 gram',
                hintStyle: const TextStyle(color: Colors.white),
                border: const UnderlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: AppColors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: AppColors.grey),
                ),
              ),
            ),
            const Gap(20),
            Text(
              _searchResult,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(20),
            Custom_Button(
              color: AppColors.grey.withAlpha(100),
              onPressed: () {
                _onAddPressed();
                test();
                _search();
                CaloriesConsumed = storedValue.toString();
                print("Searched Value: $CaloriesConsumed");
                Navigator.of(context).pop();
              },
              text: 'Add',
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> selectedFoods = [];

  Future<void> _search() async {
    String food = _searchController.text;
    double grams = double.tryParse(_gramsController.text) ??
        100; // Default to 100 grams if invalid input

    try {
      // Call the searchByKey function to search for the value in the Firebase Realtime Database
      String? value = await searchByKey(food);

      // Update state with the search result
      setState(() {
        if (value != null) {
          double calories = calculateCalories(value, grams);
          _searchResult = '$grams grams of $food is: $calories calories';
          selectedFoods.add({"food": food, "calories": calories});
        } else {
          _searchResult = 'Value not found.';
        }
      });
    } catch (error) {
      // Handle any errors that occur during data retrieval
      print('Error retrieving data: $error');
      setState(() {
        _searchResult = 'Error retrieving data. Please try again later.';
      });
    }
  }

  double calculateCalories(String value, double grams) {
    // Parse the value retrieved from the database and calculate calories based on grams
    double parsedValue =
        double.tryParse(value.replaceAll('cal', '').trim()) ?? 0;
    return parsedValue * (grams / 100);
  }

  Future<String?> searchByKey(String key) async {
    final DatabaseReference ref = FirebaseDatabase.instance.ref();

    try {
      // Use a DatabaseEvent instead of a DataSnapshot
      DatabaseEvent event = await ref.once();

      // Access the DataSnapshot from the DatabaseEvent
      DataSnapshot snapshot = event.snapshot;

      if (snapshot.value != null) {
        // Cast snapshot value to Map<dynamic, dynamic>
        Map<dynamic, dynamic>? values =
            snapshot.value as Map<dynamic, dynamic>?;

        if (values != null) {
          // Iterate through all child nodes
          for (var entry in values.entries) {
            // Get the key and value
            String entryKey = entry.key.toString();
            String entryValue = entry.value.toString();

            // Check if the key matches the search term (case-insensitive)
            if (entryKey.substring(0, 1).toUpperCase() ==
                    key.substring(0, 1).toUpperCase() &&
                entryKey.substring(1) == key.substring(1)) {
              // Return the value if the key matches
              return entryValue;
            }
          }
        } else {
          print('Snapshot value is not a Map');
        }
      } else {
        // Handle the case when snapshot value is null
        print('Snapshot value is null');
      }
    } catch (error) {
      // Handle errors
      print('Error searching by key: $error');
    }

    return null; // Return null if key is not found or if an error occurs
  }

  void _filterValues(String query) async {
    final DatabaseReference ref = FirebaseDatabase.instance.ref();

    try {
      DatabaseEvent event = await ref.once();
      DataSnapshot snapshot = event.snapshot;

      if (snapshot.value != null) {
        Map<dynamic, dynamic>? values =
            snapshot.value as Map<dynamic, dynamic>?;
        if (values != null) {
          List<String> suggestions = [];
          for (var entry in values.entries) {
            String entryKey = entry.key.toString();
            if (entryKey.toLowerCase().contains(query.toLowerCase())) {
              suggestions.add(entryKey);
            }
          }
          setState(() {
            _suggestedValues = suggestions;
          });
        } else {
          print('Snapshot value is not a Map');
        }
      } else {
        print('Snapshot value is null');
      }
    } catch (error) {
      print('Error filtering values: $error');
    }
  }

  void _onSearchTextChanged() {
    _filterValues(_searchController.text);
  }

  void _onFocusChange() {
    setState(() {
      _isKeyboardVisible = !_isKeyboardVisible;
      // Clear suggestions when keyboard is visible
      if (_isKeyboardVisible) {
        _suggestedValues.clear();
      }
    });
  }

  void _onAddPressed() async {
    // Retrieve the grams entered by the user
    double grams = double.tryParse(_gramsController.text) ??
        100.0; // Default to 100 grams if parsing fails

    // Calculate total calories of selected foods based on the grams entered by the user
    double totalCalories = selectedFoods.fold(0, (sum, food) {
      // Access the calories directly from the food map
      double calories =
          food['calories']; // Assuming 'calories' is a double in the food map
      // Calculate calories based on grams entered by the user
      double caloriesForGrams = (calories / 100) * grams;
      // Add the calculated calories to the sum
      return sum + caloriesForGrams;
    });

    // Update CaloriesConsumed
    setState(() {
      CaloriesConsumed = totalCalories.toString();
    });

    // Update Firestore document with the new total
    try {
      DocumentSnapshot snapshot = await users.doc(uid).get();
      Map<String, dynamic> existingData =
          (snapshot.data() as Map<String, dynamic>);
      double existingCalories =
          (existingData['CaloriesConsumed'] ?? 0).toDouble();
      double newCalories = existingCalories + totalCalories;

      Map<String, dynamic> newData = {
        ...existingData,
        "CaloriesConsumed": newCalories,
      };
      await users.doc(uid).set(newData, SetOptions(merge: true));
      print('User updated in Firestore');
    } catch (error) {
      print('Failed to update user: $error');
    }
  }

  Future<void> test() async {
    try {
      if (_searchResult.isNotEmpty) {
        // Extract the calories value from _searchResult
        RegExp regex = RegExp(r'[0-9.]+');
        Iterable<Match> matches = regex.allMatches(_searchResult);
        if (matches.isNotEmpty) {
          double parsedCalories = double.parse(matches.first.group(0)!);
          storedValue =
              '$parsedCalories cal'; // Update storedValue with calories
          print('Stored Value: $storedValue');
        } else {
          print('Calories not found in _searchResult');
        }
      } else {
        print('Search result is empty');
      }
    } catch (error) {
      print('Error storing value: $error');
    }
  }
}
