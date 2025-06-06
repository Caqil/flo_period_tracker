// lib/config/di/injection_container.dart (FIXED)
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

// Core services
import '../../core/database/app_database.dart';
import '../../core/services/notification_service.dart';
import '../../core/services/prediction_service.dart';
import '../../core/services/analytics_service.dart';
import '../../core/services/haptic_service.dart';

// User Profile
import '../../features/calendar/domain/repositories/calendar_repository_impl.dart';
import '../../features/period_tracking/domain/repositories/period_repository_impl.dart';
import '../../features/user_profile/data/datasources/user_profile_local_datasource.dart';
import '../../features/user_profile/data/repositories/user_profile_repository_impl.dart';
import '../../features/user_profile/domain/repositories/user_profile_repository.dart';
import '../../features/user_profile/domain/usecases/get_profile_usecase.dart';
import '../../features/user_profile/domain/usecases/setup_profile_usecase.dart';
import '../../features/user_profile/domain/usecases/update_profile_usecase.dart';
import '../../features/user_profile/presentation/bloc/user_profile_bloc.dart';

// Calendar
import '../../features/calendar/data/datasources/calendar_local_datasource.dart';
import '../../features/calendar/domain/repositories/calendar_repository.dart';
import '../../features/calendar/domain/usecases/get_calendar_data_usecase.dart';
import '../../features/calendar/presentation/bloc/calendar_bloc.dart';

// Period Tracking
import '../../features/period_tracking/data/datasources/period_local_datasource.dart';
import '../../features/period_tracking/data/repositories/period_repository_impl.dart';
import '../../features/period_tracking/domain/repositories/period_repository.dart';
import '../../features/period_tracking/domain/usecases/log_period_usecase.dart';
import '../../features/period_tracking/domain/usecases/get_current_cycle_usecase.dart';
import '../../features/period_tracking/domain/usecases/predict_next_period_usecase.dart';
import '../../features/period_tracking/presentation/bloc/period_bloc.dart';

// Settings
import '../../features/settings/data/datasources/settings_local_datasource.dart';
import '../../features/settings/data/repositories/settings_repository_impl.dart';
import '../../features/settings/domain/repositories/settings_repository.dart';
import '../../features/settings/domain/usecases/get_settings_usecase.dart';
import '../../features/settings/domain/usecases/update_settings_usecase.dart';
import '../../features/settings/presentation/bloc/settings_bloc.dart';

// Symptom Tracking
import '../../features/symptom_tracking/presentation/bloc/symptom_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // Core Services
  sl.registerLazySingleton<AppDatabase>(() => AppDatabase());
  sl.registerLazySingleton<NotificationService>(() => NotificationService());
  sl.registerLazySingleton<PredictionService>(() => PredictionService());
  sl.registerLazySingleton<AnalyticsService>(() => AnalyticsService());
  sl.registerLazySingleton<HapticService>(() => HapticService());

  // User Profile
  sl.registerLazySingleton<UserProfileLocalDatasource>(
    () => UserProfileLocalDatasourceImpl(sl()),
  );
  sl.registerLazySingleton<UserProfileRepository>(
    () => UserProfileRepositoryImpl(sl()),
  );
  sl.registerFactory(() => GetProfileUsecase(sl()));
  sl.registerFactory(() => SetupProfileUsecase(sl()));
  sl.registerFactory(() => UpdateProfileUsecase(sl()));
  sl.registerFactory(() => UserProfileBloc(sl(), sl(), sl()));

  // Calendar
  sl.registerLazySingleton<CalendarLocalDatasource>(
    () => CalendarLocalDatasourceImpl(sl()),
  );
  sl.registerLazySingleton<CalendarRepository>(
    () => CalendarRepositoryImpl(sl()),
  );
  sl.registerFactory(() => GetCalendarDataUsecase(sl()));
  sl.registerFactory(() => CalendarBloc(sl()));

  // Period Tracking
  sl.registerLazySingleton<PeriodLocalDatasource>(
    () => PeriodLocalDatasourceImpl(sl()),
  );
  sl.registerLazySingleton<PeriodRepository>(() => PeriodRepositoryImpl(sl()));
  sl.registerFactory(() => LogPeriodUsecase(sl()));
  sl.registerFactory(() => GetCurrentCycleUsecase(sl()));
  sl.registerFactory(() => PredictNextPeriodUsecase(sl()));
  sl.registerFactory(() => PeriodBloc(sl(), sl(), sl()));

  // Settings
  sl.registerLazySingleton<SettingsLocalDatasource>(
    () => SettingsLocalDatasourceImpl(),
  );
  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(sl()),
  );
  sl.registerFactory(() => GetSettingsUsecase(sl()));
  sl.registerFactory(() => UpdateSettingsUsecase(sl()));
  sl.registerFactory(() => SettingsBloc(sl(), sl()));

  // Symptom Tracking
  sl.registerFactory(() => SymptomBloc());
}
