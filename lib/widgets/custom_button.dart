import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant/theme.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const CustomButton({super.key, required this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.h),
        ),
      ),
      child: Center(
        child: Text(
          label,
          style: whiteTextStyle.copyWith(fontSize: 18.sp, fontWeight: bold),
        ),
      ),
    );
  }
}
