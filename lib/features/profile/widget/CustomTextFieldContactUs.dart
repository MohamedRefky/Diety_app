import 'package:diety/Core/utils/Colors.dart';
import 'package:flutter/material.dart';

class CustomTextFieldContactUs extends StatelessWidget {
  const CustomTextFieldContactUs({
    Key? key,
    this.label,
    required this.mycontroller,
    this.validator,
    this.onChanged,
    this.onTap,
    this.maxLines,
    this.hintText,
  }) : super(key: key);
  final int? maxLines;
  final String? label;
  final String? hintText;
  final TextEditingController mycontroller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      controller: mycontroller,
      cursorColor: AppColors.white,
      style: TextStyle(color: AppColors.white, fontSize: 18),
      decoration: InputDecoration(
        fillColor: AppColors.white,
        labelText: label,
        hintText: hintText,
        labelStyle: TextStyle(fontSize: 20, color: AppColors.white),
        hintStyle: TextStyle(fontSize: 20, color: AppColors.white),
        border: const UnderlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.grey),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,
    );
  }
}
