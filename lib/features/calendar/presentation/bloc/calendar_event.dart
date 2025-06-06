part of 'calendar_bloc.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object?> get props => [];
}

class CalendarLoadRequested extends CalendarEvent {
  final DateTime startDate;
  final DateTime endDate;
  final DateTime? selectedDate;

  const CalendarLoadRequested({
    required this.startDate,
    required this.endDate,
    this.selectedDate,
  });

  @override
  List<Object?> get props => [startDate, endDate, selectedDate];
}

class CalendarDaySelected extends CalendarEvent {
  final DateTime date;

  const CalendarDaySelected({required this.date});

  @override
  List<Object> get props => [date];
}
