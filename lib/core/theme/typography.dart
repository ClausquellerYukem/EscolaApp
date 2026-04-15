import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTypography {
  AppTypography._();

  static TextTheme getTextTheme({required bool isDark}) {
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final Color bodyColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return GoogleFonts.interTextTheme(
      TextTheme(
        displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.bold, color: textColor, letterSpacing: -0.25),
        displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.bold, color: textColor),
        displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: textColor),
        headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: textColor),
        headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: textColor),
        headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: textColor),
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: textColor),
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: textColor, letterSpacing: 0.15),
        titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: textColor, letterSpacing: 0.1),
        bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: bodyColor, letterSpacing: 0.5),
        bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: bodyColor, letterSpacing: 0.25),
        bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: bodyColor, letterSpacing: 0.4),
        labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: textColor, letterSpacing: 0.1),
        labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: textColor, letterSpacing: 0.5),
        labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: textColor, letterSpacing: 0.5),
      ),
    );
  }
}
