import 'package:dartz/dartz.dart';

import '../entities/calendar_day.dart';
import '../../../../core/error/failures.dart';

abstract class CalendarRepository {
  Future<Either<Failure, List<CalendarDay>>> getCalendarData({
    required DateTime startDate,
    required DateTime endDate,
  });

  Future<Either<Failure, CalendarDay>> getDayDetails(DateTime date);
}
