import 'package:equatable/equatable.dart';

class CalendarDay extends Equatable {
  final DateTime date;
  final bool isPeriodDay;
  final bool isFertileDay;
  final bool isOvulationDay;
  final bool hasSymptoms;
  final bool hasMoodLog;
  final String? notes;
  final List<String> symptoms;
  final int? flowIntensity; // 1-4 scale
  final String? mood;

  const CalendarDay({
    required this.date,
    this.isPeriodDay = false,
    this.isFertileDay = false,
    this.isOvulationDay = false,
    this.hasSymptoms = false,
    this.hasMoodLog = false,
    this.notes,
    this.symptoms = const [],
    this.flowIntensity,
    this.mood,
  });

  CalendarDay copyWith({
    DateTime? date,
    bool? isPeriodDay,
    bool? isFertileDay,
    bool? isOvulationDay,
    bool? hasSymptoms,
    bool? hasMoodLog,
    String? notes,
    List<String>? symptoms,
    int? flowIntensity,
    String? mood,
  }) {
    return CalendarDay(
      date: date ?? this.date,
      isPeriodDay: isPeriodDay ?? this.isPeriodDay,
      isFertileDay: isFertileDay ?? this.isFertileDay,
      isOvulationDay: isOvulationDay ?? this.isOvulationDay,
      hasSymptoms: hasSymptoms ?? this.hasSymptoms,
      hasMoodLog: hasMoodLog ?? this.hasMoodLog,
      notes: notes ?? this.notes,
      symptoms: symptoms ?? this.symptoms,
      flowIntensity: flowIntensity ?? this.flowIntensity,
      mood: mood ?? this.mood,
    );
  }

  @override
  List<Object?> get props => [
    date,
    isPeriodDay,
    isFertileDay,
    isOvulationDay,
    hasSymptoms,
    hasMoodLog,
    notes,
    symptoms,
    flowIntensity,
    mood,
  ];
}
