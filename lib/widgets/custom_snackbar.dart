import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constant/theme.dart';

enum SnackbarType { error, warning, success }

class CustomSnackbar extends StatelessWidget {
  final String title;
  final String message;
  final SnackbarType type;
  const CustomSnackbar({
    super.key,
    required this.title,
    required this.message,
    required this.type,
  });

  Color _getBackgroundColor() {
    switch (type) {
      case SnackbarType.error:
        return Colors.red;
      case SnackbarType.success:
        return Colors.green;
      case SnackbarType.warning:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void show(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: _getBackgroundColor(),
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        duration: Duration(seconds: 3),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: whiteTextStyle.copyWith(fontWeight: bold, fontSize: 16.sp),
            ),
            Text(
              message,
              style: whiteTextStyle.copyWith(
                fontWeight: medium,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
