import 'package:diety/Core/utils/Colors.dart';
import 'package:diety/features/Admin/cubit/admin_cubit.dart';
import 'package:diety/features/Admin/cubit/admin_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ManageUsers extends StatelessWidget {
  const ManageUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminCubit()..fetchUsers(),
      child: const _ManageUsersView(),
    );
  }
}

class _ManageUsersView extends StatelessWidget {
  const _ManageUsersView();

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
                child:
                    const Text('Delete', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.white, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: AppColors.background,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Users List',
                style: TextStyle(
                    color: AppColors.white, fontWeight: FontWeight.bold)),
            const Gap(5),
            Icon(Icons.people, color: AppColors.white, size: 30),
          ],
        ),
      ),
      body: BlocConsumer<AdminCubit, AdminState>(
        listener: (context, state) {
          if (state is AdminActionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.message), backgroundColor: Colors.green),
            );
          } else if (state is AdminError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.message), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          if (state is AdminLoading || state is AdminInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AdminError) {
            return Center(
              child: Text('Error: ${state.message}',
                  style: TextStyle(color: AppColors.white)),
            );
          }

          if (state is AdminUsersLoaded) {
            if (state.users.isEmpty) {
              return Center(
                  child: Text('No users found',
                      style: TextStyle(color: AppColors.white)));
            }

            return ListView.separated(
              itemCount: state.users.length,
              separatorBuilder: (_, __) => const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(
                    thickness: 1,
                    height: 1,
                    indent: 10,
                    endIndent: 10,
                    color: Colors.grey),
              ),
              itemBuilder: (context, index) {
                final user = state.users[index];
                return ListTile(
                  title: Text(user['name'],
                      style: TextStyle(color: AppColors.white)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(4),
                      Text('Email: ${user['email']}',
                          style: TextStyle(color: AppColors.white)),
                      const Gap(4),
                      Text('ID: ${user['uid']}',
                          style: TextStyle(color: AppColors.white)),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      final confirm = await _showConfirmationDialog(context);
                      if (confirm && context.mounted) {
                        context.read<AdminCubit>().deleteUser(user['uid']);
                      }
                    },
                  ),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
