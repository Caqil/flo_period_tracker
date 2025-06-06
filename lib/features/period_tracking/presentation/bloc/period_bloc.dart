import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/period.dart';
import '../../domain/entities/cycle.dart';
import '../../domain/usecases/log_period_usecase.dart';
import '../../domain/usecases/get_current_cycle_usecase.dart';
import '../../domain/usecases/predict_next_period_usecase.dart';
import '../../../../core/utils/logger.dart';

part 'period_event.dart';
part 'period_state.dart';

@injectable
class PeriodBloc extends Bloc<PeriodEvent, PeriodState> {
  final LogPeriodUsecase _logPeriodUsecase;
  final GetCurrentCycleUsecase _getCurrentCycleUsecase;
  final PredictNextPeriodUsecase _predictNextPeriodUsecase;

  PeriodBloc(
    this._logPeriodUsecase,
    this._getCurrentCycleUsecase,
    this._predictNextPeriodUsecase,
  ) : super(const PeriodInitial()) {
    on<PeriodLoadRequested>(_onLoadRequested);
    on<PeriodLogRequested>(_onLogRequested);
    on<PeriodUpdateRequested>(_onUpdateRequested);
    on<PeriodDeleteRequested>(_onDeleteRequested);
    on<PeriodPredictionRequested>(_onPredictionRequested);
  }

  Future<void> _onLoadRequested(
    PeriodLoadRequested event,
    Emitter<PeriodState> emit,
  ) async {
    try {
      emit(const PeriodLoading());

      final currentCycleResult = await _getCurrentCycleUsecase();

      currentCycleResult.fold(
        (failure) {
          AppLogger.w('Failed to load current cycle: ${failure.message}');
          emit(PeriodError(message: failure.message));
        },
        (cycle) {
          AppLogger.d('Current cycle loaded');
          emit(
            PeriodLoaded(
              currentCycle: cycle,
              periods: cycle!.periods,
              nextPeriodPrediction: null,
            ),
          );
        },
      );
    } catch (e, stackTrace) {
      AppLogger.e('Period load error', e, stackTrace);
      emit(const PeriodError(message: 'Failed to load period data'));
    }
  }

  Future<void> _onLogRequested(
    PeriodLogRequested event,
    Emitter<PeriodState> emit,
  ) async {
    try {
      if (state is! PeriodLoaded) return;

      final currentState = state as PeriodLoaded;
      emit(currentState.copyWith(isLoading: true));

      final result = await _logPeriodUsecase(
        LogPeriodParams(
          startDate: event.startDate,
          endDate: event.endDate,
          flowIntensity: event.flowIntensity,
          notes: event.notes,
        ),
      );

      result.fold(
        (failure) {
          AppLogger.w('Failed to log period: ${failure.message}');
          emit(currentState.copyWith(isLoading: false, error: failure.message));
        },
        (period) {
          AppLogger.i('Period logged successfully');
          // Reload data to get updated cycle
          add(const PeriodLoadRequested());
        },
      );
    } catch (e, stackTrace) {
      AppLogger.e('Period log error', e, stackTrace);
      if (state is PeriodLoaded) {
        emit(
          (state as PeriodLoaded).copyWith(
            isLoading: false,
            error: 'Failed to log period',
          ),
        );
      }
    }
  }

  Future<void> _onUpdateRequested(
    PeriodUpdateRequested event,
    Emitter<PeriodState> emit,
  ) async {
    try {
      if (state is! PeriodLoaded) return;

      final currentState = state as PeriodLoaded;
      emit(currentState.copyWith(isLoading: true));

      // Update period logic here
      // For now, just reload data
      add(const PeriodLoadRequested());
    } catch (e, stackTrace) {
      AppLogger.e('Period update error', e, stackTrace);
    }
  }

  Future<void> _onDeleteRequested(
    PeriodDeleteRequested event,
    Emitter<PeriodState> emit,
  ) async {
    try {
      if (state is! PeriodLoaded) return;

      final currentState = state as PeriodLoaded;
      emit(currentState.copyWith(isLoading: true));

      // Delete period logic here
      // For now, just reload data
      add(const PeriodLoadRequested());
    } catch (e, stackTrace) {
      AppLogger.e('Period delete error', e, stackTrace);
    }
  }

  Future<void> _onPredictionRequested(
    PeriodPredictionRequested event,
    Emitter<PeriodState> emit,
  ) async {
    try {
      if (state is! PeriodLoaded) return;

      final currentState = state as PeriodLoaded;

      final result = await _predictNextPeriodUsecase();

      result.fold(
        (failure) {
          AppLogger.w('Failed to predict next period: ${failure.message}');
        },
        (prediction) {
          AppLogger.d('Next period predicted');
          emit(currentState.copyWith(nextPeriodPrediction: prediction));
        },
      );
    } catch (e, stackTrace) {
      AppLogger.e('Period prediction error', e, stackTrace);
    }
  }
}
