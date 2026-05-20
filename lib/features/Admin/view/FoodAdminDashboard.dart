// ignore_for_file: use_build_context_synchronously

import 'package:diety/Core/utils/Colors.dart';
import 'package:diety/Core/widget/Custom_Button.dart';
import 'package:diety/features/Admin/cubit/admin_cubit.dart';
import 'package:diety/features/Admin/cubit/admin_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class FoodAdmainDashboard extends StatelessWidget {
  const FoodAdmainDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminCubit(),
      child: const _FoodAdminView(),
    );
  }
}

class _FoodAdminView extends StatelessWidget {
  const _FoodAdminView();

  void _showAddFoodDialog(BuildContext context) {
    String key = '';
    String value = '';

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Add Food to Realtime Database'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Key'),
              onChanged: (v) => key = v,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Value'),
              onChanged: (v) => value = v,
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<AdminCubit>().addFoodToRealtimeDatabase(key, value);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showDeleteFoodDialog(BuildContext context) {
    String keyToDelete = '';

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Food from Realtime Database'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Key to delete'),
              onChanged: (v) => keyToDelete = v,
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context
                  .read<AdminCubit>()
                  .deleteFoodFromRealtimeDatabase(keyToDelete);
            },
            child: const Text('Delete',
                style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Food Admin Dashboard',
                style: TextStyle(
                    color: AppColors.white, fontWeight: FontWeight.bold)),
            const Gap(5),
            Icon(Icons.fastfood, color: AppColors.white, size: 30),
          ],
        ),
      ),
      body: BlocListener<AdminCubit, AdminState>(
        listener: (context, state) {
          if (state is AdminActionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green),
            );
          } else if (state is AdminError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red),
            );
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Gap(20),
              Custom_Button(
                width: 300,
                icon: Icons.add,
                iconColor: Colors.white,
                text: 'Add food',
                onPressed: () => _showAddFoodDialog(context),
              ),
              const Gap(20),
              Custom_Button(
                icon: Icons.delete,
                iconColor: Colors.red,
                width: 300,
                text: 'Delete food',
                onPressed: () => _showDeleteFoodDialog(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
