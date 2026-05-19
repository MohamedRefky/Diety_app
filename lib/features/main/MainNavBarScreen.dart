import 'package:community_material_icon/community_material_icon.dart';
import 'package:diety/Core/utils/Colors.dart';
import 'package:diety/features/Exersise/view/Exercise.dart';
import 'package:diety/features/Home/view/view/Home.dart';
import 'package:diety/features/Planes/view/Plane.dart';
import 'package:diety/features/profile/view/profile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MainNavBarScreen extends StatefulWidget {
  const MainNavBarScreen({super.key});
  static const route = "/Homee"; // Keep Home's original route to prevent breaking references

  @override
  State<MainNavBarScreen> createState() => _MainNavBarScreenState();
}

class _MainNavBarScreenState extends State<MainNavBarScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    Home(),
    Plane(),
    Exercise(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        width: double.infinity,
        child: SalomonBottomBar(
          backgroundColor: AppColors.background,
          currentIndex: _currentIndex,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            SalomonBottomBarItem(
              icon: const Icon(
                CommunityMaterialIcons.view_dashboard,
                size: 28,
              ),
              title: const Text("Diary"),
              selectedColor: AppColors.button,
              unselectedColor: AppColors.white,
            ),
            SalomonBottomBarItem(
              icon: const Icon(FontAwesomeIcons.utensils, size: 22),
              title: const Text("Recipes"),
              selectedColor: AppColors.button,
              unselectedColor: AppColors.white,
            ),
            SalomonBottomBarItem(
              icon: const Icon(FontAwesomeIcons.personRunning, size: 22),
              title: const Text("Plans"),
              selectedColor: AppColors.button,
              unselectedColor: AppColors.white,
            ),
            SalomonBottomBarItem(
              icon: const Icon(FontAwesomeIcons.user, size: 22),
              title: const Text("Profile"),
              selectedColor: AppColors.button,
              unselectedColor: AppColors.white,
            )
          ],
        ),
      ),
    );
  }
}
