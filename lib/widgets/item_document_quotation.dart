import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant/theme.dart';
import '../constant/url.dart';
import '../features/customers/models/list_invoice_model.dart';

class ItemDocumentQuotation extends StatelessWidget {
  final ListInvoiceModel listInvoiceModel;
  final VoidCallback onTap;
  const ItemDocumentQuotation({super.key, required this.listInvoiceModel, required this.onTap});

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
                    '${Appurl.base}${listInvoiceModel.documentUser!.imagePath}',
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
                      listInvoiceModel.documentUser?.docName ?? '',
                      style: whiteTextStyle.copyWith(
                        fontSize: 18.sp,
                        fontWeight: bold,
                      ),
                    ),
                    Text(
                      listInvoiceModel.documentUser?.docDate ?? '',
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
