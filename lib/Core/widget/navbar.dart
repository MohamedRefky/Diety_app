import 'package:community_material_icon/community_material_icon.dart';
import 'package:diety/Core/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class salomon_bottom_bar extends StatefulWidget {
  const salomon_bottom_bar({Key? key}) : super(key: key);

  @override
  _salomon_bottom_barState createState() => _salomon_bottom_barState();
}

class _salomon_bottom_barState extends State<salomon_bottom_bar> {
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: double.infinity,
      child: SalomonBottomBar(
        backgroundColor: AppColors.white,
        currentIndex: _currentIndex,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          SalomonBottomBarItem(
            icon: const Icon(CommunityMaterialIcons.view_dashboard),
            title: const Text("Diary"),
            selectedColor: AppColors.button,
          ),
          SalomonBottomBarItem(
            icon: const Icon(FontAwesomeIcons.utensils),
            title: const Text("Recipes"),
            selectedColor: AppColors.button,
          ),
          SalomonBottomBarItem(
            icon: const Icon(FontAwesomeIcons.personRunning),
            title: const Text("Plans"),
            selectedColor: AppColors.button,
          ),
          SalomonBottomBarItem(
            icon: const Icon(FontAwesomeIcons.user),
            title: const Text("Profile"),
            selectedColor: AppColors.button,
          )
        ],
      ),
    );
  }
}
