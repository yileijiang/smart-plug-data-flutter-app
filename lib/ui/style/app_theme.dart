import 'package:flutter/material.dart';

class AppTheme {
  static ColorScheme colorScheme = ColorScheme.fromSeed(seedColor: Colors.blue);

  static ThemeData themeData() {
    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        foregroundColor: Colors.white,
        backgroundColor: colorScheme.primary,
      ),
      listTileTheme: ListTileThemeData(
          iconColor: colorScheme.primary,
          titleTextStyle: TextStyle(color: colorScheme.primary, fontSize: 16)),
      dialogTheme: DialogTheme(
          titleTextStyle: TextStyle(fontSize: 24, color: colorScheme.primary)),
      inputDecorationTheme: InputDecorationTheme(
        suffixIconColor: colorScheme.primary,
      ),
    );
  }
}
