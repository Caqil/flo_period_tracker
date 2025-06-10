import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/app_settings.dart';
import '../../domain/usecases/get_settings_usecase.dart';
import '../../domain/usecases/update_settings_usecase.dart';
import '../../../../core/utils/logger.dart';
import '../../../../core/usecases/usecase.dart';

part 'settings_event.dart';
part 'settings_state.dart';

@injectable
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetAppSettingsUsecase _getAppSettingsUsecase;
  final UpdateAppSettingsUsecase _updateAppSettingsUsecase;

  SettingsBloc(this._getAppSettingsUsecase, this._updateAppSettingsUsecase)
    : super(const SettingsState()) {
    on<SettingsLoadRequested>(_onLoadRequested);
    on<SettingsThemeChanged>(_onThemeChanged);
    on<SettingsLanguageChanged>(_onLanguageChanged);
    on<SettingsTextScaleChanged>(_onTextScaleChanged);
    on<SettingsNotificationsChanged>(_onNotificationsChanged);
    on<SettingsBorderRadiusChanged>(_onBorderRadiusChanged);
    on<SettingsFontFamilyChanged>(_onFontFamilyChanged);
    on<SettingsBiometricChanged>(_onBiometricChanged);
    on<SettingsPeriodRemindersChanged>(_onPeriodRemindersChanged);
    on<SettingsOvulationRemindersChanged>(_onOvulationRemindersChanged);
    on<SettingsReminderDaysChanged>(_onReminderDaysChanged);
    on<SettingsReminderTimeChanged>(_onReminderTimeChanged);
  }

  Future<void> _onLoadRequested(
    SettingsLoadRequested event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      final result = await _getAppSettingsUsecase(NoParams());

      result.fold(
        (failure) {
          AppLogger.w('Settings load failed: ${failure.message}');
          // Emit default settings on failure
          emit(state.copyWith(isLoaded: true));
        },
        (settings) {
          AppLogger.d('Settings loaded successfully');
          emit(
            state.copyWith(
              themeMode: settings.themeMode,
              locale: settings.locale,
              textScale: settings.textScale,
              notificationsEnabled: settings.notificationsEnabled,
              borderRadius: settings.borderRadius,
              fontFamily: settings.fontFamily,
              biometricEnabled: settings.biometricEnabled,
              periodRemindersEnabled: settings.periodRemindersEnabled,
              ovulationRemindersEnabled: settings.ovulationRemindersEnabled,
              reminderDaysBefore: settings.reminderDaysBefore,
              reminderTime: settings.reminderTime,
              isLoaded: true,
            ),
          );
        },
      );
    } catch (e, stackTrace) {
      AppLogger.e('Settings load error', e, stackTrace);
      emit(state.copyWith(isLoaded: true));
    }
  }

  Future<void> _onThemeChanged(
    SettingsThemeChanged event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(themeMode: event.themeMode));
    await _saveSettings();
  }

  Future<void> _onLanguageChanged(
    SettingsLanguageChanged event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(locale: event.locale));
    await _saveSettings();
  }

  Future<void> _onTextScaleChanged(
    SettingsTextScaleChanged event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(textScale: event.textScale));
    await _saveSettings();
  }

  Future<void> _onNotificationsChanged(
    SettingsNotificationsChanged event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(notificationsEnabled: event.enabled));
    await _saveSettings();
  }

  Future<void> _onBorderRadiusChanged(
    SettingsBorderRadiusChanged event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(borderRadius: event.borderRadius));
    await _saveSettings();
  }

  Future<void> _onFontFamilyChanged(
    SettingsFontFamilyChanged event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(fontFamily: event.fontFamily));
    await _saveSettings();
  }

  Future<void> _onBiometricChanged(
    SettingsBiometricChanged event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(biometricEnabled: event.enabled));
    await _saveSettings();
  }

  Future<void> _onPeriodRemindersChanged(
    SettingsPeriodRemindersChanged event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(periodRemindersEnabled: event.enabled));
    await _saveSettings();
  }

  Future<void> _onOvulationRemindersChanged(
    SettingsOvulationRemindersChanged event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(ovulationRemindersEnabled: event.enabled));
    await _saveSettings();
  }

  Future<void> _onReminderDaysChanged(
    SettingsReminderDaysChanged event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(reminderDaysBefore: event.days));
    await _saveSettings();
  }

  Future<void> _onReminderTimeChanged(
    SettingsReminderTimeChanged event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(reminderTime: event.time));
    await _saveSettings();
  }

  Future<void> _saveSettings() async {
    try {
      final settings = AppSettings(
        themeMode: state.themeMode,
        locale: state.locale,
        textScale: state.textScale,
        notificationsEnabled: state.notificationsEnabled,
        borderRadius: state.borderRadius,
        fontFamily: state.fontFamily,
        biometricEnabled: state.biometricEnabled,
        periodRemindersEnabled: state.periodRemindersEnabled,
        ovulationRemindersEnabled: state.ovulationRemindersEnabled,
        reminderDaysBefore: state.reminderDaysBefore,
        reminderTime: state.reminderTime,
      );

      final result = await _updateAppSettingsUsecase(settings);

      result.fold(
        (failure) => AppLogger.w('Settings save failed: ${failure.message}'),
        (_) => AppLogger.d('Settings saved successfully'),
      );
    } catch (e, stackTrace) {
      AppLogger.e('Settings save error', e, stackTrace);
    }
  }
}
