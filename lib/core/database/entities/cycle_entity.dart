import 'package:floor/floor.dart';
import 'package:equatable/equatable.dart';

@Entity(tableName: 'cycles')
class CycleEntity extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String cycleId; // UUID string
  final DateTime startDate;
  final DateTime? endDate;
  final int length;
  final DateTime? ovulationDate;
  final DateTime? fertileWindowStart;
  final DateTime? fertileWindowEnd;
  final bool isComplete;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CycleEntity({
    this.id,
    required this.cycleId,
    required this.startDate,
    this.endDate,
    required this.length,
    this.ovulationDate,
    this.fertileWindowStart,
    this.fertileWindowEnd,
    required this.isComplete,
    required this.createdAt,
    required this.updatedAt,
  });

  CycleEntity copyWith({
    int? id,
    String? cycleId,
    DateTime? startDate,
    DateTime? endDate,
    int? length,
    DateTime? ovulationDate,
    DateTime? fertileWindowStart,
    DateTime? fertileWindowEnd,
    bool? isComplete,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CycleEntity(
      id: id ?? this.id,
      cycleId: cycleId ?? this.cycleId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      length: length ?? this.length,
      ovulationDate: ovulationDate ?? this.ovulationDate,
      fertileWindowStart: fertileWindowStart ?? this.fertileWindowStart,
      fertileWindowEnd: fertileWindowEnd ?? this.fertileWindowEnd,
      isComplete: isComplete ?? this.isComplete,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    cycleId,
    startDate,
    endDate,
    length,
    ovulationDate,
    fertileWindowStart,
    fertileWindowEnd,
    isComplete,
    createdAt,
    updatedAt,
  ];
}
