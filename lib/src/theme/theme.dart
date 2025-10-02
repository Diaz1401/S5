import 'package:flutter/material.dart';

class AppTheme {
  final TextTheme textTheme;

  const AppTheme(this.textTheme);

  static const Color primaryGreen = Color(0xff6d5e0f);
  static const Color warningOrange = Color(0xFFF59E0B);
  static const Color criticalRed = Color(0xffba1a1a);
  static const Color accentBlue = Color(0xff43664e);
  static const Color backgroundLight = Color(0xfffff9ee);
  static const Color textDark = Color(0xff1e1b13);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff6d5e0f),
      surfaceTint: Color(0xff6d5e0f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xfff8e287),
      onPrimaryContainer: Color(0xff534600),
      secondary: Color(0xff665e40),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffeee2bc),
      onSecondaryContainer: Color(0xff4e472a),
      tertiary: Color(0xff43664e),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffc5ecce),
      onTertiaryContainer: Color(0xff2c4e38),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffff9ee),
      onSurface: Color(0xff1e1b13),
      onSurfaceVariant: Color(0xff4b4739),
      outline: Color(0xff7c7767),
      outlineVariant: Color(0xffcdc6b4),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff333027),
      inversePrimary: Color(0xffdbc66e),
      primaryFixed: Color(0xfff8e287),
      onPrimaryFixed: Color(0xff221b00),
      primaryFixedDim: Color(0xffdbc66e),
      onPrimaryFixedVariant: Color(0xff534600),
      secondaryFixed: Color(0xffeee2bc),
      onSecondaryFixed: Color(0xff211b04),
      secondaryFixedDim: Color(0xffd1c6a1),
      onSecondaryFixedVariant: Color(0xff4e472a),
      tertiaryFixed: Color(0xffc5ecce),
      onTertiaryFixed: Color(0xff00210f),
      tertiaryFixedDim: Color(0xffa9d0b3),
      onTertiaryFixedVariant: Color(0xff2c4e38),
      surfaceDim: Color(0xffe0d9cc),
      surfaceBright: Color(0xfffff9ee),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffaf3e5),
      surfaceContainer: Color(0xfff4eddf),
      surfaceContainerHigh: Color(0xffeee8da),
      surfaceContainerHighest: Color(0xffe8e2d4),
    );
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffdbc66e),
      surfaceTint: Color(0xffdbc66e),
      onPrimary: Color(0xff3a3000),
      primaryContainer: Color(0xff534600),
      onPrimaryContainer: Color(0xfff8e287),
      secondary: Color(0xffd1c6a1),
      onSecondary: Color(0xff363016),
      secondaryContainer: Color(0xff4e472a),
      onSecondaryContainer: Color(0xffeee2bc),
      tertiary: Color(0xffa9d0b3),
      onTertiary: Color(0xff143723),
      tertiaryContainer: Color(0xff2c4e38),
      onTertiaryContainer: Color(0xffc5ecce),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff15130b),
      onSurface: Color(0xffe8e2d4),
      onSurfaceVariant: Color(0xffcdc6b4),
      outline: Color(0xff969080),
      outlineVariant: Color(0xff4b4739),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe8e2d4),
      inversePrimary: Color(0xff6d5e0f),
      primaryFixed: Color(0xfff8e287),
      onPrimaryFixed: Color(0xff221b00),
      primaryFixedDim: Color(0xffdbc66e),
      onPrimaryFixedVariant: Color(0xff534600),
      secondaryFixed: Color(0xffeee2bc),
      onSecondaryFixed: Color(0xff211b04),
      secondaryFixedDim: Color(0xffd1c6a1),
      onSecondaryFixedVariant: Color(0xff4e472a),
      tertiaryFixed: Color(0xffc5ecce),
      onTertiaryFixed: Color(0xff00210f),
      tertiaryFixedDim: Color(0xffa9d0b3),
      onTertiaryFixedVariant: Color(0xff2c4e38),
      surfaceDim: Color(0xff15130b),
      surfaceBright: Color(0xff3c3930),
      surfaceContainerLowest: Color(0xff100e07),
      surfaceContainerLow: Color(0xff1e1b13),
      surfaceContainer: Color(0xff222017),
      surfaceContainerHigh: Color(0xff2d2a21),
      surfaceContainerHighest: Color(0xff38352b),
    );
  }

  static ThemeData get lightTheme {
    final colorScheme = lightScheme();
    return ThemeData(
      useMaterial3: true,
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      canvasColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: colorScheme.onPrimary,
        ),
      ),
      cardTheme: CardThemeData(
        color: colorScheme.surfaceContainerLowest,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: colorScheme.onSurface),
        bodyMedium: TextStyle(fontSize: 14, color: colorScheme.onSurface),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surfaceContainer,
        selectedColor: colorScheme.primaryContainer,
        labelStyle: TextStyle(color: colorScheme.onSurface),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  static ThemeData get darkTheme {
    final colorScheme = darkScheme();
    return ThemeData(
      useMaterial3: true,
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      canvasColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: colorScheme.onPrimary,
        ),
      ),
      cardTheme: CardThemeData(
        color: colorScheme.surfaceContainerLowest,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: colorScheme.onSurface),
        bodyMedium: TextStyle(fontSize: 14, color: colorScheme.onSurface),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surfaceContainer,
        selectedColor: colorScheme.primaryContainer,
        labelStyle: TextStyle(color: colorScheme.onSurface),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'good':
      case 'excellent':
        return const Color(0xff43664e); // tertiary green
      case 'warning':
      case 'moderate':
        return warningOrange; // keeping orange for warnings
      case 'critical':
      case 'poor':
        return const Color(0xffba1a1a); // error red
      default:
        return const Color(0xff6d5e0f); // primary
    }
  }
}
