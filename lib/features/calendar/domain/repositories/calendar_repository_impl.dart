// lib/features/calendar/data/repositories/calendar_repository_impl.dart

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../data/datasources/calendar_local_datasource.dart';
import '../../domain/entities/calendar_day.dart';
import '../../domain/repositories/calendar_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';

@LazySingleton(as: CalendarRepository)
class CalendarRepositoryImpl implements CalendarRepository {
  final CalendarLocalDatasource _localDatasource;

  CalendarRepositoryImpl(this._localDatasource);

  @override
  Future<Either<Failure, List<CalendarDay>>> getCalendarData({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final calendarData = await _localDatasource.getCalendarData(
        startDate: startDate,
        endDate: endDate,
      );
      return Right(calendarData);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CalendarDay>> getDayDetails(DateTime date) async {
    try {
      final dayDetails = await _localDatasource.getDayDetails(date);
      return Right(dayDetails);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
}
