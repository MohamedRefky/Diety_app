// ignore_for_file: library_private_types_in_public_api, deprecated_member_use, avoid_print, use_build_context_synchronously, unused_element
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diety/Core/utils/Colors.dart';
import 'package:diety/Core/widget/Custom_Button.dart';
import 'package:diety/features/Auth/SignUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FoodAdmainDashboard extends StatefulWidget {
  const FoodAdmainDashboard({Key? key}) : super(key: key);

  @override
  _FoodAdmainDashboardState createState() => _FoodAdmainDashboardState();
}

class _FoodAdmainDashboardState extends State<FoodAdmainDashboard> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.reference();

  Future<List<Map<String, dynamic>>> fetchUsers() async {
    QuerySnapshot querySnapshot = await _firestore.collection('users').get();
    return querySnapshot.docs
        .map((doc) => {
              'uid': doc.id,
              'name': doc.get('firstName'),
              'email': doc.get('email'),
            })
        .toList();
  }

  Future<void> deleteUser(String uid) async {
    try {
      await _firestore.collection('users').doc(uid).delete();
      setState(() {}); // Refresh the UI after deletion
    } catch (e) {
      print('Error deleting user from Firestore: $e');
    }
  }

  Future<void> deleteAccount() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).delete();
        await user.delete();
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              const SignUp(), // Redirect to a sign-in screen after deletion
        ));
      }
    } catch (e) {
      print('Error deleting user account: $e');
    }
  }

  Future<bool> addToRealtimeDatabase(String key, String value) async {
    try {
      await _database.child(key).set(value);
      print('Data added successfully');
      return true; // Return true if data is added successfully
    } catch (e) {
      print('Error adding data to Realtime Database: $e');
      return false; // Return false if there's an error
    }
  }

  Future<bool> deleteFromRealtimeDatabase(String key) async {
    try {
      await _database.child(key).remove();
      print('Data deleted successfully');
      return true; // Return true if data is deleted successfully
    } catch (e) {
      print('Error deleting data from Realtime Database: $e');
      return false; // Return false if there's an error
    }
  }

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirm Delete'),
            content:
                const Text('Are you sure you want to delete your account?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ) ??
        false; // Return false if the dialog is dismissed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 28,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Food Admin Dashboard',
              style: TextStyle(
                  color: AppColors.white, fontWeight: FontWeight.bold),
            ),
            const Gap(5),
            Icon(
              Icons.fastfood,
              color: AppColors.white,
              size: 30,
            ),
          ],
        ),
      ),
      // body: FutureBuilder<List<Map<String, dynamic>>>(
      //   future: fetchUsers(),
      //   builder: (context, snapshot) {

      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(child: CircularProgressIndicator());
      //     }
      //     if (snapshot.hasError) {
      //       return Center(child: Text('Error: ${snapshot.error}'));
      //     }
      //     if (!snapshot.hasData || snapshot.data!.isEmpty) {
      //       return const Center(child: Text('No users found'));
      //     }
      //   },
      // ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Gap(20),
            Custom_Button(
                width: 300,
                icon: Icons.add,
                iconColor: Colors.white,
                text: 'Add food',
                onPressed: () {
                  String key = '';
                  String value = '';

                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Add Data to Realtime Database'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            decoration: const InputDecoration(labelText: 'Key'),
                            onChanged: (input) => key = input,
                          ),
                          TextField(
                            decoration:
                                const InputDecoration(labelText: 'Value'),
                            onChanged: (input) => value = input,
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            bool added =
                                await addToRealtimeDatabase(key, value);
                            Navigator.of(context)
                                .pop(); // Close the dialog after adding data
                            if (added) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Data added successfully'),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Failed to add data'),
                                ),
                              );
                            }
                          },
                          child: const Text('Add'),
                        ),
                      ],
                    ),
                  );
                }),
            const Gap(20),
            Custom_Button(
                icon: Icons.delete,
                iconColor: Colors.red,
                width: 300,
                text: 'Delete food',
                onPressed: () {
                  String keyToDelete = '';

                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete Data from Realtime Database'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            decoration: const InputDecoration(
                                labelText: 'Key to delete'),
                            onChanged: (input) => keyToDelete = input,
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            bool deleted =
                                await deleteFromRealtimeDatabase(keyToDelete);
                            Navigator.of(context)
                                .pop(); // Close the dialog after deleting data
                            if (deleted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Data deleted successfully'),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Failed to delete data'),
                                ),
                              );
                            }
                          },
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
