part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class SettingsLoadRequested extends SettingsEvent {
  const SettingsLoadRequested();
}

class SettingsThemeChanged extends SettingsEvent {
  final ThemeMode themeMode;

  const SettingsThemeChanged(this.themeMode);

  @override
  List<Object> get props => [themeMode];
}

class SettingsLanguageChanged extends SettingsEvent {
  final Locale locale;

  const SettingsLanguageChanged(this.locale);

  @override
  List<Object> get props => [locale];
}

class SettingsTextScaleChanged extends SettingsEvent {
  final double textScale;

  const SettingsTextScaleChanged(this.textScale);

  @override
  List<Object> get props => [textScale];
}

class SettingsNotificationsChanged extends SettingsEvent {
  final bool enabled;

  const SettingsNotificationsChanged(this.enabled);

  @override
  List<Object> get props => [enabled];
}

class SettingsBorderRadiusChanged extends SettingsEvent {
  final double borderRadius;

  const SettingsBorderRadiusChanged(this.borderRadius);

  @override
  List<Object> get props => [borderRadius];
}

class SettingsFontFamilyChanged extends SettingsEvent {
  final String fontFamily;

  const SettingsFontFamilyChanged(this.fontFamily);

  @override
  List<Object> get props => [fontFamily];
}

class SettingsBiometricChanged extends SettingsEvent {
  final bool enabled;

  const SettingsBiometricChanged(this.enabled);

  @override
  List<Object> get props => [enabled];
}

class SettingsPeriodRemindersChanged extends SettingsEvent {
  final bool enabled;

  const SettingsPeriodRemindersChanged(this.enabled);

  @override
  List<Object> get props => [enabled];
}

class SettingsOvulationRemindersChanged extends SettingsEvent {
  final bool enabled;

  const SettingsOvulationRemindersChanged(this.enabled);

  @override
  List<Object> get props => [enabled];
}

class SettingsReminderDaysChanged extends SettingsEvent {
  final int days;

  const SettingsReminderDaysChanged(this.days);

  @override
  List<Object> get props => [days];
}

class SettingsReminderTimeChanged extends SettingsEvent {
  final TimeOfDay time;

  const SettingsReminderTimeChanged(this.time);

  @override
  List<Object> get props => [time];
}
