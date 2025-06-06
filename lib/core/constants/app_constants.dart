class AppConstants {
  // App Information
  static const String appName = 'Flo';
  static const String appFullName = 'Flo Period Tracker';
  static const String appTagline = 'Your period tracking companion';
  static const String appVersion = '1.0.0';
  static const String buildNumber = '1';
  static const String packageName = 'com.flo.period.tracker';

  // Database
  static const String databaseName = 'app_database.db';
  static const int databaseVersion = 1;

  // Default Values
  static const int defaultCycleLength = 28;
  static const int defaultPeriodLength = 5;
  static const int minCycleLength = 21;
  static const int maxCycleLength = 35;
  static const int minPeriodLength = 1;
  static const int maxPeriodLength = 10;

  // Cycle Phases (in days)
  static const int menstrualPhaseStart = 1;
  static const int follicularPhaseStart = 1;
  static const int ovulationDay = 14; // Estimated for 28-day cycle
  static const int lutealPhaseStart = 15;
  static const int fertileWindowStart = 10; // 5 days before ovulation
  static const int fertileWindowEnd = 16; // 1 day after ovulation

  // Flow Intensity Levels
  static const List<String> flowIntensities = [
    'spotting',
    'light',
    'medium',
    'heavy',
  ];

  // Symptom Intensity Scale
  static const int minSymptomIntensity = 1;
  static const int maxSymptomIntensity = 5;

  // Mood Intensity Scale
  static const int minMoodIntensity = 1;
  static const int maxMoodIntensity = 5;

  // Notification Settings
  static const int defaultReminderDaysBefore = 3;
  static const String defaultReminderTime = '09:00';
  static const int maxNotificationId = 999999;

  // Animation Durations
  static const int shortAnimationDuration = 300;
  static const int mediumAnimationDuration = 500;
  static const int longAnimationDuration = 1000;
  static const int splashScreenDuration = 2000;

  // UI Constants
  static const double defaultBorderRadius = 8.0;
  static const double defaultTextScale = 1.0;
  static const double minTextScale = 0.8;
  static const double maxTextScale = 1.4;
  static const String defaultFontFamily = 'GeistSans';

  // Calendar Constants
  static const int calendarLoadDaysAhead = 90;
  static const int calendarLoadDaysBehind = 90;
  static const int maxCycleHistoryYears = 5;

  // Data Limits
  static const int maxNoteLength = 500;
  static const int maxCycleHistory = 100;
  static const int maxSymptomHistory = 365;
  static const int maxMoodHistory = 365;

  // Export Settings
  static const String exportDateFormat = 'yyyy-MM-dd';
  static const String displayDateFormat = 'MMM d, yyyy';
  static const String timeFormat = 'HH:mm';
  static const String displayTimeFormat = 'h:mm a';

  // Backup Settings
  static const int maxBackupSize = 50 * 1024 * 1024; // 50MB
  static const String backupFileExtension = '.flo';
  static const String backupMimeType = 'application/json';

  // Analytics Events
  static const String eventPeriodLogged = 'period_logged';
  static const String eventSymptomLogged = 'symptom_logged';
  static const String eventMoodLogged = 'mood_logged';
  static const String eventReminderSet = 'reminder_set';
  static const String eventDataExported = 'data_exported';
  static const String eventOnboardingCompleted = 'onboarding_completed';

  // Supported Locales
  static const List<String> supportedLanguages = [
    'en', // English
    'es', // Spanish
    'fr', // French
    'de', // German
  ];

  // Feature Flags
  static const bool enableHealthKitIntegration = false;
  static const bool enableGoogleFitIntegration = false;
  static const bool enableCloudBackup = false;
  static const bool enableAnalytics = true;
  static const bool enableCrashReporting = true;
  static const bool enableBiometricAuth = true;

  // Error Messages
  static const String genericErrorMessage =
      'Something went wrong. Please try again.';
  static const String networkErrorMessage =
      'No internet connection. Please check your network.';
  static const String validationErrorMessage =
      'Please check your input and try again.';

  // Success Messages
  static const String periodLoggedMessage = 'Period logged successfully';
  static const String symptomLoggedMessage = 'Symptom logged successfully';
  static const String moodLoggedMessage = 'Mood logged successfully';
  static const String settingsSavedMessage = 'Settings saved successfully';
  static const String reminderSetMessage = 'Reminder set successfully';

  // Onboarding
  static const int maxOnboardingSteps = 5;
  static const String onboardingCompletedKey = 'onboarding_completed';
}
