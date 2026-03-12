import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared/gen/colors.gen.dart';

class AppTheme {
  static final TextTheme _baseTextTheme = GoogleFonts.interTextTheme();

  static TextTheme get _textTheme => _baseTextTheme.copyWith(
        displayLarge: _baseTextTheme.displayLarge?.copyWith(
          color: ColorName.textPrimary,
          fontWeight: FontWeight.w700,
        ),
        displayMedium: _baseTextTheme.displayMedium?.copyWith(
          color: ColorName.textPrimary,
          fontWeight: FontWeight.w700,
        ),
        headlineLarge: _baseTextTheme.headlineLarge?.copyWith(
          color: ColorName.textPrimary,
          fontWeight: FontWeight.w700,
        ),
        headlineMedium: _baseTextTheme.headlineMedium?.copyWith(
          color: ColorName.textPrimary,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: _baseTextTheme.headlineSmall?.copyWith(
          color: ColorName.textPrimary,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: _baseTextTheme.titleLarge?.copyWith(
          color: ColorName.textPrimary,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: _baseTextTheme.titleMedium?.copyWith(
          color: ColorName.textPrimary,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: _baseTextTheme.titleSmall?.copyWith(
          color: ColorName.textSecondary,
        ),
        bodyLarge: _baseTextTheme.bodyLarge?.copyWith(
          color: ColorName.textSecondary,
        ),
        bodyMedium: _baseTextTheme.bodyMedium?.copyWith(
          color: ColorName.textSecondary,
        ),
        bodySmall: _baseTextTheme.bodySmall?.copyWith(
          color: ColorName.textMuted,
        ),
        labelLarge: _baseTextTheme.labelLarge?.copyWith(
          color: ColorName.textPrimary,
        ),
      );

  static ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.transparent,
        textTheme: _textTheme,
        colorScheme: const ColorScheme.dark(
          surface: ColorName.surface,
          primary: ColorName.accent,
          secondary: ColorName.accentLight,
          error: ColorName.accentLight,
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
          side: const BorderSide(color: ColorName.surfaceBorder),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        snackBarTheme: const SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
        ),
      );
}
