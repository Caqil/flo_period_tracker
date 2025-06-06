import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

class AppLogger {
  static bool _isInitialized = false;

  static void init() {
    if (!_isInitialized) {
      _isInitialized = true;
      i('Logger initialized');
    }
  }

  static void d(String message, [Object? error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      developer.log(
        message,
        name: 'FloApp',
        level: 500, // Debug level
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  static void i(String message, [Object? error, StackTrace? stackTrace]) {
    developer.log(
      message,
      name: 'FloApp',
      level: 800, // Info level
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void w(String message, [Object? error, StackTrace? stackTrace]) {
    developer.log(
      message,
      name: 'FloApp',
      level: 900, // Warning level
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void e(String message, [Object? error, StackTrace? stackTrace]) {
    developer.log(
      message,
      name: 'FloApp',
      level: 1000, // Error level
      error: error,
      stackTrace: stackTrace,
    );
  }
}
