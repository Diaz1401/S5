import 'package:flutter/material.dart';

class AppTheme {
  final TextTheme textTheme;

  const AppTheme(this.textTheme);

  // Warna utama
  static const Color primaryBlue = Color(0xFF1565C0);
  static const Color secondaryBlue = Color(0xFF42A5F5);
  static const Color accentBlue = Color(0xFF29B6F6);
  static const Color warningOrange = Color(0xFFF59E0B);
  static const Color errorRed = Color(0xFFD32F2F);
  static const Color backgroundLight = Color(0xFFF5F9FF);
  static const Color textDark = Color(0xFF0D1B2A);

  // LIGHT MODE
  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: primaryBlue,
      onPrimary: Colors.white,
      primaryContainer: Color(0xFF1976D2),
      onPrimaryContainer: Colors.white,
      secondary: Color.fromARGB(255, 4, 104, 186),
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFFE3F2FD),
      onSecondaryContainer: Color(0xFF0D47A1),
      tertiary: accentBlue,
      onTertiary: Colors.white,
      error: errorRed,
      onError: Colors.white,
      surface: backgroundLight,
      onSurface: textDark,
      surfaceTint: primaryBlue,
      outline: Color(0xFFB0BEC5),
      outlineVariant: Color(0xFFECEFF1),
      shadow: Colors.black12,
      scrim: Colors.black26,
      inverseSurface: Color(0xFF102A43),
      inversePrimary: Color(0xFF90CAF9),
      surfaceDim: Color(0xFFE3F2FD),
      surfaceBright: Color(0xFFF9FBFF),
      surfaceContainerLowest: Colors.white,
      surfaceContainerLow: Color(0xFFF3F8FF),
      surfaceContainer: Color(0xFFE8F1FF),
      surfaceContainerHigh: Color(0xFFDDEBFF),
      surfaceContainerHighest: Color(0xFFD0E3FF),
      errorContainer: Color(0xFFFFE5E5),
      onErrorContainer: Color(0xFF5A0000),
    );
  }

  // DARK MODE
  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color.fromARGB(255, 13, 121, 209),
      onPrimary: Color(0xFF0D1B2A),
      primaryContainer: Color(0xFF1565C0),
      onPrimaryContainer: Colors.white,
      secondary: Color(0xFF64B5F6),
      onSecondary: Colors.black,
      secondaryContainer: Color(0xFF1E3A5F),
      onSecondaryContainer: Colors.white,
      tertiary: Color(0xFF4FC3F7),
      onTertiary: Colors.black,
      error: Color(0xFFFF8A80),
      onError: Color(0xFF2C0000),
      surface: Color(0xFF0D1B2A),
      onSurface: Colors.white,
      surfaceTint: Color(0xFF90CAF9),
      outline: Color(0xFF607D8B),
      outlineVariant: Color(0xFF2C3E50),
      shadow: Colors.black,
      scrim: Colors.black54,
      inverseSurface: Color(0xFFF5F9FF),
      inversePrimary: Color(0xFF1976D2),
      surfaceDim: Color(0xFF0D1B2A),
      surfaceBright: Color(0xFF102A43),
      surfaceContainerLowest: Color(0xFF08111F),
      surfaceContainerLow: Color(0xFF102437),
      surfaceContainer: Color(0xFF1A3552),
      surfaceContainerHigh: Color(0xFF224165),
      surfaceContainerHighest: Color(0xFF2E4E75),
      errorContainer: Color(0xFF3D0000),
      onErrorContainer: Color(0xFFFFCDD2),
    );
  }

  // Tema terang
  static ThemeData get lightTheme {
    final colorScheme = lightScheme();
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: colorScheme.onPrimary,
        ),
      ),
      cardTheme: CardThemeData(
        color: colorScheme.surfaceContainerLow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: colorScheme.onSurface),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
    );
  }

  // Tema gelap
  static ThemeData get darkTheme {
    final colorScheme = darkScheme();
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
      ),
      cardTheme: CardThemeData(
        color: colorScheme.surfaceContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: colorScheme.onSurface),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
    );
  }

  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'good':
      case 'excellent':
        return accentBlue;
      case 'warning':
      case 'moderate':
        return warningOrange;
      case 'critical':
      case 'poor':
        return errorRed;
      default:
        return primaryBlue;
    }
  }
}
