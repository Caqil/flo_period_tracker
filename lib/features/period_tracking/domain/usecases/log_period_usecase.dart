// lib/features/period_tracking/domain/usecases/log_period_usecase.dart

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import '../entities/period.dart';
import '../repositories/period_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

@injectable
class LogPeriodUsecase implements UseCase<Period, LogPeriodParams> {
  final PeriodRepository _repository;

  LogPeriodUsecase(this._repository);

  @override
  Future<Either<Failure, Period>> call(LogPeriodParams params) async {
    final period = Period(
      id: const Uuid().v4(),
      startDate: params.startDate,
      endDate: params.endDate,
      flowIntensity: params.flowIntensity,
      notes: params.notes,
      isConfirmed: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    return await _repository.logPeriod(period);
  }
}

class LogPeriodParams extends Equatable {
  final DateTime startDate;
  final DateTime? endDate;
  final String flowIntensity;
  final String? notes;

  const LogPeriodParams({
    required this.startDate,
    this.endDate,
    required this.flowIntensity,
    this.notes,
  });

  @override
  List<Object?> get props => [startDate, endDate, flowIntensity, notes];
}
