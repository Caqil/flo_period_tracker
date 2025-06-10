import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/app_settings.dart';
import '../../domain/entities/notification_settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_local_datasource.dart';
import '../models/app_settings_model.dart';
import '../models/notification_settings_model.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';

@LazySingleton(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDatasource _localDatasource;

  SettingsRepositoryImpl(this._localDatasource);

  @override
  Future<Either<Failure, AppSettings>> getAppSettings() async {
    try {
      final settings = await _localDatasource.getSettings();
      return Right(settings);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, NotificationSettings>>
  getNotificationSettings() async {
    try {
      final appSettings = await _localDatasource.getSettings();

      // Extract notification-related settings from app settings
      final notificationSettings = NotificationSettings(
        notificationsEnabled: appSettings.notificationsEnabled,
        periodRemindersEnabled: appSettings.periodRemindersEnabled,
        ovulationRemindersEnabled: appSettings.ovulationRemindersEnabled,
        reminderDaysBefore: appSettings.reminderDaysBefore,
        reminderTime: appSettings.reminderTime,
        // Use defaults for other notification settings
        symptomRemindersEnabled: false,
        moodRemindersEnabled: false,
        soundEnabled: true,
        vibrationEnabled: true,
        soundPath: 'default',
        badgeEnabled: true,
        lockScreenEnabled: true,
        reminderFrequency: const [1, 2, 3, 4, 5, 6, 7],
      );

      return Right(notificationSettings);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateAppSettings(AppSettings settings) async {
    try {
      await _localDatasource.saveSettings(settings);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateNotificationSettings(
    NotificationSettings notificationSettings,
  ) async {
    try {
      // Get current app settings
      final currentAppSettings = await _localDatasource.getSettings();

      // Merge notification settings with app settings
      final updatedAppSettings = currentAppSettings.copyWith(
        notificationsEnabled: notificationSettings.notificationsEnabled,
        periodRemindersEnabled: notificationSettings.periodRemindersEnabled,
        ovulationRemindersEnabled:
            notificationSettings.ovulationRemindersEnabled,
        reminderDaysBefore: notificationSettings.reminderDaysBefore,
        reminderTime: notificationSettings.reminderTime,
      );

      await _localDatasource.saveSettings(updatedAppSettings);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resetAllSettings() async {
    try {
      await _localDatasource.resetSettings();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resetAppSettings() async {
    try {
      // Get current settings to preserve notification-specific ones
      final currentSettings = await _localDatasource.getSettings();

      // Create default app settings while preserving notification settings
      const defaultAppSettings = AppSettings();
      final resetSettings = defaultAppSettings.copyWith(
        notificationsEnabled: currentSettings.notificationsEnabled,
        periodRemindersEnabled: currentSettings.periodRemindersEnabled,
        ovulationRemindersEnabled: currentSettings.ovulationRemindersEnabled,
        reminderDaysBefore: currentSettings.reminderDaysBefore,
        reminderTime: currentSettings.reminderTime,
      );

      await _localDatasource.saveSettings(resetSettings);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resetNotificationSettings() async {
    try {
      // Get current settings
      final currentSettings = await _localDatasource.getSettings();

      // Reset only notification-related settings to defaults
      const defaultNotificationSettings = NotificationSettings();
      final resetSettings = currentSettings.copyWith(
        notificationsEnabled: defaultNotificationSettings.notificationsEnabled,
        periodRemindersEnabled:
            defaultNotificationSettings.periodRemindersEnabled,
        ovulationRemindersEnabled:
            defaultNotificationSettings.ovulationRemindersEnabled,
        reminderDaysBefore: defaultNotificationSettings.reminderDaysBefore,
        reminderTime: defaultNotificationSettings.reminderTime,
      );

      await _localDatasource.saveSettings(resetSettings);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
}
