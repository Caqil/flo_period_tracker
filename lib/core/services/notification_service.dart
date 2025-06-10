import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:injectable/injectable.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

import '../utils/logger.dart';

@lazySingleton
class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Initialize timezone data
      tz.initializeTimeZones();

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

      // Convert DateTime to TZDateTime
      final tz.TZDateTime scheduledTZDate = tz.TZDateTime.from(
        scheduledDate,
        tz.local,
      );

      await _flutterLocalNotificationsPlugin.zonedSchedule(
        scheduledDate.hashCode,
        title,
        body,
        scheduledTZDate,
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );

      AppLogger.d('Period reminder scheduled for $scheduledDate');
    } catch (e, stackTrace) {
      AppLogger.e('Failed to schedule period reminder', e, stackTrace);
    }
  }

  Future<void> scheduleRecurringReminder({
    required int id,
    required String title,
    required String body,
    required TimeOfDay time,
    required List<int> weekdays, // 1 = Monday, 7 = Sunday
  }) async {
    if (!_isInitialized) return;

    try {
      const androidDetails = AndroidNotificationDetails(
        'recurring_reminders',
        'Recurring Reminders',
        channelDescription: 'Daily and weekly recurring reminders',
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

      // Schedule for each specified weekday
      for (final weekday in weekdays) {
        final now = tz.TZDateTime.now(tz.local);
        var scheduledDate = tz.TZDateTime(
          tz.local,
          now.year,
          now.month,
          now.day,
          time.hour,
          time.minute,
        );

        // Find the next occurrence of this weekday
        while (scheduledDate.weekday != weekday) {
          scheduledDate = scheduledDate.add(const Duration(days: 1));
        }

        // If the time has already passed today, schedule for next week
        if (scheduledDate.isBefore(now)) {
          scheduledDate = scheduledDate.add(const Duration(days: 7));
        }

        await _flutterLocalNotificationsPlugin.zonedSchedule(
          id + weekday, // Unique ID for each weekday
          title,
          body,
          scheduledDate,
          notificationDetails,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        );
      }

      AppLogger.d('Recurring reminder scheduled for weekdays: $weekdays');
    } catch (e, stackTrace) {
      AppLogger.e('Failed to schedule recurring reminder', e, stackTrace);
    }
  }

  Future<void> scheduleOvulationReminder({
    required DateTime ovulationDate,
    required int daysBefore,
  }) async {
    final reminderDate = ovulationDate.subtract(Duration(days: daysBefore));

    await schedulePeriodReminder(
      scheduledDate: reminderDate,
      title: 'Ovulation Approaching',
      body: 'Your fertile window starts in $daysBefore days',
    );
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

  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    if (!_isInitialized) return [];

    try {
      return await _flutterLocalNotificationsPlugin
          .pendingNotificationRequests();
    } catch (e, stackTrace) {
      AppLogger.e('Failed to get pending notifications', e, stackTrace);
      return [];
    }
  }

  Future<void> showInstantNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    if (!_isInitialized) return;

    try {
      const androidDetails = AndroidNotificationDetails(
        'instant_notifications',
        'Instant Notifications',
        channelDescription: 'Immediate notifications',
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

      await _flutterLocalNotificationsPlugin.show(
        id,
        title,
        body,
        notificationDetails,
        payload: payload,
      );

      AppLogger.d('Instant notification shown: $title');
    } catch (e, stackTrace) {
      AppLogger.e('Failed to show instant notification', e, stackTrace);
    }
  }
}
