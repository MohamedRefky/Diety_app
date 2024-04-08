import 'package:diety/Core/utils/Colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CustomSearchFood extends StatefulWidget {
  const CustomSearchFood({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomSearchFoodState createState() => _CustomSearchFoodState();
}

class _CustomSearchFoodState extends State<CustomSearchFood> {
  final TextEditingController _searchController = TextEditingController();
  String _searchResult = '';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(
              height: 50,
              width: double.infinity,
              child: TextFormField(
                style: TextStyle(color: AppColors.white),
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Enter food',
                  labelStyle: TextStyle(color: AppColors.white, fontSize: 18),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: AppColors.button,
                      size: 30,
                    ),
                    onPressed: () {
                      if (_searchController.text.isNotEmpty) {
                        _search();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              'Please enter value before search',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  border: const UnderlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: AppColors.button)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: AppColors.button)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _searchResult,
              style: TextStyle(color: AppColors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _search() async {
    if (formKey.currentState!.validate()) {
      String valueToSearch = _searchController.text;

      try {
        // Call the searchByKey function to search for the value in the Firebase Realtime Database
        String? value = await searchByKey(valueToSearch);

        // Update state with the search result
        setState(() {
          if (value != null) {
            _searchResult = 'Every 100 grams of $valueToSearch is : $value';
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
  }

// Function to search for a value by key in Firebase Realtime Database
  Future<String?> searchByKey(String key) async {
    final DatabaseReference ref = FirebaseDatabase.instance.ref().child(key);

    try {
      final event = await ref.once();

      // Check if the snapshot has data
      if (event.snapshot.exists) {
        // Return the value corresponding to the key
        return event.snapshot.value.toString();
      }
    } catch (error) {
      // Handle errors
      print('Error searching by key: $error');
    }

    return null; // Return null if key is not found or if an error occurs
  }
}
