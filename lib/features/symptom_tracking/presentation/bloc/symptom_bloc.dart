import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'symptom_event.dart';
part 'symptom_state.dart';

@injectable
class SymptomBloc extends Bloc<SymptomEvent, SymptomState> {
  SymptomBloc() : super(const SymptomInitial()) {
    on<SymptomLoadRequested>(_onLoadRequested);
    on<SymptomLogRequested>(_onLogRequested);
  }

  Future<void> _onLoadRequested(
    SymptomLoadRequested event,
    Emitter<SymptomState> emit,
  ) async {
    emit(const SymptomLoading());
    // TODO: Load symptoms for the given date
    emit(const SymptomLoaded(symptoms: []));
  }

  Future<void> _onLogRequested(
    SymptomLogRequested event,
    Emitter<SymptomState> emit,
  ) async {
    emit(const SymptomLogging());
    // TODO: Log the symptom
    await Future.delayed(const Duration(milliseconds: 500));
    emit(const SymptomLogged());
  }
}
