import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../features/settings/domain/entities/app_settings.dart';

class AppTheme {
  // Primary colors for period tracking app
  static const Color primaryPink = Color(0xFFE91E63);
  static const Color secondaryPurple = Color(0xFF9C27B0);
  static const Color accentPink = Color(0xFFFF4081);
  static const Color fertilityGreen = Color(0xFF4CAF50);
  static const Color ovulationBlue = Color(0xFF2196F3);

  static ShadThemeData lightTheme(SettingsState settings) {
    return ShadThemeData(
      brightness: Brightness.light,
      colorScheme: const ShadColorScheme(
        background: Color(0xFFFFFFFF),
        foreground: Color(0xFF0A0A0A),
        card: Color(0xFFFFFFFF),
        cardForeground: Color(0xFF0A0A0A),
        popover: Color(0xFFFFFFFF),
        popoverForeground: Color(0xFF0A0A0A),
        primary: primaryPink,
        primaryForeground: Color(0xFFFFFFFF),
        secondary: Color(0xFFF1F5F9),
        secondaryForeground: Color(0xFF0F172A),
        muted: Color(0xFFF8FAFC),
        mutedForeground: Color(0xFF64748B),
        accent: accentPink,
        accentForeground: Color(0xFFFFFFFF),
        destructive: Color(0xFFDC2626),
        destructiveForeground: Color(0xFFFFFFFF),
        border: Color(0xFFE2E8F0),
        input: Color(0xFFE2E8F0),
        ring: primaryPink,
        selection: Color(0xFFBFDBFE),
      ),
      radius: BorderRadius.circular(settings.borderRadius),
      textTheme: _getTextTheme(false, settings.fontFamily),
    );
  }

  static ShadThemeData darkTheme(SettingsState settings) {
    return ShadThemeData(
      brightness: Brightness.dark,
      colorScheme: const ShadColorScheme(
        background: Color(0xFF0A0A0A),
        foreground: Color(0xFFFAFAFA),
        card: Color(0xFF0A0A0A),
        cardForeground: Color(0xFFFAFAFA),
        popover: Color(0xFF0A0A0A),
        popoverForeground: Color(0xFFFAFAFA),
        primary: primaryPink,
        primaryForeground: Color(0xFFFFFFFF),
        secondary: Color(0xFF27272A),
        secondaryForeground: Color(0xFFFAFAFA),
        muted: Color(0xFF27272A),
        mutedForeground: Color(0xFFA1A1AA),
        accent: accentPink,
        accentForeground: Color(0xFFFFFFFF),
        destructive: Color(0xFFDC2626),
        destructiveForeground: Color(0xFFFFFFFF),
        border: Color(0xFF27272A),
        input: Color(0xFF27272A),
        ring: primaryPink,
        selection: Color(0xFF1E40AF),
      ),
      radius: BorderRadius.circular(settings.borderRadius),
      textTheme: _getTextTheme(true, settings.fontFamily),
    );
  }

  static ShadTextTheme _getTextTheme(bool isDark, String fontFamily) {
    final baseColor = isDark
        ? const Color(0xFFFAFAFA)
        : const Color(0xFF0A0A0A);
    final mutedColor = isDark
        ? const Color(0xFFA1A1AA)
        : const Color(0xFF64748B);

    return ShadTextTheme(
      family: fontFamily,
      h1Large: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w800,
        color: baseColor,
        letterSpacing: -0.02,
      ),
      h1: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        color: baseColor,
        letterSpacing: -0.02,
      ),
      h2: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: baseColor,
        letterSpacing: -0.01,
      ),
      h3: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: baseColor,
      ),
      h4: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: baseColor,
      ),
      p: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: baseColor,
        height: 1.5,
      ),
      blockquote: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: mutedColor,
        fontStyle: FontStyle.italic,
      ),
      table: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: baseColor,
      ),
      list: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: baseColor,
      ),
      lead: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: mutedColor,
      ),
      large: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: baseColor,
      ),
      small: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: mutedColor,
      ),
      muted: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: mutedColor,
      ),
    );
  }

  // Custom colors for period tracking
  static const Map<String, Color> periodColors = {
    'period': primaryPink,
    'fertility': fertilityGreen,
    'ovulation': ovulationBlue,
    'pms': secondaryPurple,
    'spotting': Color(0xFFFF9800),
  };

  // Intensity colors for flow tracking
  static const Map<String, Color> flowIntensityColors = {
    'light': Color(0xFFFFCDD2),
    'medium': Color(0xFFF8BBD9),
    'heavy': primaryPink,
    'spotting': Color(0xFFFFE0B2),
  };
}
