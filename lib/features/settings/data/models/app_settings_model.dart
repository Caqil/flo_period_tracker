import 'package:flutter/material.dart';

import '../../domain/entities/app_settings.dart';

class AppSettingsModel extends AppSettings {
  const AppSettingsModel({
    required super.themeMode,
    required super.locale,
    required super.textScale,
    required super.notificationsEnabled,
    required super.borderRadius,
    required super.fontFamily,
    required super.biometricEnabled,
    required super.periodRemindersEnabled,
    required super.ovulationRemindersEnabled,
    required super.reminderDaysBefore,
    required super.reminderTime,
  });

  factory AppSettingsModel.fromEntity(AppSettings settings) {
    return AppSettingsModel(
      themeMode: settings.themeMode,
      locale: settings.locale,
      textScale: settings.textScale,
      notificationsEnabled: settings.notificationsEnabled,
      borderRadius: settings.borderRadius,
      fontFamily: settings.fontFamily,
      biometricEnabled: settings.biometricEnabled,
      periodRemindersEnabled: settings.periodRemindersEnabled,
      ovulationRemindersEnabled: settings.ovulationRemindersEnabled,
      reminderDaysBefore: settings.reminderDaysBefore,
      reminderTime: settings.reminderTime,
    );
  }

  factory AppSettingsModel.fromJson(Map<String, dynamic> json) {
    return AppSettingsModel(
      themeMode: _parseThemeMode(json['themeMode'] as String? ?? 'system'),
      locale: Locale(json['locale'] as String? ?? 'en'),
      textScale: (json['textScale'] as num?)?.toDouble() ?? 1.0,
      notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
      borderRadius: (json['borderRadius'] as num?)?.toDouble() ?? 8.0,
      fontFamily: json['fontFamily'] as String? ?? 'GeistSans',
      biometricEnabled: json['biometricEnabled'] as bool? ?? false,
      periodRemindersEnabled: json['periodRemindersEnabled'] as bool? ?? true,
      ovulationRemindersEnabled:
          json['ovulationRemindersEnabled'] as bool? ?? true,
      reminderDaysBefore: json['reminderDaysBefore'] as int? ?? 3,
      reminderTime: _parseTimeOfDay(json['reminderTime'] as String? ?? '09:00'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'themeMode': themeMode.name,
      'locale': locale.languageCode,
      'textScale': textScale,
      'notificationsEnabled': notificationsEnabled,
      'borderRadius': borderRadius,
      'fontFamily': fontFamily,
      'biometricEnabled': biometricEnabled,
      'periodRemindersEnabled': periodRemindersEnabled,
      'ovulationRemindersEnabled': ovulationRemindersEnabled,
      'reminderDaysBefore': reminderDaysBefore,
      'reminderTime': _timeOfDayToString(reminderTime),
    };
  }

  AppSettings toEntity() {
    return AppSettings(
      themeMode: themeMode,
      locale: locale,
      textScale: textScale,
      notificationsEnabled: notificationsEnabled,
      borderRadius: borderRadius,
      fontFamily: fontFamily,
      biometricEnabled: biometricEnabled,
      periodRemindersEnabled: periodRemindersEnabled,
      ovulationRemindersEnabled: ovulationRemindersEnabled,
      reminderDaysBefore: reminderDaysBefore,
      reminderTime: reminderTime,
    );
  }

  AppSettingsModel copyWith({
    ThemeMode? themeMode,
    Locale? locale,
    double? textScale,
    bool? notificationsEnabled,
    double? borderRadius,
    String? fontFamily,
    bool? biometricEnabled,
    bool? periodRemindersEnabled,
    bool? ovulationRemindersEnabled,
    int? reminderDaysBefore,
    TimeOfDay? reminderTime,
  }) {
    return AppSettingsModel(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      textScale: textScale ?? this.textScale,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      borderRadius: borderRadius ?? this.borderRadius,
      fontFamily: fontFamily ?? this.fontFamily,
      biometricEnabled: biometricEnabled ?? this.biometricEnabled,
      periodRemindersEnabled:
          periodRemindersEnabled ?? this.periodRemindersEnabled,
      ovulationRemindersEnabled:
          ovulationRemindersEnabled ?? this.ovulationRemindersEnabled,
      reminderDaysBefore: reminderDaysBefore ?? this.reminderDaysBefore,
      reminderTime: reminderTime ?? this.reminderTime,
    );
  }

  static ThemeMode _parseThemeMode(String themeMode) {
    switch (themeMode.toLowerCase()) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  static TimeOfDay _parseTimeOfDay(String timeString) {
    try {
      final parts = timeString.split(':');
      return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    } catch (e) {
      return const TimeOfDay(hour: 9, minute: 0);
    }
  }

  static String _timeOfDayToString(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
