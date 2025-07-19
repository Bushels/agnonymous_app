import 'package:flutter/material.dart';

class AppTheme {
  // Agricultural color palette
  static const primaryGreen = Color(0xFF2D5016); // Deep forest green
  static const lightGreen = Color(0xFF4A7C2E); // Sage green
  static const accentGreen = Color(0xFF6B8E23); // Olive green
  static const earthBrown = Color(0xFF8B4513); // Rich soil brown
  static const lightBrown = Color(0xFFA0522D); // Sienna brown
  static const wheatGold = Color(0xFFDAA520); // Golden wheat
  static const darkBg = Color(0xFF1A1A1A); // Dark earth
  static const darkSurface = Color(0xFF2C2C2C); // Dark soil
  static const lightSurface = Color(0xFF3A3A3A); // Light earth
  
  // Legacy colors for compatibility
  static const accentPurple = Color(0xFF8B5CF6);
  static const accentBlue = Color(0xFF3B82F6);
  static const accentOrange = Color(0xFFF59E0B);

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBg,
    colorScheme: ColorScheme.dark(
      primary: primaryGreen,
      secondary: earthBrown,
      surface: darkSurface,
      tertiary: wheatGold,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    cardTheme: const CardThemeData(
      color: darkSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    ),
  );
}