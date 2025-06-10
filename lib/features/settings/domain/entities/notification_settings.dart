import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class NotificationSettings extends Equatable {
  final bool notificationsEnabled;
  final bool periodRemindersEnabled;
  final bool ovulationRemindersEnabled;
  final bool symptomRemindersEnabled;
  final bool moodRemindersEnabled;
  final int reminderDaysBefore;
  final TimeOfDay reminderTime;
  final bool soundEnabled;
  final bool vibrationEnabled;
  final String soundPath;
  final bool badgeEnabled;
  final bool lockScreenEnabled;
  final List<int> reminderFrequency; // Days of week (1-7)

  const NotificationSettings({
    this.notificationsEnabled = true,
    this.periodRemindersEnabled = true,
    this.ovulationRemindersEnabled = true,
    this.symptomRemindersEnabled = false,
    this.moodRemindersEnabled = false,
    this.reminderDaysBefore = 3,
    this.reminderTime = const TimeOfDay(hour: 9, minute: 0),
    this.soundEnabled = true,
    this.vibrationEnabled = true,
    this.soundPath = 'default',
    this.badgeEnabled = true,
    this.lockScreenEnabled = true,
    this.reminderFrequency = const [1, 2, 3, 4, 5, 6, 7], // Daily
  });

  NotificationSettings copyWith({
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
    return NotificationSettings(
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

  @override
  List<Object> get props => [
    notificationsEnabled,
    periodRemindersEnabled,
    ovulationRemindersEnabled,
    symptomRemindersEnabled,
    moodRemindersEnabled,
    reminderDaysBefore,
    reminderTime,
    soundEnabled,
    vibrationEnabled,
    soundPath,
    badgeEnabled,
    lockScreenEnabled,
    reminderFrequency,
  ];
}
