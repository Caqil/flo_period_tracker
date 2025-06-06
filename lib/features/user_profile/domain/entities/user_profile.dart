import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  final String id;
  final String? name;
  final DateTime? dateOfBirth;
  final int averageCycleLength;
  final int averagePeriodLength;
  final DateTime? lastPeriodDate;
  final bool isSetupCompleted;
  final String? profileImagePath; // Local file path
  final bool isPinEnabled;
  final bool isBiometricEnabled;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserProfile({
    required this.id,
    this.name,
    this.dateOfBirth,
    this.averageCycleLength = 28,
    this.averagePeriodLength = 5,
    this.lastPeriodDate,
    this.isSetupCompleted = false,
    this.profileImagePath,
    this.isPinEnabled = false,
    this.isBiometricEnabled = false,
    required this.createdAt,
    required this.updatedAt,
  });

  UserProfile copyWith({
    String? id,
    String? name,
    DateTime? dateOfBirth,
    int? averageCycleLength,
    int? averagePeriodLength,
    DateTime? lastPeriodDate,
    bool? isSetupCompleted,
    String? profileImagePath,
    bool? isPinEnabled,
    bool? isBiometricEnabled,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      averageCycleLength: averageCycleLength ?? this.averageCycleLength,
      averagePeriodLength: averagePeriodLength ?? this.averagePeriodLength,
      lastPeriodDate: lastPeriodDate ?? this.lastPeriodDate,
      isSetupCompleted: isSetupCompleted ?? this.isSetupCompleted,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      isPinEnabled: isPinEnabled ?? this.isPinEnabled,
      isBiometricEnabled: isBiometricEnabled ?? this.isBiometricEnabled,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    dateOfBirth,
    averageCycleLength,
    averagePeriodLength,
    lastPeriodDate,
    isSetupCompleted,
    profileImagePath,
    isPinEnabled,
    isBiometricEnabled,
    createdAt,
    updatedAt,
  ];
}
