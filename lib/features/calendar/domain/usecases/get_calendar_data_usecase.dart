import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';

import '../entities/calendar_day.dart';
import '../repositories/calendar_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

@injectable
class GetCalendarDataUsecase
    implements UseCase<List<CalendarDay>, GetCalendarDataParams> {
  final CalendarRepository _repository;

  GetCalendarDataUsecase(this._repository);

  @override
  Future<Either<Failure, List<CalendarDay>>> call(
    GetCalendarDataParams params,
  ) async {
    return await _repository.getCalendarData(
      startDate: params.startDate,
      endDate: params.endDate,
    );
  }
}

class GetCalendarDataParams extends Equatable {
  final DateTime startDate;
  final DateTime endDate;

  const GetCalendarDataParams({required this.startDate, required this.endDate});

  @override
  List<Object> get props => [startDate, endDate];
}
