part of 'calendar_bloc.dart';

abstract class CalendarState extends Equatable {
  const CalendarState();

  @override
  List<Object?> get props => [];
}

class CalendarInitial extends CalendarState {
  const CalendarInitial();
}

class CalendarLoading extends CalendarState {
  const CalendarLoading();
}

class CalendarLoaded extends CalendarState {
  final List<CalendarDay> calendarData;
  final DateTime selectedDate;

  const CalendarLoaded({
    required this.calendarData,
    required this.selectedDate,
  });

  CalendarLoaded copyWith({
    List<CalendarDay>? calendarData,
    DateTime? selectedDate,
  }) {
    return CalendarLoaded(
      calendarData: calendarData ?? this.calendarData,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }

  @override
  List<Object> get props => [calendarData, selectedDate];
}

class CalendarError extends CalendarState {
  final String message;

  const CalendarError({required this.message});

  @override
  List<Object> get props => [message];
}
