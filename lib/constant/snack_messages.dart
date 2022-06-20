import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SnackMessages {
  static succesMessage(BuildContext context, String msg) {
    return showTopSnackBar(
      context,
      CustomSnackBar.success(
        message: msg,
      ),
    );
  }

  static errorMessage(BuildContext context, String msg) {
    return showTopSnackBar(
      context,
      CustomSnackBar.error(
        message: msg,
      ),
    );
  }
}
