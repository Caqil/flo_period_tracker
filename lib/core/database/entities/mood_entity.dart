// lib/core/database/entities/mood_entity.dart
import 'package:floor/floor.dart';
import 'package:equatable/equatable.dart';

import '../converters/date_time_converter.dart';

@Entity(tableName: 'moods')
class MoodEntity extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @TypeConverters([DateTimeConverter])
  final DateTime date;

  final String mood; // happy, sad, anxious, irritated, etc.
  final int intensity; // 1-5 scale

  // Store emotions as comma-separated string
  final String emotions; // multiple emotion tags stored as comma-separated

  final String? notes;

  @TypeConverters([DateTimeConverter])
  final DateTime createdAt;

  const MoodEntity({
    this.id,
    required this.date,
    required this.mood,
    required this.intensity,
    required this.emotions,
    this.notes,
    required this.createdAt,
  });

  // Helper methods to convert between List<String> and String
  List<String> get emotionsList {
    if (emotions.isEmpty) return [];
    return emotions.split(',').map((e) => e.trim()).toList();
  }

  static String emotionsFromList(List<String> emotionsList) {
    return emotionsList.join(',');
  }

  MoodEntity copyWith({
    int? id,
    DateTime? date,
    String? mood,
    int? intensity,
    String? emotions,
    String? notes,
    DateTime? createdAt,
  }) {
    return MoodEntity(
      id: id ?? this.id,
      date: date ?? this.date,
      mood: mood ?? this.mood,
      intensity: intensity ?? this.intensity,
      emotions: emotions ?? this.emotions,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    date,
    mood,
    intensity,
    emotions,
    notes,
    createdAt,
  ];
}
