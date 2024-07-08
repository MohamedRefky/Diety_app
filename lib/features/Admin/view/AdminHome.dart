import 'package:diety/Core/utils/Colors.dart';
import 'package:diety/Core/widget/Custom_Button.dart';
import 'package:diety/features/Admin/view/ManagePlans.dart';
import 'package:diety/features/Admin/view/ManageUsers.dart';
import 'package:diety/features/Admin/view/foodAdminDashboard.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

// ignore: camel_case_types
class Admin_Home extends StatelessWidget {
  const Admin_Home({super.key});

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
          centerTitle: true,
          backgroundColor: AppColors.background,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Admin Dashboard',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Gap(5),
              Icon(
                Icons.admin_panel_settings,
                color: Colors.white,
                size: 30,
              ),
            ],
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Custom_Button(
                    width: 300,
                    icon: Icons.manage_accounts,
                    iconColor: Colors.white,
                    text: 'Manage Users',
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ManageUsers(),
                      ));
                    }),
                const Gap(20),
                Custom_Button(
                    icon: Icons.fastfood,
                    iconColor: Colors.white,
                    width: 300,
                    text: 'Manage Food',
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const FoodAdmainDashboard(),
                      ));
                    }),
                const Gap(20),
                Custom_Button(
                    icon: Icons.list_alt_outlined,
                    iconColor: Colors.white,
                    width: 300,
                    text: 'Manage Plans',
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ManagePlane(),
                      ));
                    }),
              ],
            ),
          ),
        ));
  }
}
