// lib/core/database/entities/symptom_entity.dart
import 'package:floor/floor.dart';
import 'package:equatable/equatable.dart';

import '../converters/date_time_converter.dart';

@Entity(tableName: 'symptoms')
class SymptomEntity extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @TypeConverters([DateTimeConverter])
  final DateTime date;

  final String category; // cramps, headache, bloating, etc.
  final String name;
  final int intensity; // 1-5 scale
  final String? description;

  @TypeConverters([DateTimeConverter])
  final DateTime createdAt;

  const SymptomEntity({
    this.id,
    required this.date,
    required this.category,
    required this.name,
    required this.intensity,
    this.description,
    required this.createdAt,
  });

  SymptomEntity copyWith({
    int? id,
    DateTime? date,
    String? category,
    String? name,
    int? intensity,
    String? description,
    DateTime? createdAt,
  }) {
    return SymptomEntity(
      id: id ?? this.id,
      date: date ?? this.date,
      category: category ?? this.category,
      name: name ?? this.name,
      intensity: intensity ?? this.intensity,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    date,
    category,
    name,
    intensity,
    description,
    createdAt,
  ];
}
