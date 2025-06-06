import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import '../entities/user_profile.dart';
import '../repositories/user_profile_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

@injectable
class SetupProfileUsecase implements UseCase<UserProfile, SetupProfileParams> {
  final UserProfileRepository _repository;

  SetupProfileUsecase(this._repository);

  @override
  Future<Either<Failure, UserProfile>> call(SetupProfileParams params) async {
    final profile = UserProfile(
      id: const Uuid().v4(),
      name: params.name,
      dateOfBirth: params.dateOfBirth,
      averageCycleLength: params.averageCycleLength,
      averagePeriodLength: params.averagePeriodLength,
      lastPeriodDate: params.lastPeriodDate,
      isSetupCompleted: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    return await _repository.createProfile(profile);
  }
}

class SetupProfileParams extends Equatable {
  final String? name;
  final DateTime? dateOfBirth;
  final int averageCycleLength;
  final int averagePeriodLength;
  final DateTime? lastPeriodDate;

  const SetupProfileParams({
    this.name,
    this.dateOfBirth,
    required this.averageCycleLength,
    required this.averagePeriodLength,
    this.lastPeriodDate,
  });

  @override
  List<Object?> get props => [
    name,
    dateOfBirth,
    averageCycleLength,
    averagePeriodLength,
    lastPeriodDate,
  ];
}
