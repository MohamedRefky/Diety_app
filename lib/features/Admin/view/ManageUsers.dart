import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diety/Core/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ManageUsers extends StatefulWidget {
  const ManageUsers({super.key});

  @override
  _ManageUsersState createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
      print('Error deleting user: $e');
    }
  }

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirm Delete'),
            content: const Text('Are you sure you want to delete this user?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Delete'),
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
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.white,
            size: 28,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: AppColors.background,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Users List',
              style: TextStyle(
                  color: AppColors.white, fontWeight: FontWeight.bold),
            ),
            const Gap(5),
            Icon(
              Icons.people,
              color: AppColors.white,
              size: 30,
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(color: AppColors.white),
              ),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
                child: Text('No users found',
                    style: TextStyle(color: AppColors.white)));
          }

          List<Map<String, dynamic>> users = snapshot.data!;

          return ListView.separated(
            itemCount: users.length,
            separatorBuilder: (context, index) => const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(
                thickness: 1,
                height: 1,
                indent: 10,
                endIndent: 10,
                color: Colors.grey,
              ),
            ),
            itemBuilder: (context, index) {
              var user = users[index];
              return ListTile(
                title: Text(
                  user['name'],
                  style: TextStyle(color: AppColors.white),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(4),
                    Text('Email : ${user['email']}',
                        style: TextStyle(color: AppColors.white)),
                    const Gap(4),
                    Text('id : ${user['uid']}',
                        style: TextStyle(color: AppColors.white)),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () async {
                    bool confirmDelete = await _showConfirmationDialog(context);
                    if (confirmDelete) {
                      await deleteUser(user['uid']);
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
