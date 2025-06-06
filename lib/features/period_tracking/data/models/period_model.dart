
import '../../domain/entities/period.dart';
import '../../../../core/database/entities/period_entity.dart';

class PeriodModel extends Period {
  const PeriodModel({
    required super.id,
    required super.startDate,
    super.endDate,
    required super.flowIntensity,
    super.notes,
    required super.isConfirmed,
    super.symptoms = const [],
    required super.createdAt,
    required super.updatedAt,
  });

  factory PeriodModel.fromEntity(Period period) {
    return PeriodModel(
      id: period.id,
      startDate: period.startDate,
      endDate: period.endDate,
      flowIntensity: period.flowIntensity,
      notes: period.notes,
      isConfirmed: period.isConfirmed,
      symptoms: period.symptoms,
      createdAt: period.createdAt,
      updatedAt: period.updatedAt,
    );
  }

  factory PeriodModel.fromDatabaseEntity(PeriodEntity entity) {
    return PeriodModel(
      id: entity.id?.toString() ?? '',
      startDate: entity.startDate,
      endDate: entity.endDate,
      flowIntensity: entity.flowIntensity,
      notes: entity.notes,
      isConfirmed: entity.isConfirmed,
      symptoms: const [], // Symptoms are stored separately
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  PeriodEntity toDatabaseEntity() {
    return PeriodEntity(
      id: id.isNotEmpty ? int.tryParse(id) : null,
      startDate: startDate,
      endDate: endDate,
      cycleLength: endDate?.difference(startDate).inDays ?? 5,
      flowIntensity: flowIntensity,
      notes: notes,
      isConfirmed: isConfirmed,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  Period toEntity() {
    return Period(
      id: id,
      startDate: startDate,
      endDate: endDate,
      flowIntensity: flowIntensity,
      notes: notes,
      isConfirmed: isConfirmed,
      symptoms: symptoms,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  PeriodModel copyWith({
    String? id,
    DateTime? startDate,
    DateTime? endDate,
    String? flowIntensity,
    String? notes,
    bool? isConfirmed,
    List<String>? symptoms,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PeriodModel(
      id: id ?? this.id,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      flowIntensity: flowIntensity ?? this.flowIntensity,
      notes: notes ?? this.notes,
      isConfirmed: isConfirmed ?? this.isConfirmed,
      symptoms: symptoms ?? this.symptoms,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
