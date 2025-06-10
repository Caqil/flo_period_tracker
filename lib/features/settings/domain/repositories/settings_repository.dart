import 'package:dartz/dartz.dart';

import '../entities/app_settings.dart';
import '../entities/notification_settings.dart';
import '../../../../core/error/failures.dart';

abstract class SettingsRepository {
  Future<Either<Failure, AppSettings>> getAppSettings();
  Future<Either<Failure, NotificationSettings>> getNotificationSettings();
  Future<Either<Failure, void>> updateAppSettings(AppSettings settings);
  Future<Either<Failure, void>> updateNotificationSettings(
    NotificationSettings settings,
  );
  Future<Either<Failure, void>> resetAllSettings();
  Future<Either<Failure, void>> resetAppSettings();
  Future<Either<Failure, void>> resetNotificationSettings();
}
