part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  final ThemeMode themeMode;
  final Locale locale;
  final double textScale;
  final bool notificationsEnabled;
  final double borderRadius;
  final String fontFamily;
  final bool isLoaded;

  const SettingsState({
    this.themeMode = ThemeMode.system,
    this.locale = const Locale('en'),
    this.textScale = 1.0,
    this.notificationsEnabled = true,
    this.borderRadius = 8.0,
    this.fontFamily = 'GeistSans',
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
    bool? isLoaded,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      textScale: textScale ?? this.textScale,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      borderRadius: borderRadius ?? this.borderRadius,
      fontFamily: fontFamily ?? this.fontFamily,
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
    isLoaded,
  ];
}
