import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant/theme.dart';

class ButtonGlass extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  const ButtonGlass({super.key, required this.title, required this.onTap});

  @override
  State<ButtonGlass> createState() => _ButtonGlassState();
}

class _ButtonGlassState extends State<ButtonGlass> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 40.h,
        decoration: BoxDecoration(
          color: Color(0X55FFFFFF),
          borderRadius: BorderRadius.circular(10.h),
        ),
        child: Center(
          child: Text(
            widget.title,
            style: whiteTextStyle.copyWith(fontSize: 16.sp, fontWeight: medium),
          ),
        ),
      ),
    );
  }
}
