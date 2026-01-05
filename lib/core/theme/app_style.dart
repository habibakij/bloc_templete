import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/core/utils/helper/color_manager.dart';

class AppTextStyles {
  AppTextStyles._();

  /// ---------- Titles ----------
  static TextStyle title({double fontSize = 20, FontWeight fontWeight = FontWeight.w600, Color? color, double letterSpacing = 0, double height = 1.2, TextDecoration? decoration, FontStyle fontStyle = FontStyle.normal}) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? AppColors.textColor,
      letterSpacing: letterSpacing,
      height: height,
      decoration: decoration ?? TextDecoration.none,
      fontStyle: fontStyle,
    );
  }

  /// ---------- Regular ----------
  static TextStyle regular({double fontSize = 14, FontWeight fontWeight = FontWeight.w400, Color? color, double letterSpacing = 0, double height = 1.2, TextDecoration? decoration, FontStyle fontStyle = FontStyle.normal}) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? AppColors.textColor,
      letterSpacing: letterSpacing,
      height: height,
      decoration: decoration ?? TextDecoration.none,
      fontStyle: fontStyle,
    );
  }

  /// ---------- Hint / Input ----------
  static TextStyle hintStyle({double fontSize = 13, FontWeight fontWeight = FontWeight.w400, Color? color, double letterSpacing = 0, double height = 1.2, TextDecoration? decoration, FontStyle fontStyle = FontStyle.normal}) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? AppColors.grey,
      letterSpacing: letterSpacing,
      height: height,
      decoration: decoration ?? TextDecoration.none,
      fontStyle: fontStyle,
    );
  }

  /// ---------- Price / Discount ----------
  static TextStyle discountStrikeStyle({double fontSize = 12, FontWeight fontWeight = FontWeight.w400, Color? color, double letterSpacing = 0, double height = 1.2, TextDecoration decoration = TextDecoration.lineThrough, FontStyle fontStyle = FontStyle.normal}) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? AppColors.grey,
      letterSpacing: letterSpacing,
      height: height,
      decoration: decoration,
      fontStyle: fontStyle,
    );
  }

  /// ---------- Buttons ----------
  static TextStyle buttonStyle({double fontSize = 16, FontWeight fontWeight = FontWeight.w600, Color? color, double letterSpacing = 0, double height = 1.2, TextDecoration? decoration, FontStyle fontStyle = FontStyle.normal}) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? AppColors.white,
      letterSpacing: letterSpacing,
      height: height,
      decoration: decoration ?? TextDecoration.none,
      fontStyle: fontStyle,
    );
  }

  /// ---------- Error / Success ----------
  static TextStyle errorStyle({double fontSize = 13, FontWeight fontWeight = FontWeight.w600, Color? color, double letterSpacing = 0, double height = 1.2, TextDecoration? decoration, FontStyle fontStyle = FontStyle.normal}) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? AppColors.dartRed,
      letterSpacing: letterSpacing,
      height: height,
      decoration: decoration ?? TextDecoration.none,
      fontStyle: fontStyle,
    );
  }
}
