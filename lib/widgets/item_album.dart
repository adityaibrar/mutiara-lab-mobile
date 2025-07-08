import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constant/theme.dart';

class ItemAlbum extends StatelessWidget {
  final int year;
  final String totalDocument;
  const ItemAlbum({super.key, required this.year, required this.totalDocument});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        border: BoxBorder.all(color: whiteColor, width: 1.sp),
        color: Color(0X55FFFFFF),
        borderRadius: BorderRadius.circular(20.h),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/ic_folder.svg',
              height: 50.h,
              color: whiteColor,
            ),
            SizedBox(width: 10.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  year.toString(),
                  style: whiteTextStyle.copyWith(
                    fontSize: 18.sp,
                    fontWeight: bold,
                  ),
                ),
                Text(
                  totalDocument,
                  style: whiteTextStyle.copyWith(
                    fontSize: 18.sp,
                    fontWeight: medium,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
