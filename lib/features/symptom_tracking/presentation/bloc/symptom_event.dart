part of 'symptom_bloc.dart';

abstract class SymptomEvent extends Equatable {
  const SymptomEvent();

  @override
  List<Object?> get props => [];
}

class SymptomLoadRequested extends SymptomEvent {
  final DateTime date;

  const SymptomLoadRequested({required this.date});

  @override
  List<Object> get props => [date];
}

class SymptomLogRequested extends SymptomEvent {
  final DateTime date;
  final String symptomName;
  final int intensity;

  const SymptomLogRequested({
    required this.date,
    required this.symptomName,
    required this.intensity,
  });

  @override
  List<Object> get props => [date, symptomName, intensity];
}
