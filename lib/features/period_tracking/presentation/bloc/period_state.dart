part of 'period_bloc.dart';

abstract class PeriodState extends Equatable {
  const PeriodState();

  @override
  List<Object?> get props => [];
}

class PeriodInitial extends PeriodState {
  const PeriodInitial();
}

class PeriodLoading extends PeriodState {
  const PeriodLoading();
}

class PeriodLoaded extends PeriodState {
  final Cycle? currentCycle;
  final List<Period> periods;
  final DateTime? nextPeriodPrediction;
  final bool isLoading;
  final String? error;

  const PeriodLoaded({
    this.currentCycle,
    required this.periods,
    this.nextPeriodPrediction,
    this.isLoading = false,
    this.error,
  });

  PeriodLoaded copyWith({
    Cycle? currentCycle,
    List<Period>? periods,
    DateTime? nextPeriodPrediction,
    bool? isLoading,
    String? error,
  }) {
    return PeriodLoaded(
      currentCycle: currentCycle ?? this.currentCycle,
      periods: periods ?? this.periods,
      nextPeriodPrediction: nextPeriodPrediction ?? this.nextPeriodPrediction,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    currentCycle,
    periods,
    nextPeriodPrediction,
    isLoading,
    error,
  ];
}

class PeriodError extends PeriodState {
  final String message;

  const PeriodError({required this.message});

  @override
  List<Object> get props => [message];
}
