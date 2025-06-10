part of 'settings_bloc.dart';

class SettingsState extends Equatable {
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
  final bool isLoaded;

  const SettingsState({
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
    this.isLoaded = false,
  });

  bool get isDarkMode {
    if (themeMode == ThemeMode.dark) return true;
    if (themeMode == ThemeMode.light) return false;

    // For system mode, we'd need to check the system theme
    // This is simplified for this example
    return false;
  }

  SettingsState copyWith({
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
    bool? isLoaded,
  }) {
    return SettingsState(
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
      isLoaded: isLoaded ?? this.isLoaded,
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
    isLoaded,
  ];
}
