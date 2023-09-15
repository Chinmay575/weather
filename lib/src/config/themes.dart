import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData sunny = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.yellow.shade300,
    ),
    // colorScheme: ColorScheme.dark(),
  );

  static ThemeData cloudy = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.lightBlue.shade400,
    ),
  );

  static ThemeData defaultTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
  );
}
