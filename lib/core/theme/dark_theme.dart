import 'package:flutter/material.dart';
import 'package:notino/core/constants/colors.dart';
import 'package:notino/core/theme/text_theme.dart';

class DarkTheme {

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: Colors.transparent,
    fontFamily: 'Dana',
    textTheme: AppTextTheme.darkTextTheme,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.accent,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white,
    ),
  );

}