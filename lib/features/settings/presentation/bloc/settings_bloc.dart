import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/app_settings.dart';
import '../../domain/usecases/get_settings_usecase.dart';
import '../../domain/usecases/update_settings_usecase.dart';
import '../../../../core/utils/logger.dart';

part 'settings_event.dart';
part 'settings_state.dart';

@injectable
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetSettingsUsecase _getSettingsUsecase;
  final UpdateSettingsUsecase _updateSettingsUsecase;

  SettingsBloc(this._getSettingsUsecase, this._updateSettingsUsecase)
    : super(const SettingsState()) {
    on<SettingsLoadRequested>(_onLoadRequested);
    on<SettingsThemeChanged>(_onThemeChanged);
    on<SettingsLanguageChanged>(_onLanguageChanged);
    on<SettingsTextScaleChanged>(_onTextScaleChanged);
    on<SettingsNotificationsChanged>(_onNotificationsChanged);
    on<SettingsBorderRadiusChanged>(_onBorderRadiusChanged);
    on<SettingsFontFamilyChanged>(_onFontFamilyChanged);
  }

  Future<void> _onLoadRequested(
    SettingsLoadRequested event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      final result = await _getSettingsUsecase();

      result.fold(
        (failure) {
          AppLogger.w('Settings load failed: ${failure.message}');
          // Emit default settings on failure
          emit(state);
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
              isLoaded: true,
            ),
          );
        },
      );
    } catch (e, stackTrace) {
      AppLogger.e('Settings load error', e, stackTrace);
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

  Future<void> _saveSettings() async {
    try {
      final settings = AppSettings(
        themeMode: state.themeMode,
        locale: state.locale,
        textScale: state.textScale,
        notificationsEnabled: state.notificationsEnabled,
        borderRadius: state.borderRadius,
        fontFamily: state.fontFamily,
      );

      final result = await _updateSettingsUsecase(settings);

      result.fold(
        (failure) => AppLogger.w('Settings save failed: ${failure.message}'),
        (_) => AppLogger.d('Settings saved successfully'),
      );
    } catch (e, stackTrace) {
      AppLogger.e('Settings save error', e, stackTrace);
    }
  }
}
