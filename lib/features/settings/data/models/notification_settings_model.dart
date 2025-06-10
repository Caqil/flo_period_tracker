import 'package:flutter/material.dart';

import '../../domain/entities/notification_settings.dart';

class NotificationSettingsModel extends NotificationSettings {
  const NotificationSettingsModel({
    required super.notificationsEnabled,
    required super.periodRemindersEnabled,
    required super.ovulationRemindersEnabled,
    required super.symptomRemindersEnabled,
    required super.moodRemindersEnabled,
    required super.reminderDaysBefore,
    required super.reminderTime,
    required super.soundEnabled,
    required super.vibrationEnabled,
    required super.soundPath,
    required super.badgeEnabled,
    required super.lockScreenEnabled,
    required super.reminderFrequency,
  });

  factory NotificationSettingsModel.fromEntity(NotificationSettings settings) {
    return NotificationSettingsModel(
      notificationsEnabled: settings.notificationsEnabled,
      periodRemindersEnabled: settings.periodRemindersEnabled,
      ovulationRemindersEnabled: settings.ovulationRemindersEnabled,
      symptomRemindersEnabled: settings.symptomRemindersEnabled,
      moodRemindersEnabled: settings.moodRemindersEnabled,
      reminderDaysBefore: settings.reminderDaysBefore,
      reminderTime: settings.reminderTime,
      soundEnabled: settings.soundEnabled,
      vibrationEnabled: settings.vibrationEnabled,
      soundPath: settings.soundPath,
      badgeEnabled: settings.badgeEnabled,
      lockScreenEnabled: settings.lockScreenEnabled,
      reminderFrequency: settings.reminderFrequency,
    );
  }

  factory NotificationSettingsModel.fromJson(Map<String, dynamic> json) {
    return NotificationSettingsModel(
      notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
      periodRemindersEnabled: json['periodRemindersEnabled'] as bool? ?? true,
      ovulationRemindersEnabled:
          json['ovulationRemindersEnabled'] as bool? ?? true,
      symptomRemindersEnabled:
          json['symptomRemindersEnabled'] as bool? ?? false,
      moodRemindersEnabled: json['moodRemindersEnabled'] as bool? ?? false,
      reminderDaysBefore: json['reminderDaysBefore'] as int? ?? 3,
      reminderTime: _parseTimeOfDay(json['reminderTime'] as String? ?? '09:00'),
      soundEnabled: json['soundEnabled'] as bool? ?? true,
      vibrationEnabled: json['vibrationEnabled'] as bool? ?? true,
      soundPath: json['soundPath'] as String? ?? 'default',
      badgeEnabled: json['badgeEnabled'] as bool? ?? true,
      lockScreenEnabled: json['lockScreenEnabled'] as bool? ?? true,
      reminderFrequency: _parseReminderFrequency(
        json['reminderFrequency'] as List<dynamic>? ?? [1, 2, 3, 4, 5, 6, 7],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notificationsEnabled': notificationsEnabled,
      'periodRemindersEnabled': periodRemindersEnabled,
      'ovulationRemindersEnabled': ovulationRemindersEnabled,
      'symptomRemindersEnabled': symptomRemindersEnabled,
      'moodRemindersEnabled': moodRemindersEnabled,
      'reminderDaysBefore': reminderDaysBefore,
      'reminderTime': _timeOfDayToString(reminderTime),
      'soundEnabled': soundEnabled,
      'vibrationEnabled': vibrationEnabled,
      'soundPath': soundPath,
      'badgeEnabled': badgeEnabled,
      'lockScreenEnabled': lockScreenEnabled,
      'reminderFrequency': reminderFrequency,
    };
  }

  NotificationSettings toEntity() {
    return NotificationSettings(
      notificationsEnabled: notificationsEnabled,
      periodRemindersEnabled: periodRemindersEnabled,
      ovulationRemindersEnabled: ovulationRemindersEnabled,
      symptomRemindersEnabled: symptomRemindersEnabled,
      moodRemindersEnabled: moodRemindersEnabled,
      reminderDaysBefore: reminderDaysBefore,
      reminderTime: reminderTime,
      soundEnabled: soundEnabled,
      vibrationEnabled: vibrationEnabled,
      soundPath: soundPath,
      badgeEnabled: badgeEnabled,
      lockScreenEnabled: lockScreenEnabled,
      reminderFrequency: reminderFrequency,
    );
  }

  NotificationSettingsModel copyWith({
    bool? notificationsEnabled,
    bool? periodRemindersEnabled,
    bool? ovulationRemindersEnabled,
    bool? symptomRemindersEnabled,
    bool? moodRemindersEnabled,
    int? reminderDaysBefore,
    TimeOfDay? reminderTime,
    bool? soundEnabled,
    bool? vibrationEnabled,
    String? soundPath,
    bool? badgeEnabled,
    bool? lockScreenEnabled,
    List<int>? reminderFrequency,
  }) {
    return NotificationSettingsModel(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      periodRemindersEnabled:
          periodRemindersEnabled ?? this.periodRemindersEnabled,
      ovulationRemindersEnabled:
          ovulationRemindersEnabled ?? this.ovulationRemindersEnabled,
      symptomRemindersEnabled:
          symptomRemindersEnabled ?? this.symptomRemindersEnabled,
      moodRemindersEnabled: moodRemindersEnabled ?? this.moodRemindersEnabled,
      reminderDaysBefore: reminderDaysBefore ?? this.reminderDaysBefore,
      reminderTime: reminderTime ?? this.reminderTime,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
      soundPath: soundPath ?? this.soundPath,
      badgeEnabled: badgeEnabled ?? this.badgeEnabled,
      lockScreenEnabled: lockScreenEnabled ?? this.lockScreenEnabled,
      reminderFrequency: reminderFrequency ?? this.reminderFrequency,
    );
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

  static List<int> _parseReminderFrequency(List<dynamic> frequency) {
    try {
      return frequency.cast<int>();
    } catch (e) {
      return [1, 2, 3, 4, 5, 6, 7]; // Default to daily
    }
  }
}
