import 'package:flutter/material.dart';

class AppWidget {
  static Widget height(num height) {
    return SizedBox(
      height: height.toDouble(),
    );
  }

  static Widget width(num width) {
    return SizedBox(
      width: width.toDouble(),
    );
  }
}
