import 'package:diety/Core/Colors.dart';
import 'package:flutter/material.dart';

class CustomSearchFood extends StatelessWidget {
  const CustomSearchFood({
    super.key, required this.hintText,
  });
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: AppColors.text),
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              size: 30,
              color: AppColors.grey,
            ),
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 18, color: AppColors.text),
            border: const UnderlineInputBorder(),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppColors.button)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppColors.button)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.red)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.red))),
      ),
    );
  }
}