// lib/features/period_tracking/data/repositories/period_repository_impl.dart

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/period.dart';
import '../../domain/entities/cycle.dart';
import '../../domain/repositories/period_repository.dart';
import '../datasources/period_local_datasource.dart';
import '../models/period_model.dart';
import '../models/cycle_model.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';

@LazySingleton(as: PeriodRepository)
class PeriodRepositoryImpl implements PeriodRepository {
  final PeriodLocalDatasource _localDatasource;

  PeriodRepositoryImpl(this._localDatasource);

  @override
  Future<Either<Failure, Period>> logPeriod(Period period) async {
    try {
      final periodModel = PeriodModel.fromEntity(period);
      final result = await _localDatasource.logPeriod(periodModel);
      return Right(result.toEntity());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Cycle?>> getCurrentCycle() async {
    try {
      final periods = await _localDatasource.getAllPeriods();
      if (periods.isEmpty) {
        return const Right(null);
      }

      // Sort periods by start date
      periods.sort((a, b) => b.startDate.compareTo(a.startDate));
      final lastPeriod = periods.first;

      // Calculate average cycle length
      double avgCycleLength = 28.0;
      if (periods.length > 1) {
        final cycleLengths = <int>[];
        for (int i = 0; i < periods.length - 1; i++) {
          final cycleLength = periods[i].startDate
              .difference(periods[i + 1].startDate)
              .inDays;
          if (cycleLength > 0 && cycleLength <= 45) {
            cycleLengths.add(cycleLength);
          }
        }
        if (cycleLengths.isNotEmpty) {
          avgCycleLength =
              cycleLengths.reduce((a, b) => a + b) / cycleLengths.length;
        }
      }

      // Calculate cycle dates
      final cycleStart = lastPeriod.startDate;
      final nextPeriodDate = cycleStart.add(
        Duration(days: avgCycleLength.round()),
      );
      final ovulationDate = cycleStart.add(
        Duration(days: (avgCycleLength - 14).round()),
      );
      final fertileStart = ovulationDate.subtract(const Duration(days: 5));
      final fertileEnd = ovulationDate.add(const Duration(days: 1));

      final cycle = Cycle(
        id: const Uuid().v4(),
        startDate: cycleStart,
        endDate: nextPeriodDate,
        length: avgCycleLength.round(),
        periods: periods.map((p) => p.toEntity()).toList(),
        ovulationDate: ovulationDate,
        fertileWindowStart: fertileStart,
        fertileWindowEnd: fertileEnd,
        isComplete: false,
        createdAt: DateTime.now(),
      );

      return Right(cycle);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, DateTime>> predictNextPeriod() async {
    try {
      final currentCycleResult = await getCurrentCycle();

      return currentCycleResult.fold((failure) => Left(failure), (cycle) {
        if (cycle == null) {
          return Left(const DataFailure(message: 'No cycle data available'));
        }

        final prediction = cycle.startDate.add(Duration(days: cycle.length));
        return Right(prediction);
      });
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Period>>> getAllPeriods() async {
    try {
      final periods = await _localDatasource.getAllPeriods();
      return Right(periods.map((p) => p.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updatePeriod(Period period) async {
    try {
      final periodModel = PeriodModel.fromEntity(period);
      await _localDatasource.updatePeriod(periodModel);
      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deletePeriod(String periodId) async {
    try {
      await _localDatasource.deletePeriod(periodId);
      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
}
