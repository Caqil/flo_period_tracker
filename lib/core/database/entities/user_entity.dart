// lib/core/database/entities/user_entity.dart
import 'package:floor/floor.dart';
import 'package:equatable/equatable.dart';

import '../converters/date_time_converter.dart';

@Entity(tableName: 'users')
class UserEntity extends Equatable {
  @PrimaryKey()
  final String id;

  final String email;
  final String? name;

  @TypeConverters([DateTimeNullableConverter])
  final DateTime? dateOfBirth;

  final int averageCycleLength;
  final int averagePeriodLength;

  @TypeConverters([DateTimeNullableConverter])
  final DateTime? lastPeriodDate;

  final bool isOnboardingCompleted;
  final String? profileImageUrl;

  @TypeConverters([DateTimeConverter])
  final DateTime createdAt;

  @TypeConverters([DateTimeConverter])
  final DateTime updatedAt;

  const UserEntity({
    required this.id,
    required this.email,
    this.name,
    this.dateOfBirth,
    required this.averageCycleLength,
    required this.averagePeriodLength,
    this.lastPeriodDate,
    required this.isOnboardingCompleted,
    this.profileImageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  UserEntity copyWith({
    String? id,
    String? email,
    String? name,
    DateTime? dateOfBirth,
    int? averageCycleLength,
    int? averagePeriodLength,
    DateTime? lastPeriodDate,
    bool? isOnboardingCompleted,
    String? profileImageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      averageCycleLength: averageCycleLength ?? this.averageCycleLength,
      averagePeriodLength: averagePeriodLength ?? this.averagePeriodLength,
      lastPeriodDate: lastPeriodDate ?? this.lastPeriodDate,
      isOnboardingCompleted:
          isOnboardingCompleted ?? this.isOnboardingCompleted,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    email,
    name,
    dateOfBirth,
    averageCycleLength,
    averagePeriodLength,
    lastPeriodDate,
    isOnboardingCompleted,
    profileImageUrl,
    createdAt,
    updatedAt,
  ];
}
