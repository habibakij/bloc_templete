import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/core/theme/app_style.dart';
import 'package:flutter_bloc_template/core/utils/helper/app_constants.dart';
import 'package:flutter_bloc_template/core/utils/helper/color_manager.dart';

class AppSnackBar {
  static void show({
    required String message,
    Color backgroundColor = Colors.black87,
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final snackBar = SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: AppTextStyles.regular(color: AppColors.white, fontWeight: FontWeight.w600),
      ),
      backgroundColor: backgroundColor,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      action: actionLabel != null ? SnackBarAction(label: actionLabel, onPressed: onAction ?? () {}, textColor: AppColors.white) : null,
    );
    scaffoldMessengerKey.currentState
      ?..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void success(String message) {
    show(message: message, backgroundColor: AppColors.green);
  }

  static void error(String message) {
    show(message: message, backgroundColor: AppColors.red);
  }

  static void info(String message) {
    show(message: message, backgroundColor: AppColors.primaryColor);
  }

  static void warning(String message) {
    show(message: message, backgroundColor: AppColors.warning);
  }
}
