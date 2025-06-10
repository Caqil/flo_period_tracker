import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import '../../domain/usecases/setup_profile_usecase.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/usecases/update_profile_usecase.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

@injectable
class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final SetupProfileUsecase _setupProfileUsecase;
  final GetProfileUsecase _getProfileUsecase;
  final UpdateProfileUsecase _updateProfileUsecase;

  UserProfileBloc(
    this._setupProfileUsecase,
    this._getProfileUsecase,
    this._updateProfileUsecase,
  ) : super(const UserProfileInitial()) {
    on<UserProfileLoadRequested>(_onLoadRequested);
    on<UserProfileSetupRequested>(_onSetupRequested);
    on<UserProfileUpdateRequested>(_onUpdateRequested);
    on<UserProfilePinSetRequested>(_onPinSetRequested);
    on<UserProfileBiometricToggled>(_onBiometricToggled);
  }

  Future<void> _onLoadRequested(
    UserProfileLoadRequested event,
    Emitter<UserProfileState> emit,
  ) async {
    try {
      emit(const UserProfileLoading());

      final result = await _getProfileUsecase(NoParams());

      result.fold(
        (failure) {
          AppLogger.w('Failed to load profile: ${failure.message}');
          emit(const UserProfileNotFound());
        },
        (profile) {
          if (profile == null) {
            AppLogger.d('No profile found - new user');
            emit(const UserProfileNotFound());
          } else {
            AppLogger.d('Profile loaded successfully');
            emit(UserProfileLoaded(profile: profile));
          }
        },
      );
    } catch (e, stackTrace) {
      AppLogger.e('Profile load error', e, stackTrace);
      emit(const UserProfileError(message: 'Failed to load profile'));
    }
  }

  Future<void> _onSetupRequested(
    UserProfileSetupRequested event,
    Emitter<UserProfileState> emit,
  ) async {
    try {
      emit(const UserProfileLoading());

      final result = await _setupProfileUsecase(
        SetupProfileParams(
          name: event.name,
          dateOfBirth: event.dateOfBirth,
          averageCycleLength: event.averageCycleLength,
          averagePeriodLength: event.averagePeriodLength,
          lastPeriodDate: event.lastPeriodDate,
        ),
      );

      result.fold(
        (failure) {
          AppLogger.w('Profile setup failed: ${failure.message}');
          emit(UserProfileError(message: failure.message));
        },
        (profile) {
          AppLogger.i('Profile setup completed');
          emit(UserProfileLoaded(profile: profile));
        },
      );
    } catch (e, stackTrace) {
      AppLogger.e('Profile setup error', e, stackTrace);
      emit(const UserProfileError(message: 'Failed to setup profile'));
    }
  }

  Future<void> _onUpdateRequested(
    UserProfileUpdateRequested event,
    Emitter<UserProfileState> emit,
  ) async {
    try {
      if (state is! UserProfileLoaded) return;

      final currentState = state as UserProfileLoaded;
      emit(const UserProfileLoading());

      final result = await _updateProfileUsecase(event.profile);

      result.fold(
        (failure) {
          AppLogger.w('Profile update failed: ${failure.message}');
          emit(UserProfileError(message: failure.message));
        },
        (profile) {
          AppLogger.i('Profile updated successfully');
          emit(UserProfileLoaded(profile: profile));
        },
      );
    } catch (e, stackTrace) {
      AppLogger.e('Profile update error', e, stackTrace);
      emit(const UserProfileError(message: 'Failed to update profile'));
    }
  }

  Future<void> _onPinSetRequested(
    UserProfilePinSetRequested event,
    Emitter<UserProfileState> emit,
  ) async {
    // TODO: Implement PIN setting logic
    AppLogger.d('PIN set requested: ${event.pin}');
  }

  Future<void> _onBiometricToggled(
    UserProfileBiometricToggled event,
    Emitter<UserProfileState> emit,
  ) async {
    // TODO: Implement biometric toggle logic
    AppLogger.d('Biometric toggled: ${event.enabled}');
  }
}
