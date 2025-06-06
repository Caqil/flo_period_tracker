// lib/features/calendar/data/datasources/calendar_local_datasource.dart

import 'package:injectable/injectable.dart';

import '../../domain/entities/calendar_day.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/error/exceptions.dart';

abstract class CalendarLocalDatasource {
  Future<List<CalendarDay>> getCalendarData({
    required DateTime startDate,
    required DateTime endDate,
  });

  Future<CalendarDay> getDayDetails(DateTime date);
}

@LazySingleton(as: CalendarLocalDatasource)
class CalendarLocalDatasourceImpl implements CalendarLocalDatasource {
  final AppDatabase _database;

  CalendarLocalDatasourceImpl(this._database);

  @override
  Future<List<CalendarDay>> getCalendarData({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      // Get periods in date range
      final periods = await _database.periodDao.getPeriodsInRange(
        startDate,
        endDate,
      );

      // Get symptoms in date range
      final symptoms = await _database.symptomDao.getSymptomsInRange(
        startDate,
        endDate,
      );

      // Get moods in date range
      final moods = await _database.moodDao.getMoodsInRange(startDate, endDate);

      // Generate calendar days for the range
      final calendarDays = <CalendarDay>[];
      final currentDate = DateTime(
        startDate.year,
        startDate.month,
        startDate.day,
      );
      final endDateOnly = DateTime(endDate.year, endDate.month, endDate.day);

      while (!currentDate.isAfter(endDateOnly)) {
        // Check if this date has period data
        final periodData = periods.where((p) {
          final startDay = DateTime(
            p.startDate.year,
            p.startDate.month,
            p.startDate.day,
          );
          final endDay = p.endDate != null
              ? DateTime(p.endDate!.year, p.endDate!.month, p.endDate!.day)
              : startDay;
          return !currentDate.isBefore(startDay) &&
              !currentDate.isAfter(endDay);
        });

        // Check symptoms for this date
        final daySymptoms = symptoms.where((s) {
          final symptomDate = DateTime(s.date.year, s.date.month, s.date.day);
          return symptomDate == currentDate;
        }).toList();

        // Check mood for this date
        final dayMoods = moods.where((m) {
          final moodDate = DateTime(m.date.year, m.date.month, m.date.day);
          return moodDate == currentDate;
        }).toList();

        // Calculate fertile window and ovulation (simplified calculation)
        final isPeriodDay = periodData.isNotEmpty;
        final cycleDay = _calculateCycleDay(currentDate, periods);
        final isFertileDay = cycleDay >= 10 && cycleDay <= 17;
        final isOvulationDay = cycleDay == 14;

        calendarDays.add(
          CalendarDay(
            date: DateTime(
              currentDate.year,
              currentDate.month,
              currentDate.day,
            ),
            isPeriodDay: isPeriodDay,
            isFertileDay: isFertileDay && !isPeriodDay,
            isOvulationDay: isOvulationDay && !isPeriodDay,
            hasSymptoms: daySymptoms.isNotEmpty,
            hasMoodLog: dayMoods.isNotEmpty,
            symptoms: daySymptoms.map((s) => s.name).toList(),
            flowIntensity: periodData.isNotEmpty
                ? _getFlowIntensity(periodData.first.flowIntensity)
                : null,
            mood: dayMoods.isNotEmpty ? dayMoods.first.mood : null,
          ),
        );

        currentDate.add(const Duration(days: 1));
      }

      return calendarDays;
    } catch (e) {
      throw DatabaseException(message: 'Failed to load calendar data: $e');
    }
  }

  @override
  Future<CalendarDay> getDayDetails(DateTime date) async {
    try {
      final dayOnly = DateTime(date.year, date.month, date.day);

      // Get period data for this specific date
      final periods = await _database.periodDao.getPeriodsInRange(
        dayOnly,
        dayOnly,
      );
      final symptoms = await _database.symptomDao.getSymptomsInRange(
        dayOnly,
        dayOnly,
      );
      final moods = await _database.moodDao.getMoodsInRange(dayOnly, dayOnly);

      final isPeriodDay = periods.isNotEmpty;
      final cycleDay = _calculateCycleDay(
        dayOnly,
        await _database.periodDao.getAllPeriods(),
      );
      final isFertileDay = cycleDay >= 10 && cycleDay <= 17;
      final isOvulationDay = cycleDay == 14;

      return CalendarDay(
        date: dayOnly,
        isPeriodDay: isPeriodDay,
        isFertileDay: isFertileDay && !isPeriodDay,
        isOvulationDay: isOvulationDay && !isPeriodDay,
        hasSymptoms: symptoms.isNotEmpty,
        hasMoodLog: moods.isNotEmpty,
        symptoms: symptoms.map((s) => s.name).toList(),
        flowIntensity: isPeriodDay
            ? _getFlowIntensity(periods.first.flowIntensity)
            : null,
        mood: moods.isNotEmpty ? moods.first.mood : null,
      );
    } catch (e) {
      throw DatabaseException(message: 'Failed to load day details: $e');
    }
  }

  int _calculateCycleDay(DateTime date, List<dynamic> periods) {
    if (periods.isEmpty) return 1;

    // Find the most recent period start before or on this date
    final sortedPeriods = periods
        .where(
          (p) =>
              p.startDate.isBefore(date) ||
              DateTime(p.startDate.year, p.startDate.month, p.startDate.day) ==
                  DateTime(date.year, date.month, date.day),
        )
        .toList();

    if (sortedPeriods.isEmpty) return 1;

    sortedPeriods.sort((a, b) => b.startDate.compareTo(a.startDate));
    final lastPeriod = sortedPeriods.first;

    return date.difference(lastPeriod.startDate).inDays + 1;
  }

  int _getFlowIntensity(String flowIntensity) {
    switch (flowIntensity.toLowerCase()) {
      case 'spotting':
        return 1;
      case 'light':
        return 2;
      case 'medium':
        return 3;
      case 'heavy':
        return 4;
      default:
        return 2;
    }
  }
}
