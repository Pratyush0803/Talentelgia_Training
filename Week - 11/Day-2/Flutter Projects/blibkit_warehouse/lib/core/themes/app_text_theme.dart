import 'package:flutter/material.dart';
import '../styles/app_text_style.dart';

class AppTextTheme {
  static final TextTheme lightTextTheme = TextTheme(
    bodyLarge: AppTextStyle.buttonText,
    bodyMedium: AppTextStyle.authText,
    headlineLarge: AppTextStyle.logoText,
  );

  static final TextTheme darkTextTheme = TextTheme(
    bodyLarge: AppTextStyle.buttonText.copyWith(color: Colors.white),
    bodyMedium: AppTextStyle.authText.copyWith(color: Colors.green[300]),
    headlineLarge: AppTextStyle.logoText.copyWith(color: Colors.green[200]),
  );
}
