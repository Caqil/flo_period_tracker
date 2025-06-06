import 'package:equatable/equatable.dart';

import 'period.dart';

class Cycle extends Equatable {
  final String id;
  final DateTime startDate;
  final DateTime? endDate;
  final int length;
  final List<Period> periods;
  final DateTime? ovulationDate;
  final DateTime? fertileWindowStart;
  final DateTime? fertileWindowEnd;
  final bool isComplete;
  final DateTime createdAt;

  const Cycle({
    required this.id,
    required this.startDate,
    this.endDate,
    required this.length,
    required this.periods,
    this.ovulationDate,
    this.fertileWindowStart,
    this.fertileWindowEnd,
    required this.isComplete,
    required this.createdAt,
  });

  int get currentDay {
    final today = DateTime.now();
    final daysSinceStart = today.difference(startDate).inDays + 1;
    return daysSinceStart;
  }

  bool get isPeriodDay {
    final today = DateTime.now();
    return periods.any((period) {
      final periodEnd = period.endDate ?? period.startDate;
      return today.isAfter(
            period.startDate.subtract(const Duration(days: 1)),
          ) &&
          today.isBefore(periodEnd.add(const Duration(days: 1)));
    });
  }

  bool get isFertileDay {
    if (fertileWindowStart == null || fertileWindowEnd == null) return false;

    final today = DateTime.now();
    return today.isAfter(
          fertileWindowStart!.subtract(const Duration(days: 1)),
        ) &&
        today.isBefore(fertileWindowEnd!.add(const Duration(days: 1)));
  }

  bool get isOvulationDay {
    if (ovulationDate == null) return false;

    final today = DateTime.now();
    return today.year == ovulationDate!.year &&
        today.month == ovulationDate!.month &&
        today.day == ovulationDate!.day;
  }

  Cycle copyWith({
    String? id,
    DateTime? startDate,
    DateTime? endDate,
    int? length,
    List<Period>? periods,
    DateTime? ovulationDate,
    DateTime? fertileWindowStart,
    DateTime? fertileWindowEnd,
    bool? isComplete,
    DateTime? createdAt,
  }) {
    return Cycle(
      id: id ?? this.id,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      length: length ?? this.length,
      periods: periods ?? this.periods,
      ovulationDate: ovulationDate ?? this.ovulationDate,
      fertileWindowStart: fertileWindowStart ?? this.fertileWindowStart,
      fertileWindowEnd: fertileWindowEnd ?? this.fertileWindowEnd,
      isComplete: isComplete ?? this.isComplete,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    startDate,
    endDate,
    length,
    periods,
    ovulationDate,
    fertileWindowStart,
    fertileWindowEnd,
    isComplete,
    createdAt,
  ];
}
