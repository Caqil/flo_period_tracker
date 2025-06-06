part of 'period_bloc.dart';

abstract class PeriodEvent extends Equatable {
  const PeriodEvent();

  @override
  List<Object?> get props => [];
}

class PeriodLoadRequested extends PeriodEvent {
  const PeriodLoadRequested();
}

class PeriodLogRequested extends PeriodEvent {
  final DateTime startDate;
  final DateTime? endDate;
  final String flowIntensity;
  final String? notes;

  const PeriodLogRequested({
    required this.startDate,
    this.endDate,
    required this.flowIntensity,
    this.notes,
  });

  @override
  List<Object?> get props => [startDate, endDate, flowIntensity, notes];
}

class PeriodUpdateRequested extends PeriodEvent {
  final Period period;

  const PeriodUpdateRequested({required this.period});

  @override
  List<Object> get props => [period];
}

class PeriodDeleteRequested extends PeriodEvent {
  final String periodId;

  const PeriodDeleteRequested({required this.periodId});

  @override
  List<Object> get props => [periodId];
}

class PeriodPredictionRequested extends PeriodEvent {
  const PeriodPredictionRequested();
}
