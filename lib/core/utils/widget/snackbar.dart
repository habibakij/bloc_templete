import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/core/utils/helper/app_constants.dart';

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
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: backgroundColor,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      action: actionLabel != null
          ? SnackBarAction(
              label: actionLabel,
              onPressed: onAction ?? () {},
              textColor: Colors.white,
            )
          : null,
    );
    scaffoldMessengerKey.currentState
      ?..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void success(String message) {
    show(message: message, backgroundColor: Colors.green);
  }

  static void error(String message) {
    show(message: message, backgroundColor: Colors.red);
  }

  static void info(String message) {
    show(message: message, backgroundColor: Colors.blue);
  }
}
