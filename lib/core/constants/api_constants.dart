class ApiConstants {
  // External service endpoints (if needed for health integrations)
  static const String healthKitBaseUrl =
      'https://developer.apple.com/health-fitness/';
  static const String googleFitBaseUrl = 'https://developers.google.com/fit';

  // Analytics services (if using external analytics)
  static const String firebaseAnalyticsUrl =
      'https://firebase.google.com/products/analytics';

  // Backup service endpoints (if cloud backup is implemented)
  static const String iCloudBackupUrl = 'https://developer.apple.com/icloud/';
  static const String googleDriveBackupUrl =
      'https://developers.google.com/drive';

  // Content delivery (if fetching educational content)
  static const String educationalContentUrl = 'https://content.floapp.com';

  // App store URLs
  static const String appStoreUrl =
      'https://apps.apple.com/app/flo-period-tracker';
  static const String playStoreUrl =
      'https://play.google.com/store/apps/details?id=com.flo.period.tracker';

  // Support and legal URLs
  static const String supportUrl = 'https://support.floapp.com';
  static const String privacyPolicyUrl = 'https://floapp.com/privacy';
  static const String termsOfServiceUrl = 'https://floapp.com/terms';
  static const String contactUsUrl = 'https://floapp.com/contact';

  // Social media URLs
  static const String facebookUrl = 'https://facebook.com/floapp';
  static const String twitterUrl = 'https://twitter.com/floapp';
  static const String instagramUrl = 'https://instagram.com/floapp';

  // Request timeouts (for external services)
  static const int connectTimeout = 10;
  static const int receiveTimeout = 10;
  static const int sendTimeout = 10;
}
