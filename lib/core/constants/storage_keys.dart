class StorageKeys {
  // User Authentication & Profile
  static const String userToken = 'user_token';
  static const String userId = 'user_id';
  static const String userEmail = 'user_email';
  static const String userName = 'user_name';
  static const String userProfileImage = 'user_profile_image';
  static const String isLoggedIn = 'is_logged_in';
  static const String biometricEnabled = 'biometric_enabled';
  static const String lastLoginDate = 'last_login_date';

  // Onboarding & First Time Setup
  static const String isOnboardingCompleted = 'is_onboarding_completed';
  static const String isFirstLaunch = 'is_first_launch';
  static const String onboardingStep = 'onboarding_step';
  static const String hasSeenWelcome = 'has_seen_welcome';
  static const String hasCompletedCycleSetup = 'has_completed_cycle_setup';

  // User Cycle Settings
  static const String averageCycleLength = 'average_cycle_length';
  static const String averagePeriodLength = 'average_period_length';
  static const String lastPeriodStartDate = 'last_period_start_date';
  static const String lastPeriodEndDate = 'last_period_end_date';
  static const String estimatedNextPeriod = 'estimated_next_period';
  static const String cyclePhase = 'current_cycle_phase';
  static const String cycleDay = 'current_cycle_day';

  // App Settings
  static const String themeMode = 'theme_mode';
  static const String locale = 'app_locale';
  static const String textScale = 'text_scale';
  static const String borderRadius = 'border_radius';
  static const String fontFamily = 'font_family';
  static const String isDarkMode = 'is_dark_mode';

  // Notification Settings
  static const String notificationsEnabled = 'notifications_enabled';
  static const String periodRemindersEnabled = 'period_reminders_enabled';
  static const String ovulationRemindersEnabled = 'ovulation_reminders_enabled';
  static const String symptomRemindersEnabled = 'symptom_reminders_enabled';
  static const String reminderDaysBefore = 'reminder_days_before';
  static const String reminderTime = 'reminder_time';
  static const String notificationSound = 'notification_sound';
  static const String vibrationEnabled = 'vibration_enabled';

  // Privacy Settings
  static const String dataCollectionConsent = 'data_collection_consent';
  static const String analyticsEnabled = 'analytics_enabled';
  static const String crashReportingEnabled = 'crash_reporting_enabled';
  static const String dataRetentionPeriod = 'data_retention_period';
  static const String autoBackupEnabled = 'auto_backup_enabled';

  // Calendar & Display Settings
  static const String calendarFormat = 'calendar_format';
  static const String weekStartDay = 'week_start_day';
  static const String dateFormat = 'date_format';
  static const String timeFormat = 'time_format';
  static const String showFertilityWindow = 'show_fertility_window';
  static const String showOvulationPrediction = 'show_ovulation_prediction';
  static const String showSymptomMarkers = 'show_symptom_markers';

  // Data Cache Keys
  static const String cachedPeriods = 'cached_periods';
  static const String cachedSymptoms = 'cached_symptoms';
  static const String cachedMoods = 'cached_moods';
  static const String cachedAnalytics = 'cached_analytics';
  static const String cachedPredictions = 'cached_predictions';
  static const String lastDataSync = 'last_data_sync';
  static const String cacheExpiry = 'cache_expiry';

  // Backup & Export
  static const String lastBackupDate = 'last_backup_date';
  static const String backupFrequency = 'backup_frequency';
  static const String backupLocation = 'backup_location';
  static const String exportFormat = 'export_format';
  static const String autoExportEnabled = 'auto_export_enabled';
  static const String cloudBackupEnabled = 'cloud_backup_enabled';

  // App Usage Statistics
  static const String appLaunchCount = 'app_launch_count';
  static const String lastAppVersion = 'last_app_version';
  static const String installDate = 'install_date';
  static const String periodsLoggedCount = 'periods_logged_count';
  static const String symptomsLoggedCount = 'symptoms_logged_count';
  static const String moodsLoggedCount = 'moods_logged_count';
  static const String streakDays = 'streak_days';
  static const String longestStreak = 'longest_streak';

  // Health Integration
  static const String healthKitEnabled = 'health_kit_enabled';
  static const String googleFitEnabled = 'google_fit_enabled';
  static const String healthDataSyncEnabled = 'health_data_sync_enabled';
  static const String lastHealthSync = 'last_health_sync';

  // Tips & Education
  static const String hasSeenTip = 'has_seen_tip_';
  static const String tipsEnabled = 'tips_enabled';
  static const String educationalContentViewed = 'educational_content_viewed';
  static const String lastTipShown = 'last_tip_shown';
  static const String tipFrequency = 'tip_frequency';

  // Debug & Development
  static const String debugMode = 'debug_mode';
  static const String logLevel = 'log_level';
  static const String crashLogsEnabled = 'crash_logs_enabled';
  static const String testModeEnabled = 'test_mode_enabled';

  // Feature Flags
  static const String betaFeaturesEnabled = 'beta_features_enabled';
  static const String experimentalCalendar = 'experimental_calendar';
  static const String advancedAnalytics = 'advanced_analytics';
  static const String aiPredictions = 'ai_predictions';

  // Security & Privacy
  static const String appLockEnabled = 'app_lock_enabled';
  static const String lockTimeout = 'lock_timeout';
  static const String fingerprintAuth = 'fingerprint_auth';
  static const String faceIdAuth = 'face_id_auth';
  static const String pinCode = 'pin_code';
  static const String securityQuestionSet = 'security_question_set';

  // Hive Box Names
  static const String userBox = 'user_box';
  static const String settingsBox = 'settings_box';
  static const String periodBox = 'period_box';
  static const String symptomBox = 'symptom_box';
  static const String moodBox = 'mood_box';
  static const String reminderBox = 'reminder_box';
  static const String analyticsBox = 'analytics_box';
  static const String cacheBox = 'cache_box';

  // Hive Type IDs (for object serialization)
  static const int userEntityTypeId = 0;
  static const int periodEntityTypeId = 1;
  static const int symptomEntityTypeId = 2;
  static const int moodEntityTypeId = 3;
  static const int reminderEntityTypeId = 4;
  static const int settingsEntityTypeId = 5;
  static const int cycleEntityTypeId = 6;

  // JSON Keys for import/export
  static const String exportUserData = 'user_data';
  static const String exportPeriods = 'periods';
  static const String exportSymptoms = 'symptoms';
  static const String exportMoods = 'moods';
  static const String exportSettings = 'settings';
  static const String exportReminders = 'reminders';
  static const String exportMetadata = 'metadata';
  static const String exportVersion = 'export_version';
  static const String exportDate = 'export_date';

  // Utility methods
  static String getTipKey(String tipId) => '$hasSeenTip$tipId';

  static String getCacheKey(String dataType, String identifier) =>
      'cache_${dataType}_$identifier';

  static String getBackupKey(DateTime date) =>
      'backup_${date.toIso8601String()}';

  static String getUserPrefKey(String userId, String key) =>
      'user_${userId}_$key';
}
