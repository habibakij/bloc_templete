import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle titleTextStyle(
      {double fontSize = 20.0,
      textColor = Colors.black,
      fontWeight = FontWeight.w700,
      lineHeight = 0.0,
      isShadowRequired = false,
      shadowColor = Colors.grey}) {
    return TextStyle(
      shadows: isShadowRequired
          ? [
              Shadow(
                color: shadowColor,
                offset: const Offset(15, 15),
                blurRadius: 12,
              ),
            ]
          : [],
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: textColor,
      height: lineHeight,
    );
  }

  static TextStyle bodyTextStyle(
      {double fontSize = 16.0,
      textColor = Colors.black,
      fontWeight = FontWeight.w400,
      lineHeight = 0.0,
      isShadowRequired = false,
      shadowColor = Colors.grey}) {
    return TextStyle(
      shadows: isShadowRequired
          ? [
              Shadow(
                color: shadowColor,
                offset: const Offset(15, 15),
                blurRadius: 12,
              ),
            ]
          : [],
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: textColor,
      height: lineHeight,
    );
  }

  static TextStyle hinsTextStyle(
      {double fontSize = 16.0,
      textColor = Colors.grey,
      fontWeight = FontWeight.w400,
      lineHeight = 0.0,
      isShadowRequired = false,
      shadowColor = Colors.grey}) {
    return TextStyle(
      shadows: isShadowRequired
          ? [
              Shadow(
                color: shadowColor,
                offset: const Offset(15, 15),
                blurRadius: 12,
              ),
            ]
          : [],
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: textColor,
      height: lineHeight,
    );
  }
}
