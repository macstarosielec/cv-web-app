import 'package:flutter/material.dart';
import 'package:shared/gen/colors.gen.dart';
import 'package:shared/gen/fonts.gen.dart';

class AppTheme {
  static const _tekoFamily = 'packages/shared/${FontFamily.teko}';
  static const _robotoFamily = 'packages/shared/${FontFamily.roboto}';

  static final TextTheme _baseTextTheme =
      ThemeData.dark().textTheme.apply(fontFamily: _tekoFamily);

  static TextStyle accentStyle({double? fontSize}) => TextStyle(
        fontFamily: _robotoFamily,
        fontSize: fontSize,
        fontWeight: FontWeight.w900,
      );

  static TextTheme get _textTheme => _baseTextTheme.copyWith(
        displayLarge: _baseTextTheme.displayLarge?.copyWith(
          color: ColorName.textPrimary,
          fontWeight: FontWeight.w400,
        ),
        displayMedium: _baseTextTheme.displayMedium?.copyWith(
          color: ColorName.textPrimary,
          fontWeight: FontWeight.w400,
        ),
        displaySmall: _baseTextTheme.displaySmall?.copyWith(
          color: ColorName.textPrimary,
          fontWeight: FontWeight.w400,
        ),
        headlineLarge: _baseTextTheme.headlineLarge?.copyWith(
          fontSize: 38,
          color: ColorName.textPrimary,
          fontWeight: FontWeight.w700,
        ),
        headlineMedium: _baseTextTheme.headlineMedium?.copyWith(
          fontSize: 34,
          color: ColorName.textPrimary,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: _baseTextTheme.headlineSmall?.copyWith(
          fontSize: 29,
          color: ColorName.textPrimary,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: _baseTextTheme.titleLarge?.copyWith(
          fontSize: 26,
          color: ColorName.textPrimary,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: _baseTextTheme.titleMedium?.copyWith(
          fontSize: 19,
          color: ColorName.textPrimary,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: _baseTextTheme.titleSmall?.copyWith(
          fontSize: 17,
          color: ColorName.textSecondary,
        ),
        bodyLarge: _baseTextTheme.bodyLarge?.copyWith(
          fontSize: 19,
          color: ColorName.textSecondary,
        ),
        bodyMedium: _baseTextTheme.bodyMedium?.copyWith(
          fontSize: 17,
          color: ColorName.textSecondary,
        ),
        bodySmall: _baseTextTheme.bodySmall?.copyWith(
          fontSize: 15,
          color: ColorName.textMuted,
        ),
        labelLarge: _baseTextTheme.labelLarge?.copyWith(
          fontSize: 17,
          color: ColorName.textPrimary,
        ),
      );

  static ThemeData dark({
    Color accent = ColorName.accent,
    Color accentLight = ColorName.accentLight,
    Color accentDark = ColorName.accentDark,
  }) =>
      ThemeData(
        brightness: Brightness.dark,
        fontFamily: _tekoFamily,
        scaffoldBackgroundColor: Colors.transparent,
        textTheme: _textTheme,
        colorScheme: ColorScheme.dark(
          surface: ColorName.surface,
          primary: accent,
          secondary: accentLight,
          error: accentLight,
          onSurface: ColorName.textPrimary,
          onPrimary: ColorName.textPrimary,
          outline: ColorName.surfaceBorder,
        ),
        cardTheme: const CardThemeData(
          color: ColorName.background,
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: ColorName.surfaceBorder),
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: ColorName.surfaceLight,
          labelStyle: _textTheme.bodySmall?.copyWith(
            color: ColorName.textSecondary,
          ),
          side: BorderSide.none,
          shape: const RoundedRectangleBorder(),
        ),
        snackBarTheme: const SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
        ),
      );
}
