import 'package:dartz/dartz.dart';
import '../entities/period.dart';
import '../entities/cycle.dart';
import '../../../../core/error/failures.dart';

abstract class PeriodRepository {
  Future<Either<Failure, Period>> logPeriod(Period period);
  Future<Either<Failure, Cycle?>> getCurrentCycle();
  Future<Either<Failure, DateTime>> predictNextPeriod();
  Future<Either<Failure, List<Period>>> getAllPeriods();
  Future<Either<Failure, void>> updatePeriod(Period period);
  Future<Either<Failure, void>> deletePeriod(String periodId);
}
