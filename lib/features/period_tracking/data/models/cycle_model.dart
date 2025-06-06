import '../../domain/entities/cycle.dart';
import '../../domain/entities/period.dart';

class CycleModel extends Cycle {
  const CycleModel({
    required super.id,
    required super.startDate,
    super.endDate,
    required super.length,
    required super.periods,
    super.ovulationDate,
    super.fertileWindowStart,
    super.fertileWindowEnd,
    required super.isComplete,
    required super.createdAt,
  });

  factory CycleModel.fromEntity(Cycle cycle) {
    return CycleModel(
      id: cycle.id,
      startDate: cycle.startDate,
      endDate: cycle.endDate,
      length: cycle.length,
      periods: cycle.periods,
      ovulationDate: cycle.ovulationDate,
      fertileWindowStart: cycle.fertileWindowStart,
      fertileWindowEnd: cycle.fertileWindowEnd,
      isComplete: cycle.isComplete,
      createdAt: cycle.createdAt,
    );
  }

  Cycle toEntity() {
    return Cycle(
      id: id,
      startDate: startDate,
      endDate: endDate,
      length: length,
      periods: periods,
      ovulationDate: ovulationDate,
      fertileWindowStart: fertileWindowStart,
      fertileWindowEnd: fertileWindowEnd,
      isComplete: isComplete,
      createdAt: createdAt,
    );
  }
}
