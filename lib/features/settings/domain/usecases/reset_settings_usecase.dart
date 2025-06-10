import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';

import '../repositories/settings_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

@injectable
class ResetSettingsUsecase implements UseCase<void, ResetSettingsParams> {
  final SettingsRepository _repository;

  ResetSettingsUsecase(this._repository);

  @override
  Future<Either<Failure, void>> call(ResetSettingsParams params) async {
    switch (params.resetType) {
      case ResetType.all:
        return await _repository.resetAllSettings();
      case ResetType.app:
        return await _repository.resetAppSettings();
      case ResetType.notifications:
        return await _repository.resetNotificationSettings();
    }
  }
}

@injectable
class ResetAllSettingsUsecase implements UseCase<void, NoParams> {
  final SettingsRepository _repository;

  ResetAllSettingsUsecase(this._repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await _repository.resetAllSettings();
  }
}

@injectable
class ResetAppSettingsUsecase implements UseCase<void, NoParams> {
  final SettingsRepository _repository;

  ResetAppSettingsUsecase(this._repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await _repository.resetAppSettings();
  }
}

@injectable
class ResetNotificationSettingsUsecase implements UseCase<void, NoParams> {
  final SettingsRepository _repository;

  ResetNotificationSettingsUsecase(this._repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await _repository.resetNotificationSettings();
  }
}

class ResetSettingsParams extends Equatable {
  final ResetType resetType;

  const ResetSettingsParams({required this.resetType});

  const ResetSettingsParams.all() : resetType = ResetType.all;
  const ResetSettingsParams.app() : resetType = ResetType.app;
  const ResetSettingsParams.notifications()
    : resetType = ResetType.notifications;

  @override
  List<Object> get props => [resetType];
}

enum ResetType { all, app, notifications }
