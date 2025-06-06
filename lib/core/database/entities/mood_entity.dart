import 'package:floor/floor.dart';
import 'package:equatable/equatable.dart';

@Entity(tableName: 'moods')
class MoodEntity extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final DateTime date;
  final String mood; // happy, sad, anxious, irritated, etc.
  final int intensity; // 1-5 scale
  final List<String> emotions; // multiple emotion tags
  final String? notes;
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

  MoodEntity copyWith({
    int? id,
    DateTime? date,
    String? mood,
    int? intensity,
    List<String>? emotions,
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
