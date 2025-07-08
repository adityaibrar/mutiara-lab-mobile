import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant/theme.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool readOnly;
  final TextInputType? keyboardType;
  final Function()? onTap;
  final TextStyle? textStyle;
  final Color? borderColor;
  final bool? isPassword;

  const InputField({
    super.key,
    required this.controller,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.onTap,
    this.textStyle,
    this.borderColor,
    this.isPassword,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: onTap,
      controller: controller,
      obscureText: isPassword ?? false,
      style: textStyle ?? blackTextStyle,
      cursorColor: borderColor ?? blackColor,
      keyboardType: keyboardType,
      readOnly: readOnly,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor ?? blackColor),
          borderRadius: BorderRadius.circular(20.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor ?? blackColor),
          borderRadius: BorderRadius.circular(20.r),
        ),
        labelText: label,
        labelStyle: textStyle ?? blackTextStyle,
      ),
    );
  }
}
