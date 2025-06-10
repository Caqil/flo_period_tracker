import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';

import '../entities/app_settings.dart';
import '../entities/notification_settings.dart';
import '../repositories/settings_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

@injectable
class GetSettingsUsecase implements UseCase<SettingsData, GetSettingsParams> {
  final SettingsRepository _repository;

  GetSettingsUsecase(this._repository);

  @override
  Future<Either<Failure, SettingsData>> call(GetSettingsParams params) async {
    switch (params.settingsType) {
      case SettingsType.app:
        final result = await _repository.getAppSettings();
        return result.fold(
          (failure) => Left(failure),
          (appSettings) => Right(SettingsData.app(appSettings)),
        );

      case SettingsType.notifications:
        final result = await _repository.getNotificationSettings();
        return result.fold(
          (failure) => Left(failure),
          (notificationSettings) =>
              Right(SettingsData.notifications(notificationSettings)),
        );

      case SettingsType.all:
        final appResult = await _repository.getAppSettings();
        return appResult.fold((failure) => Left(failure), (appSettings) async {
          final notificationResult = await _repository
              .getNotificationSettings();
          return notificationResult.fold(
            (failure) => Left(failure),
            (notificationSettings) =>
                Right(SettingsData.all(appSettings, notificationSettings)),
          );
        });
    }
  }
}

@injectable
class GetAppSettingsUsecase implements UseCase<AppSettings, NoParams> {
  final SettingsRepository _repository;

  GetAppSettingsUsecase(this._repository);

  @override
  Future<Either<Failure, AppSettings>> call(NoParams params) async {
    return await _repository.getAppSettings();
  }
}

@injectable
class GetNotificationSettingsUsecase
    implements UseCase<NotificationSettings, NoParams> {
  final SettingsRepository _repository;

  GetNotificationSettingsUsecase(this._repository);

  @override
  Future<Either<Failure, NotificationSettings>> call(NoParams params) async {
    return await _repository.getNotificationSettings();
  }
}

class GetSettingsParams extends Equatable {
  final SettingsType settingsType;

  const GetSettingsParams({required this.settingsType});

  @override
  List<Object> get props => [settingsType];
}

enum SettingsType { app, notifications, all }

class SettingsData extends Equatable {
  final AppSettings? appSettings;
  final NotificationSettings? notificationSettings;
  final SettingsType type;

  const SettingsData._({
    this.appSettings,
    this.notificationSettings,
    required this.type,
  });

  factory SettingsData.app(AppSettings appSettings) {
    return SettingsData._(appSettings: appSettings, type: SettingsType.app);
  }

  factory SettingsData.notifications(
    NotificationSettings notificationSettings,
  ) {
    return SettingsData._(
      notificationSettings: notificationSettings,
      type: SettingsType.notifications,
    );
  }

  factory SettingsData.all(
    AppSettings appSettings,
    NotificationSettings notificationSettings,
  ) {
    return SettingsData._(
      appSettings: appSettings,
      notificationSettings: notificationSettings,
      type: SettingsType.all,
    );
  }

  @override
  List<Object?> get props => [appSettings, notificationSettings, type];
}
