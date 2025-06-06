import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

import '../bloc/calendar_bloc.dart';
import '../../domain/entities/calendar_day.dart';
import '../../../../config/routes/route_names.dart';
import '../../../../core/theme/app_theme.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late final ValueNotifier<DateTime> _selectedDay;
  late final ValueNotifier<DateTime> _focusedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    _selectedDay = ValueNotifier(DateTime.now());
    _focusedDay = ValueNotifier(DateTime.now());

    context.read<CalendarBloc>().add(
      CalendarLoadRequested(
        startDate: DateTime.now().subtract(const Duration(days: 90)),
        endDate: DateTime.now().add(const Duration(days: 90)),
      ),
    );
  }

  @override
  void dispose() {
    _selectedDay.dispose();
    _focusedDay.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Calendar',
          style: theme.textTheme.h3?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.foreground,
          ),
        ),
        actions: [
          ShadButton.ghost(
            onPressed: () {
              setState(() {
                _selectedDay.value = DateTime.now();
                _focusedDay.value = DateTime.now();
              });
            },
            child: const Icon(Icons.today),
          ),
        ],
      ),
      body: BlocBuilder<CalendarBloc, CalendarState>(
        builder: (context, state) {
          if (state is CalendarLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CalendarError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: theme.colorScheme.destructive,
                  ),
                  const SizedBox(height: 16),
                  Text('Failed to load calendar', style: theme.textTheme.h4),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    style: theme.textTheme.p?.copyWith(
                      color: theme.colorScheme.mutedForeground,
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is CalendarLoaded) {
            return Column(
              children: [
                // Calendar
                ShadCard(
                  margin: const EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: ValueListenableBuilder<DateTime>(
                      valueListenable: _selectedDay,
                      builder: (context, selectedDay, _) {
                        return ValueListenableBuilder<DateTime>(
                          valueListenable: _focusedDay,
                          builder: (context, focusedDay, _) {
                            return TableCalendar<CalendarDay>(
                              firstDay: DateTime.utc(2020, 1, 1),
                              lastDay: DateTime.utc(2030, 12, 31),
                              focusedDay: focusedDay,
                              selectedDayPredicate: (day) =>
                                  isSameDay(selectedDay, day),
                              calendarFormat: _calendarFormat,
                              eventLoader: (day) {
                                return state.calendarData
                                    .where((data) => isSameDay(data.date, day))
                                    .toList();
                              },
                              startingDayOfWeek: StartingDayOfWeek.monday,
                              calendarStyle: CalendarStyle(
                                outsideDaysVisible: false,
                                weekendTextStyle: TextStyle(
                                  color: theme.colorScheme.mutedForeground,
                                ),
                                holidayTextStyle: TextStyle(
                                  color: theme.colorScheme.mutedForeground,
                                ),
                                selectedDecoration: BoxDecoration(
                                  color: AppTheme.primaryPink,
                                  shape: BoxShape.circle,
                                ),
                                todayDecoration: BoxDecoration(
                                  color: AppTheme.primaryPink.withOpacity(0.3),
                                  shape: BoxShape.circle,
                                ),
                                markerDecoration: BoxDecoration(
                                  color: AppTheme.primaryPink,
                                  shape: BoxShape.circle,
                                ),
                                markersMaxCount: 3,
                              ),
                              headerStyle: HeaderStyle(
                                formatButtonVisible: true,
                                titleCentered: true,
                                formatButtonDecoration: BoxDecoration(
                                  color: AppTheme.primaryPink.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                formatButtonTextStyle: TextStyle(
                                  color: AppTheme.primaryPink,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              calendarBuilders: CalendarBuilders(
                                defaultBuilder: (context, day, focusedDay) {
                                  return _buildDayCell(
                                    day,
                                    state.calendarData,
                                    theme,
                                  );
                                },
                                selectedBuilder: (context, day, focusedDay) {
                                  return _buildDayCell(
                                    day,
                                    state.calendarData,
                                    theme,
                                    isSelected: true,
                                  );
                                },
                                todayBuilder: (context, day, focusedDay) {
                                  return _buildDayCell(
                                    day,
                                    state.calendarData,
                                    theme,
                                    isToday: true,
                                  );
                                },
                              ),
                              onDaySelected: (selectedDay, focusedDay) {
                                _selectedDay.value = selectedDay;
                                _focusedDay.value = focusedDay;
                              },
                              onFormatChanged: (format) {
                                setState(() {
                                  _calendarFormat = format;
                                });
                              },
                              onPageChanged: (focusedDay) {
                                _focusedDay.value = focusedDay;
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),

                // Legend
                _buildLegend(theme),

                // Selected day details
                Expanded(
                  child: ValueListenableBuilder<DateTime>(
                    valueListenable: _selectedDay,
                    builder: (context, selectedDay, _) {
                      final dayData = state.calendarData.firstWhere(
                        (data) => isSameDay(data.date, selectedDay),
                        orElse: () => CalendarDay(date: selectedDay),
                      );
                      return _buildDayDetails(theme, dayData);
                    },
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildDayCell(
    DateTime day,
    List<CalendarDay> calendarData,
    ShadThemeData theme, {
    bool isSelected = false,
    bool isToday = false,
  }) {
    final dayData = calendarData.firstWhere(
      (data) => isSameDay(data.date, day),
      orElse: () => CalendarDay(date: day),
    );

    Color? backgroundColor;
    if (isSelected) {
      backgroundColor = AppTheme.primaryPink;
    } else if (isToday) {
      backgroundColor = AppTheme.primaryPink.withOpacity(0.3);
    } else if (dayData.isPeriodDay) {
      backgroundColor = AppTheme.primaryPink.withOpacity(0.6);
    } else if (dayData.isFertileDay) {
      backgroundColor = AppTheme.fertilityGreen.withOpacity(0.6);
    } else if (dayData.isOvulationDay) {
      backgroundColor = AppTheme.ovulationBlue.withOpacity(0.6);
    }

    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: dayData.hasSymptoms
            ? Border.all(color: AppTheme.secondaryPurple, width: 2)
            : null,
      ),
      child: Center(
        child: Text(
          '${day.day}',
          style: TextStyle(
            color: backgroundColor != null
                ? Colors.white
                : theme.colorScheme.foreground,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildLegend(ShadThemeData theme) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ShadCard(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Legend',
                style: theme.textTheme.p?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 16,
                runSpacing: 8,
                children: [
                  _buildLegendItem(
                    theme,
                    'Period',
                    AppTheme.primaryPink,
                    Icons.water_drop,
                  ),
                  _buildLegendItem(
                    theme,
                    'Fertile',
                    AppTheme.fertilityGreen,
                    Icons.eco,
                  ),
                  _buildLegendItem(
                    theme,
                    'Ovulation',
                    AppTheme.ovulationBlue,
                    Icons.circle,
                  ),
                  _buildLegendItem(
                    theme,
                    'Symptoms',
                    AppTheme.secondaryPurple,
                    Icons.favorite,
                    isBorder: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLegendItem(
    ShadThemeData theme,
    String label,
    Color color,
    IconData icon, {
    bool isBorder = false,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: isBorder ? Colors.transparent : color,
            shape: BoxShape.circle,
            border: isBorder ? Border.all(color: color, width: 2) : null,
          ),
          child: isBorder ? null : Icon(icon, size: 10, color: Colors.white),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: theme.textTheme.small?.copyWith(
            color: theme.colorScheme.mutedForeground,
          ),
        ),
      ],
    );
  }

  Widget _buildDayDetails(ShadThemeData theme, CalendarDay dayData) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: ShadCard(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    DateFormat('EEEE, MMMM d').format(dayData.date),
                    style: theme.textTheme.h4?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  ShadButton.ghost(
                    onPressed: () {
                      context.go(
                        '${RouteNames.logPeriod}/${dayData.date.toIso8601String()}',
                      );
                    },
                    child: const Icon(Icons.add),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              if (dayData.isPeriodDay) ...[
                _buildDayStatusChip(
                  theme,
                  'Period Day',
                  AppTheme.primaryPink,
                  Icons.water_drop,
                ),
                const SizedBox(height: 8),
              ],

              if (dayData.isFertileDay) ...[
                _buildDayStatusChip(
                  theme,
                  'Fertile Window',
                  AppTheme.fertilityGreen,
                  Icons.eco,
                ),
                const SizedBox(height: 8),
              ],

              if (dayData.isOvulationDay) ...[
                _buildDayStatusChip(
                  theme,
                  'Ovulation Day',
                  AppTheme.ovulationBlue,
                  Icons.circle,
                ),
                const SizedBox(height: 8),
              ],

              if (dayData.hasSymptoms) ...[
                _buildDayStatusChip(
                  theme,
                  'Symptoms Logged',
                  AppTheme.secondaryPurple,
                  Icons.favorite,
                ),
                const SizedBox(height: 8),
              ],

              if (dayData.notes?.isNotEmpty == true) ...[
                const SizedBox(height: 16),
                Text(
                  'Notes',
                  style: theme.textTheme.p?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.muted.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    dayData.notes!,
                    style: theme.textTheme.p?.copyWith(
                      color: theme.colorScheme.mutedForeground,
                    ),
                  ),
                ),
              ],

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: ShadButton(
                  onPressed: () {
                    context.go(
                      '${RouteNames.dayDetails}/${dayData.date.toIso8601String()}',
                    );
                  },
                  backgroundColor: AppTheme.primaryPink,
                  child: const Text(
                    'View Details',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDayStatusChip(
    ShadThemeData theme,
    String label,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: theme.textTheme.small?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
