import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';

class PeriodCalendarWidget extends StatefulWidget {
  final DateTime? selectedDay;
  final Function(DateTime)? onDaySelected;
  final List<DateTime> periodDays;
  final List<DateTime> fertileDays;
  final List<DateTime> ovulationDays;
  final List<DateTime> symptomDays;
  final Map<DateTime, String> flowIntensities;
  final bool isCompact;

  const PeriodCalendarWidget({
    super.key,
    this.selectedDay,
    this.onDaySelected,
    this.periodDays = const [],
    this.fertileDays = const [],
    this.ovulationDays = const [],
    this.symptomDays = const [],
    this.flowIntensities = const {},
    this.isCompact = false,
  });

  @override
  State<PeriodCalendarWidget> createState() => _PeriodCalendarWidgetState();
}

class _PeriodCalendarWidgetState extends State<PeriodCalendarWidget>
    with SingleTickerProviderStateMixin {
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = widget.selectedDay ?? DateTime.now();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void didUpdateWidget(PeriodCalendarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDay != null && widget.selectedDay != _selectedDay) {
      setState(() {
        _selectedDay = widget.selectedDay!;
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return ShadCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Calendar header with navigation
            if (!widget.isCompact) _buildCalendarHeader(theme),

            // Calendar widget
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _animationController,
                  child: TableCalendar<DateTime>(
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: _focusedDay,
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    calendarFormat: widget.isCompact
                        ? CalendarFormat.week
                        : _calendarFormat,
                    eventLoader: _getEventsForDay,
                    startingDayOfWeek: StartingDayOfWeek.monday,

                    // Styling
                    calendarStyle: CalendarStyle(
                      outsideDaysVisible: !widget.isCompact,
                      weekendTextStyle: TextStyle(
                        color: theme.colorScheme.mutedForeground,
                      ),
                      holidayTextStyle: TextStyle(
                        color: theme.colorScheme.mutedForeground,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: AppTheme.primaryPink,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primaryPink.withOpacity(0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      todayDecoration: BoxDecoration(
                        color: AppTheme.primaryPink.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      markerDecoration: const BoxDecoration(
                        color: AppTheme.primaryPink,
                        shape: BoxShape.circle,
                      ),
                      markersMaxCount: 1,
                      markerSize: 6,
                    ),

                    headerStyle: HeaderStyle(
                      formatButtonVisible: !widget.isCompact,
                      titleCentered: true,
                      formatButtonDecoration: BoxDecoration(
                        color: AppTheme.primaryPink.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      formatButtonTextStyle: const TextStyle(
                        color: AppTheme.primaryPink,
                        fontWeight: FontWeight.w600,
                      ),
                      leftChevronIcon: Icon(
                        Icons.chevron_left,
                        color: theme.colorScheme.foreground,
                      ),
                      rightChevronIcon: Icon(
                        Icons.chevron_right,
                        color: theme.colorScheme.foreground,
                      ),
                    ),

                    // Custom day builders
                    calendarBuilders: CalendarBuilders(
                      defaultBuilder: (context, day, focusedDay) {
                        return _buildDayCell(day, theme, false, false);
                      },
                      selectedBuilder: (context, day, focusedDay) {
                        return _buildDayCell(day, theme, true, false);
                      },
                      todayBuilder: (context, day, focusedDay) {
                        return _buildDayCell(day, theme, false, true);
                      },
                      outsideBuilder: (context, day, focusedDay) {
                        return _buildDayCell(
                          day,
                          theme,
                          false,
                          false,
                          isOutside: true,
                        );
                      },
                      markerBuilder: (context, day, events) {
                        return _buildDayMarkers(day, theme);
                      },
                    ),

                    // Event handlers
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                      widget.onDaySelected?.call(selectedDay);
                    },
                    onFormatChanged: (format) {
                      if (!widget.isCompact) {
                        setState(() {
                          _calendarFormat = format;
                        });
                      }
                    },
                    onPageChanged: (focusedDay) {
                      setState(() {
                        _focusedDay = focusedDay;
                      });
                    },
                  ),
                );
              },
            ),

            // Legend
            if (!widget.isCompact) ...[
              const SizedBox(height: 16),
              _buildLegend(theme),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarHeader(ShadThemeData theme) {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.calendar_month, color: AppTheme.primaryPink, size: 20),
            const SizedBox(width: 8),
            Text(
              'Period Calendar',
              style: theme.textTheme.h4?.copyWith(fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            ShadButton.ghost(
              onPressed: () {
                setState(() {
                  _focusedDay = DateTime.now();
                  _selectedDay = DateTime.now();
                });
              },
              child: const Icon(Icons.today, size: 18),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDayCell(
    DateTime day,
    ShadThemeData theme,
    bool isSelected,
    bool isToday, {
    bool isOutside = false,
  }) {
    final isPeriodDay = _isDayInList(day, widget.periodDays);
    final isFertileDay = _isDayInList(day, widget.fertileDays);
    final isOvulationDay = _isDayInList(day, widget.ovulationDays);
    final hasSymptoms = _isDayInList(day, widget.symptomDays);

    Color? backgroundColor;
    Color? borderColor;
    List<BoxShadow>? shadows;

    if (isSelected) {
      backgroundColor = AppTheme.primaryPink;
      shadows = [
        BoxShadow(
          color: AppTheme.primaryPink.withOpacity(0.3),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ];
    } else if (isToday) {
      backgroundColor = AppTheme.primaryPink.withOpacity(0.3);
    } else if (isPeriodDay) {
      final intensity = widget.flowIntensities[day];
      backgroundColor = _getFlowIntensityColor(intensity);
    } else if (isOvulationDay) {
      backgroundColor = AppTheme.ovulationBlue.withOpacity(0.7);
    } else if (isFertileDay) {
      backgroundColor = AppTheme.fertilityGreen.withOpacity(0.6);
    }

    if (hasSymptoms && !isPeriodDay) {
      borderColor = AppTheme.secondaryPurple;
    }

    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: borderColor != null
            ? Border.all(color: borderColor, width: 2)
            : null,
        boxShadow: shadows,
      ),
      child: Center(
        child: Text(
          '${day.day}',
          style: TextStyle(
            color: isOutside
                ? theme.colorScheme.mutedForeground.withOpacity(0.5)
                : (backgroundColor != null && !isToday)
                ? Colors.white
                : theme.colorScheme.foreground,
            fontWeight: isSelected || isToday
                ? FontWeight.bold
                : FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildDayMarkers(DateTime day, ShadThemeData theme) {
    final hasSymptoms = _isDayInList(day, widget.symptomDays);

    if (!hasSymptoms) return const SizedBox.shrink();

    return Positioned(
      bottom: 2,
      right: 2,
      child: Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(
          color: AppTheme.secondaryPurple,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildLegend(ShadThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.muted.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
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

          const SizedBox(height: 12),

          // Flow intensity legend
          Row(
            children: [
              Text(
                'Flow: ',
                style: theme.textTheme.small?.copyWith(
                  color: theme.colorScheme.mutedForeground,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
              _buildFlowIntensityLegend(theme),
            ],
          ),
        ],
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
          child: isBorder ? null : Icon(icon, size: 8, color: Colors.white),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: theme.textTheme.small?.copyWith(
            color: theme.colorScheme.mutedForeground,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildFlowIntensityLegend(ShadThemeData theme) {
    return Row(
      children: [
        _buildFlowDot(const Color(0xFFFFE0B2), 'Spotting'),
        const SizedBox(width: 4),
        _buildFlowDot(const Color(0xFFFFCDD2), 'Light'),
        const SizedBox(width: 4),
        _buildFlowDot(AppTheme.primaryPink.withOpacity(0.7), 'Medium'),
        const SizedBox(width: 4),
        _buildFlowDot(AppTheme.primaryPink, 'Heavy'),
      ],
    );
  }

  Widget _buildFlowDot(Color color, String tooltip) {
    return Tooltip(
      message: tooltip,
      child: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }

  List<DateTime> _getEventsForDay(DateTime day) {
    // Return a list of events for this day (used by TableCalendar)
    final events = <DateTime>[];

    if (_isDayInList(day, widget.periodDays)) events.add(day);
    if (_isDayInList(day, widget.fertileDays)) events.add(day);
    if (_isDayInList(day, widget.ovulationDays)) events.add(day);
    if (_isDayInList(day, widget.symptomDays)) events.add(day);

    return events;
  }

  bool _isDayInList(DateTime day, List<DateTime> dateList) {
    return dateList.any(
      (date) =>
          date.year == day.year &&
          date.month == day.month &&
          date.day == day.day,
    );
  }

  Color _getFlowIntensityColor(String? intensity) {
    switch (intensity?.toLowerCase()) {
      case 'spotting':
        return const Color(0xFFFFE0B2);
      case 'light':
        return const Color(0xFFFFCDD2);
      case 'medium':
        return AppTheme.primaryPink.withOpacity(0.7);
      case 'heavy':
        return AppTheme.primaryPink;
      default:
        return AppTheme.primaryPink.withOpacity(0.7);
    }
  }
}
