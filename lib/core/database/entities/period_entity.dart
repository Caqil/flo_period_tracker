// lib/core/database/entities/period_entity.dart
import 'package:floor/floor.dart';
import 'package:equatable/equatable.dart';

import '../converters/date_time_converter.dart';

@Entity(tableName: 'periods')
class PeriodEntity extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @TypeConverters([DateTimeConverter])
  final DateTime startDate;

  @TypeConverters([DateTimeNullableConverter])
  final DateTime? endDate;

  final int cycleLength;
  final String flowIntensity; // light, medium, heavy, spotting
  final String? notes;
  final bool isConfirmed;

  @TypeConverters([DateTimeConverter])
  final DateTime createdAt;

  @TypeConverters([DateTimeConverter])
  final DateTime updatedAt;

  const PeriodEntity({
    this.id,
    required this.startDate,
    this.endDate,
    required this.cycleLength,
    required this.flowIntensity,
    this.notes,
    required this.isConfirmed,
    required this.createdAt,
    required this.updatedAt,
  });

  PeriodEntity copyWith({
    int? id,
    DateTime? startDate,
    DateTime? endDate,
    int? cycleLength,
    String? flowIntensity,
    String? notes,
    bool? isConfirmed,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PeriodEntity(
      id: id ?? this.id,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      cycleLength: cycleLength ?? this.cycleLength,
      flowIntensity: flowIntensity ?? this.flowIntensity,
      notes: notes ?? this.notes,
      isConfirmed: isConfirmed ?? this.isConfirmed,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    startDate,
    endDate,
    cycleLength,
    flowIntensity,
    notes,
    isConfirmed,
    createdAt,
    updatedAt,
  ];
}
