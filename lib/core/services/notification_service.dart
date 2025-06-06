import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:injectable/injectable.dart';

import '../utils/logger.dart';

@lazySingleton
class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Request notification permissions
      await _requestPermissions();

      // Initialize settings
      const androidSettings = AndroidInitializationSettings(
        '@mipmap/ic_launcher',
      );
      const iosSettings = DarwinInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
      );

      const initializationSettings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );

      await _flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: _onNotificationTapped,
      );

      _isInitialized = true;
      AppLogger.i('Notification service initialized');
    } catch (e, stackTrace) {
      AppLogger.e('Failed to initialize notification service', e, stackTrace);
    }
  }

  Future<void> _requestPermissions() async {
    final status = await Permission.notification.request();

    if (status.isDenied) {
      AppLogger.w('Notification permission denied');
    } else if (status.isGranted) {
      AppLogger.i('Notification permission granted');
    }
  }

  void _onNotificationTapped(NotificationResponse response) {
    AppLogger.d('Notification tapped: ${response.payload}');
    // Handle notification tap navigation here
  }

  Future<void> schedulePeriodReminder({
    required DateTime scheduledDate,
    required String title,
    required String body,
  }) async {
    if (!_isInitialized) return;

    try {
      const androidDetails = AndroidNotificationDetails(
        'period_reminders',
        'Period Reminders',
        channelDescription:
            'Notifications for period predictions and reminders',
        importance: Importance.high,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
      );

      const iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      const notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _flutterLocalNotificationsPlugin.zonedSchedule(
        scheduledDate.hashCode,
        title,
        body,
        scheduledDate,
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );

      AppLogger.d('Period reminder scheduled for $scheduledDate');
    } catch (e, stackTrace) {
      AppLogger.e('Failed to schedule period reminder', e, stackTrace);
    }
  }

  Future<void> cancelNotification(int id) async {
    if (!_isInitialized) return;

    try {
      await _flutterLocalNotificationsPlugin.cancel(id);
      AppLogger.d('Notification $id cancelled');
    } catch (e, stackTrace) {
      AppLogger.e('Failed to cancel notification', e, stackTrace);
    }
  }

  Future<void> cancelAllNotifications() async {
    if (!_isInitialized) return;

    try {
      await _flutterLocalNotificationsPlugin.cancelAll();
      AppLogger.d('All notifications cancelled');
    } catch (e, stackTrace) {
      AppLogger.e('Failed to cancel all notifications', e, stackTrace);
    }
  }
}
