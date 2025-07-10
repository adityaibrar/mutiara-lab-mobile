import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mutiara_lab/features/penyedia_sampling/models/koor_teknis_document.dart';

import '../constant/theme.dart';
import '../constant/url.dart';

class ItemDocumentSampling extends StatelessWidget {
  final KoorTeknisDocument koorTeknisDocument;
  final VoidCallback onTap;
  const ItemDocumentSampling({
    super.key,
    required this.koorTeknisDocument,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.r),
                  child: Image.network(
                    '${Appurl.base}${koorTeknisDocument.documentPath}',
                    height: 50.h,
                    width: 50.w,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      koorTeknisDocument.status ?? '',
                      style: whiteTextStyle.copyWith(
                        fontSize: 18.sp,
                        fontWeight: bold,
                      ),
                    ),
                    Text(
                      koorTeknisDocument.tglMasuk ?? '',
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
        ),
      ),
    );
  }
}
