// ignore_for_file: camel_case_types

import 'package:diety/Core/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Custom_Button extends StatelessWidget {
  const Custom_Button({
    super.key,
    required this.text,
    required this.onPressed,
    this.height,
    this.width,
    this.color,
    this.icon,
    this.iconColor,
  });
  final String text;
  final Function() onPressed;
  final double? height;
  final double? width;
  final Color? color;
  final IconData? icon;
  final Color? iconColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (width) ?? double.infinity,
      height: (height) ?? 65,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: color ?? AppColors.button,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                    color: AppColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              const Gap(10),
              Icon(icon, color: iconColor),
            ],
          )),
    );
  }
}
