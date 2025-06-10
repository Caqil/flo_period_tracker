import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';

import '../entities/app_settings.dart';
import '../entities/notification_settings.dart';
import '../repositories/settings_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

@injectable
class UpdateSettingsUsecase implements UseCase<void, UpdateSettingsParams> {
  final SettingsRepository _repository;

  UpdateSettingsUsecase(this._repository);

  @override
  Future<Either<Failure, void>> call(UpdateSettingsParams params) async {
    if (params.appSettings != null) {
      final result = await _repository.updateAppSettings(params.appSettings!);
      if (result.isLeft()) return result;
    }

    if (params.notificationSettings != null) {
      final result = await _repository.updateNotificationSettings(
        params.notificationSettings!,
      );
      if (result.isLeft()) return result;
    }

    return const Right(null);
  }
}

@injectable
class UpdateAppSettingsUsecase implements UseCase<void, AppSettings> {
  final SettingsRepository _repository;

  UpdateAppSettingsUsecase(this._repository);

  @override
  Future<Either<Failure, void>> call(AppSettings settings) async {
    return await _repository.updateAppSettings(settings);
  }
}

@injectable
class UpdateNotificationSettingsUsecase
    implements UseCase<void, NotificationSettings> {
  final SettingsRepository _repository;

  UpdateNotificationSettingsUsecase(this._repository);

  @override
  Future<Either<Failure, void>> call(NotificationSettings settings) async {
    return await _repository.updateNotificationSettings(settings);
  }
}

class UpdateSettingsParams extends Equatable {
  final AppSettings? appSettings;
  final NotificationSettings? notificationSettings;

  const UpdateSettingsParams({this.appSettings, this.notificationSettings});

  const UpdateSettingsParams.app(AppSettings settings)
    : appSettings = settings,
      notificationSettings = null;

  const UpdateSettingsParams.notifications(NotificationSettings settings)
    : appSettings = null,
      notificationSettings = settings;

  const UpdateSettingsParams.all(
    AppSettings this.appSettings,
    NotificationSettings this.notificationSettings,
  );

  @override
  List<Object?> get props => [appSettings, notificationSettings];
}
