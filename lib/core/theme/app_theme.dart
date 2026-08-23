import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Shelf Gradient Data Model for Light and Dark modes
class ShelfGradientTheme {
  final LinearGradient gradient;
  final Color textColor;
  final Color badgeBackgroundColor;
  final Color badgeTextColor;

  const ShelfGradientTheme({
    required this.gradient,
    required this.textColor,
    required this.badgeBackgroundColor,
    required this.badgeTextColor,
  });
}

/// Centralized Design Tokens & Color Palettes for BookShelf v2
class AppTheme {
  // Light Theme Colors
  static const Color lightCanvas = Color(0xFFFAFAFB);
  static const Color lightCardBackground = Color(0xFFFFFFFF);
  static const Color lightCardBorder = Color(0xFFECECEC);
  static const Color lightSearchBackground = Color(0xFFEFEFEF);
  static const Color lightTextPrimary = Color(0xFF111115);
  static const Color lightTextMuted = Color(0xFF8E8E93);
  static const Color lightSectionTitle = Color(0xFF787880);
  static const Color lightBottomNavBackground = Color(0xFFFFFFFF);
  static const Color lightBottomNavBorder = Color(0xFFEFEFEF);
  static const Color lightNavActivePill = Color(0xFF1C1C1E);
  static const Color lightNavActiveIcon = Color(0xFFFFFFFF);
  static const Color lightNavInactiveIcon = Color(0xFF787880);
  static const Color lightPreviewBoxBackground = Color(0xFFEFEFEF);

  // Dark Theme Colors
  static const Color darkCanvas = Color(0xFF111113);
  static const Color darkCardBackground = Color(0xFF1A1A1E);
  static const Color darkCardBorder = Color(0xFF28282D);
  static const Color darkSearchBackground = Color(0xFF1C1C20);
  static const Color darkSearchBorder = Color(0xFF27272C);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextMuted = Color(0xFF64748B);
  static const Color darkStatusTag = Color(0xFF64748B);
  static const Color darkBottomNavBackground = Color(0xFF141416);
  static const Color darkBottomNavBorder = Color(0xFF242428);
  static const Color darkNavActivePill = Color(0xFFFFFFFF);
  static const Color darkNavActiveIcon = Color(0xFF111113);
  static const Color darkNavInactiveIcon = Color(0xFF64748B);
  static const Color darkPreviewBoxBackground = Color(0xFF25252A);

  // Light Mode Shelf Gradients
  static final Map<String, ShelfGradientTheme> lightShelves = {
    'Work': const ShelfGradientTheme(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFBACFFF), Color(0xFF9EB8FF)],
      ),
      textColor: Color(0xFF1E293B),
      badgeBackgroundColor: Color(0xFFFFFFFF),
      badgeTextColor: Color(0xFF1E293B),
    ),
    'Personal': const ShelfGradientTheme(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFECCFFF), Color(0xFFD8A9FB)],
      ),
      textColor: Color(0xFF3B0764),
      badgeBackgroundColor: Color(0xFFFFFFFF),
      badgeTextColor: Color(0xFF3B0764),
    ),
    'Receipts': const ShelfGradientTheme(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF95F0DB), Color(0xFF68E0C4)],
      ),
      textColor: Color(0xFF064E3B),
      badgeBackgroundColor: Color(0xFFFFFFFF),
      badgeTextColor: Color(0xFF064E3B),
    ),
    'Signed': const ShelfGradientTheme(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFBDCFFF), Color(0xFF9FB8FF)],
      ),
      textColor: Color(0xFF1E3A8A),
      badgeBackgroundColor: Color(0xFFFFFFFF),
      badgeTextColor: Color(0xFF1E3A8A),
    ),
    'Shared': const ShelfGradientTheme(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFFFC4E7), Color(0xFFFFA1D6)],
      ),
      textColor: Color(0xFF831843),
      badgeBackgroundColor: Color(0xFFFFFFFF),
      badgeTextColor: Color(0xFF831843),
    ),
  };

  // Dark Mode Shelf Gradients
  static final Map<String, ShelfGradientTheme> darkShelves = {
    'Work': const ShelfGradientTheme(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF1C274C), Color(0xFF151D38)],
      ),
      textColor: Color(0xFF93C5FD),
      badgeBackgroundColor: Color(0xFF10172A),
      badgeTextColor: Color(0xFF93C5FD),
    ),
    'Personal': const ShelfGradientTheme(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF2E1B4E), Color(0xFF201237)],
      ),
      textColor: Color(0xFFE9D5FF),
      badgeBackgroundColor: Color(0xFF170B28),
      badgeTextColor: Color(0xFFE9D5FF),
    ),
    'Receipts': const ShelfGradientTheme(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF123F36), Color(0xFF0B2B25)],
      ),
      textColor: Color(0xFF6EE7B7),
      badgeBackgroundColor: Color(0xFF061B17),
      badgeTextColor: Color(0xFF6EE7B7),
    ),
    'Signed': const ShelfGradientTheme(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF222B4E), Color(0xFF161D36)],
      ),
      textColor: Color(0xFFA5B4FC),
      badgeBackgroundColor: Color(0xFF0E1324),
      badgeTextColor: Color(0xFFA5B4FC),
    ),
    'Shared': const ShelfGradientTheme(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF4A1A37), Color(0xFF331025)],
      ),
      textColor: Color(0xFFF472B6),
      badgeBackgroundColor: Color(0xFF230819),
      badgeTextColor: Color(0xFFF472B6),
    ),
  };

  /// Flutter ThemeData for Light Mode
  static ThemeData lightThemeData(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightCanvas,
      primaryColor: lightNavActivePill,
      colorScheme: const ColorScheme.light(
        primary: lightNavActivePill,
        surface: lightCardBackground,
        background: lightCanvas,
      ),
      textTheme: GoogleFonts.plusJakartaSansTextTheme(
        ThemeData.light().textTheme,
      ),
    );
  }

  /// Flutter ThemeData for Dark Mode
  static ThemeData darkThemeData(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkCanvas,
      primaryColor: darkNavActivePill,
      colorScheme: const ColorScheme.dark(
        primary: darkNavActivePill,
        surface: darkCardBackground,
        background: darkCanvas,
      ),
      textTheme: GoogleFonts.plusJakartaSansTextTheme(
        ThemeData.dark().textTheme,
      ),
    );
  }
}
