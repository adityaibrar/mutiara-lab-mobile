import 'package:flutter/material.dart';

class DialogHelper {
  static bool _isDialogShowing = false;

  static void showLoadingDialog(BuildContext context) {
    if (!_isDialogShowing) {
      // Cek apakah dialog sudah ditampilkan
      _isDialogShowing = true;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
    }
  }

  static void hideLoadingDialog(BuildContext context) {
    if (_isDialogShowing) {
      Navigator.of(context).pop();
      _isDialogShowing = false;
    }
  }
}
