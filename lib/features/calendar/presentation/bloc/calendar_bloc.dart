import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/calendar_day.dart';
import '../../domain/usecases/get_calendar_data_usecase.dart';
import '../../../../core/utils/logger.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

@injectable
class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final GetCalendarDataUsecase _getCalendarDataUsecase;

  CalendarBloc(this._getCalendarDataUsecase) : super(const CalendarInitial()) {
    on<CalendarLoadRequested>(_onLoadRequested);
    on<CalendarDaySelected>(_onDaySelected);
  }

  Future<void> _onLoadRequested(
    CalendarLoadRequested event,
    Emitter<CalendarState> emit,
  ) async {
    try {
      emit(const CalendarLoading());

      final result = await _getCalendarDataUsecase(
        GetCalendarDataParams(
          startDate: event.startDate,
          endDate: event.endDate,
        ),
      );

      result.fold(
        (failure) {
          AppLogger.w('Failed to load calendar data: ${failure.message}');
          emit(CalendarError(message: failure.message));
        },
        (calendarData) {
          AppLogger.d('Calendar data loaded successfully');
          emit(
            CalendarLoaded(
              calendarData: calendarData,
              selectedDate: event.selectedDate ?? DateTime.now(),
            ),
          );
        },
      );
    } catch (e, stackTrace) {
      AppLogger.e('Calendar load error', e, stackTrace);
      emit(const CalendarError(message: 'Failed to load calendar data'));
    }
  }

  Future<void> _onDaySelected(
    CalendarDaySelected event,
    Emitter<CalendarState> emit,
  ) async {
    if (state is CalendarLoaded) {
      final currentState = state as CalendarLoaded;
      emit(currentState.copyWith(selectedDate: event.date));
    }
  }
}
