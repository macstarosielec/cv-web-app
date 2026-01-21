import 'package:flutter/material.dart';
import 'package:shared/gen/colors.gen.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    scaffoldBackgroundColor: ColorName.primaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorName.primaryDarkColor,
    ),
    colorScheme: ColorScheme.fromSwatch(
      accentColor: ColorName.secondaryColor,
    ),
    snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
    ),
  );

  static ThemeData get dark => ThemeData(
    scaffoldBackgroundColor: ColorName.primaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorName.primaryDarkColor,
    ),
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.dark,
      accentColor: ColorName.secondaryColor,
    ),
    snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
    ),
  );
}
