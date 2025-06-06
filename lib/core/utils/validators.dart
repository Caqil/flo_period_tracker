import 'package:flutter/material.dart';

class Validators {
  static final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }

  static String? name(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }

    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }

    return null;
  }

  static String? required(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? cycleLength(String? value) {
    if (value == null || value.isEmpty) {
      return 'Cycle length is required';
    }

    final length = int.tryParse(value);
    if (length == null) {
      return 'Please enter a valid number';
    }

    if (length < 21 || length > 35) {
      return 'Cycle length should be between 21-35 days';
    }

    return null;
  }

  static String? periodLength(String? value) {
    if (value == null || value.isEmpty) {
      return 'Period length is required';
    }

    final length = int.tryParse(value);
    if (length == null) {
      return 'Please enter a valid number';
    }

    if (length < 1 || length > 10) {
      return 'Period length should be between 1-10 days';
    }

    return null;
  }
}
