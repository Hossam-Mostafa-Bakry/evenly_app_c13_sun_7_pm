import 'package:flutter/material.dart';

abstract class AppThemeManager {

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.white,
    )
  );
}