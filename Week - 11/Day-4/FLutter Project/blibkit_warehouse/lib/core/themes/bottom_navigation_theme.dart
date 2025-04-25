import 'package:flutter/material.dart';

class BottomNavigationTheme {
  static BottomNavigationBarThemeData lightTheme = BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Colors.green,
    unselectedItemColor: Colors.grey[600],
    showSelectedLabels: true,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
    elevation: 10,
  );

  static BottomNavigationBarThemeData darkTheme = BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    selectedItemColor: Colors.green,
    unselectedItemColor: Colors.white60,
    showSelectedLabels: true,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
    elevation: 10,
  );
}
