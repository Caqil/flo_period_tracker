import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'app.dart';
import 'config/di/injection_container.dart' as di;
import 'core/database/app_database.dart';
import 'core/services/notification_service.dart';
import 'core/utils/logger.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    AppLogger.d('onCreate: ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    AppLogger.d('onChange: ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    AppLogger.e('onError: ${bloc.runtimeType}', error, stackTrace);
  }
}

Future<void> bootstrap() async {
  try {
    // Initialize logger
    AppLogger.init();

    // Set BLoC observer
    Bloc.observer = AppBlocObserver();

    // Initialize Hive for local storage
    await _initializeHive();

    // Initialize dependency injection
    await di.init();

    // Initialize database
    await di.sl<AppDatabase>().initialize();

    // Initialize core services
    await _initializeServices();

    AppLogger.i('App bootstrap completed successfully');

    // Run the app
    runApp(const FloApp());
  } catch (e, stackTrace) {
    AppLogger.e('Bootstrap failed', e, stackTrace);

    // Run minimal error app
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text('Failed to start app: $e'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _initializeHive() async {
  await Hive.initFlutter();

  // Get application documents directory for better storage location
  final appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);

  AppLogger.i('Hive initialized');
}

Future<void> _initializeServices() async {
  // Initialize notification service
  try {
    await di.sl<NotificationService>().initialize();
    AppLogger.i('Notification service initialized');
  } catch (e) {
    AppLogger.e('Failed to initialize notification service', e);
  }
}
