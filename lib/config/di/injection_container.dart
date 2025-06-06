// lib/config/di/injection_container.dart

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection_container.config.dart';

// Import all the implementations that need to be registered
import '../../features/calendar/data/repositories/calendar_repository_impl.dart';
import '../../features/calendar/data/datasources/calendar_local_datasource.dart';
import '../../features/period_tracking/data/repositories/period_repository_impl.dart';
import '../../features/period_tracking/data/datasources/period_local_datasource.dart';
import '../../features/authentication/data/repositories/auth_repository_impl.dart';
import '../../features/settings/data/repositories/settings_repository_impl.dart';
import '../../core/database/app_database.dart';
import '../../core/services/notification_service.dart';
import '../../core/services/prediction_service.dart';
import '../../core/services/analytics_service.dart';

final GetIt sl = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> init() async {
  // Register core services first
  sl.registerLazySingleton<AppDatabase>(() => AppDatabase());
  sl.registerLazySingleton<NotificationService>(() => NotificationService());
  sl.registerLazySingleton<PredictionService>(() => PredictionService());
  sl.registerLazySingleton<AnalyticsService>(() => AnalyticsService());

  // Use the generated injection configuration
  sl.init();
}

// Manual registration module for complex dependencies
@module
abstract class AppModule {
  @lazySingleton
  AppDatabase get database => AppDatabase();

  @lazySingleton
  NotificationService get notificationService => NotificationService();

  @lazySingleton
  PredictionService get predictionService => PredictionService();

  @lazySingleton
  AnalyticsService get analyticsService => AnalyticsService();
}
