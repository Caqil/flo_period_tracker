import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection_container.config.dart';

final GetIt sl = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> init() async {
  sl.init();
}

// Manual registrations for complex dependencies
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
