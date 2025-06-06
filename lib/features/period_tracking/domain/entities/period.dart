import 'package:equatable/equatable.dart';

class Period extends Equatable {
  final String id;
  final DateTime startDate;
  final DateTime? endDate;
  final String flowIntensity; // light, medium, heavy, spotting
  final String? notes;
  final bool isConfirmed;
  final List<String> symptoms;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Period({
    required this.id,
    required this.startDate,
    this.endDate,
    required this.flowIntensity,
    this.notes,
    required this.isConfirmed,
    this.symptoms = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  int get durationDays {
    if (endDate == null) return 1;
    return endDate!.difference(startDate).inDays + 1;
  }

  bool get isActive => endDate == null;

  Period copyWith({
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
    return Period(
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

  @override
  List<Object?> get props => [
    id,
    startDate,
    endDate,
    flowIntensity,
    notes,
    isConfirmed,
    symptoms,
    createdAt,
    updatedAt,
  ];
}
