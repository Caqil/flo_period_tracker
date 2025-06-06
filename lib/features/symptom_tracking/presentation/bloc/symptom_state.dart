part of 'symptom_bloc.dart';

abstract class SymptomState extends Equatable {
  const SymptomState();

  @override
  List<Object?> get props => [];
}

class SymptomInitial extends SymptomState {
  const SymptomInitial();
}

class SymptomLoading extends SymptomState {
  const SymptomLoading();
}

class SymptomLoaded extends SymptomState {
  final List<dynamic> symptoms;

  const SymptomLoaded({required this.symptoms});

  @override
  List<Object> get props => [symptoms];
}

class SymptomLogging extends SymptomState {
  const SymptomLogging();
}

class SymptomLogged extends SymptomState {
  const SymptomLogged();
}

class SymptomError extends SymptomState {
  final String message;

  const SymptomError({required this.message});

  @override
  List<Object> get props => [message];
}
