import 'package:diety/Core/Colors.dart';
import 'package:flutter/material.dart';

class CustomAppBarFood extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBarFood({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      leading: IconButton(
        onPressed: onPressed,
        icon: Icon(
          Icons.close,
          size: 33,
          color: AppColors.button,
        ),
      ),
      title: Text(
        text,
        style: TextStyle(
          color: AppColors.text,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
