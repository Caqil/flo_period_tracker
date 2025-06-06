import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class AppSettings extends Equatable {
  final ThemeMode themeMode;
  final Locale locale;
  final double textScale;
  final bool notificationsEnabled;
  final double borderRadius;
  final String fontFamily;
  final bool biometricEnabled;
  final bool periodRemindersEnabled;
  final bool ovulationRemindersEnabled;
  final int reminderDaysBefore;
  final TimeOfDay reminderTime;

  const AppSettings({
    this.themeMode = ThemeMode.system,
    this.locale = const Locale('en'),
    this.textScale = 1.0,
    this.notificationsEnabled = true,
    this.borderRadius = 8.0,
    this.fontFamily = 'GeistSans',
    this.biometricEnabled = false,
    this.periodRemindersEnabled = true,
    this.ovulationRemindersEnabled = true,
    this.reminderDaysBefore = 3,
    this.reminderTime = const TimeOfDay(hour: 9, minute: 0),
  });

  AppSettings copyWith({
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
    return AppSettings(
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

  @override
  List<Object> get props => [
    themeMode,
    locale,
    textScale,
    notificationsEnabled,
    borderRadius,
    fontFamily,
    biometricEnabled,
    periodRemindersEnabled,
    ovulationRemindersEnabled,
    reminderDaysBefore,
    reminderTime,
  ];
}
