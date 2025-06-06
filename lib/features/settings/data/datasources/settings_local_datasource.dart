import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/entities/app_settings.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/constants/storage_keys.dart';

abstract class SettingsLocalDatasource {
  Future<AppSettings> getSettings();
  Future<void> saveSettings(AppSettings settings);
  Future<void> resetSettings();
}

@LazySingleton(as: SettingsLocalDatasource)
class SettingsLocalDatasourceImpl implements SettingsLocalDatasource {
  late final Box _settingsBox;

  SettingsLocalDatasourceImpl() {
    _initBox();
  }

  Future<void> _initBox() async {
    _settingsBox = await Hive.openBox(StorageKeys.settingsBox);
  }

  @override
  Future<AppSettings> getSettings() async {
    try {
      final themeMode = _settingsBox.get(
        StorageKeys.themeMode,
        defaultValue: 'system',
      );
      final locale = _settingsBox.get(StorageKeys.locale, defaultValue: 'en');
      final textScale = _settingsBox.get(
        StorageKeys.textScale,
        defaultValue: 1.0,
      );
      final notificationsEnabled = _settingsBox.get(
        StorageKeys.notificationsEnabled,
        defaultValue: true,
      );
      final borderRadius = _settingsBox.get(
        StorageKeys.borderRadius,
        defaultValue: 8.0,
      );
      final fontFamily = _settingsBox.get(
        StorageKeys.fontFamily,
        defaultValue: 'GeistSans',
      );

      return AppSettings(
        themeMode: _parseThemeMode(themeMode),
        locale: Locale(locale),
        textScale: textScale,
        notificationsEnabled: notificationsEnabled,
        borderRadius: borderRadius,
        fontFamily: fontFamily,
      );
    } catch (e) {
      throw CacheException(message: 'Failed to get settings: $e');
    }
  }

  @override
  Future<void> saveSettings(AppSettings settings) async {
    try {
      await _settingsBox.putAll({
        StorageKeys.themeMode: settings.themeMode.name,
        StorageKeys.locale: settings.locale.languageCode,
        StorageKeys.textScale: settings.textScale,
        StorageKeys.notificationsEnabled: settings.notificationsEnabled,
        StorageKeys.borderRadius: settings.borderRadius,
        StorageKeys.fontFamily: settings.fontFamily,
      });
    } catch (e) {
      throw CacheException(message: 'Failed to save settings: $e');
    }
  }

  @override
  Future<void> resetSettings() async {
    try {
      await _settingsBox.clear();
    } catch (e) {
      throw CacheException(message: 'Failed to reset settings: $e');
    }
  }

  ThemeMode _parseThemeMode(String themeMode) {
    switch (themeMode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
