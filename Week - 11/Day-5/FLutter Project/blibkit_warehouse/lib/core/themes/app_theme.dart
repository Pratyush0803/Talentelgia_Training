import 'package:flutter/material.dart';
import '../styles/app_button_style.dart';
import 'app_text_theme.dart';
import 'bottom_navigation_theme.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    textTheme: AppTextTheme.lightTextTheme,
    bottomNavigationBarTheme: BottomNavigationTheme.lightTheme,
    elevatedButtonTheme: AppButtonStyles.elevatedButtonTheme,
    scaffoldBackgroundColor: Colors.grey[100],
    primaryColor: Colors.green[700],
  );

  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    textTheme: AppTextTheme.darkTextTheme,
    bottomNavigationBarTheme: BottomNavigationTheme.darkTheme,
    elevatedButtonTheme: AppButtonStyles.elevatedButtonTheme,
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.green,
  );
}
