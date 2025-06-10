import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';

class NextPeriodPredictionCard extends StatefulWidget {
  final DateTime predictedDate;
  final int confidenceLevel; // 1-5 scale
  final bool isLate;
  final int daysLate;
  final Function()? onSetReminder;

  const NextPeriodPredictionCard({
    super.key,
    required this.predictedDate,
    this.confidenceLevel = 3,
    this.isLate = false,
    this.daysLate = 0,
    this.onSetReminder,
  });

  // Calculate days until period automatically
  int get daysUntilPeriod {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final predictionDay = DateTime(
      predictedDate.year,
      predictedDate.month,
      predictedDate.day,
    );
    return predictionDay.difference(today).inDays;
  }

  @override
  State<NextPeriodPredictionCard> createState() =>
      _NextPeriodPredictionCardState();
}

class _NextPeriodPredictionCardState extends State<NextPeriodPredictionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: Transform.translate(
            offset: Offset(0, _slideAnimation.value),
            child: ShadCard(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    _buildHeader(theme),

                    const SizedBox(height: 20),

                    // Main prediction display
                    _buildMainPrediction(theme),

                    const SizedBox(height: 20),

                    // Confidence indicator
                    _buildConfidenceIndicator(theme),

                    const SizedBox(height: 20),

                    // Action buttons
                    _buildActionButtons(theme),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(ShadThemeData theme) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppTheme.primaryPink.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            widget.isLate ? Icons.warning : Icons.calendar_today,
            color: widget.isLate ? Colors.orange : AppTheme.primaryPink,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.isLate ? 'Period is Late' : 'Next Period',
                style: theme.textTheme.h4?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: widget.isLate
                      ? Colors.orange
                      : theme.colorScheme.foreground,
                ),
              ),
              Text(
                widget.isLate
                    ? 'Expected ${widget.daysLate} days ago'
                    : 'Prediction based on your cycle',
                style: theme.textTheme.small?.copyWith(
                  color: theme.colorScheme.mutedForeground,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMainPrediction(ShadThemeData theme) {
    final now = DateTime.now();
    final isToday =
        widget.predictedDate.year == now.year &&
        widget.predictedDate.month == now.month &&
        widget.predictedDate.day == now.day;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: widget.isLate
              ? [
                  Colors.orange.withOpacity(0.1),
                  Colors.orange.withOpacity(0.05),
                ]
              : [
                  AppTheme.primaryPink.withOpacity(0.1),
                  AppTheme.primaryPink.withOpacity(0.05),
                ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: widget.isLate
              ? Colors.orange.withOpacity(0.3)
              : AppTheme.primaryPink.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          if (isToday) ...[
            Icon(Icons.today, color: AppTheme.primaryPink, size: 32),
            const SizedBox(height: 8),
            Text(
              'Today',
              style: theme.textTheme.h2?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryPink,
              ),
            ),
          ] else ...[
            Text(
              DateFormat('EEEE').format(widget.predictedDate),
              style: theme.textTheme.p?.copyWith(
                color: theme.colorScheme.mutedForeground,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              DateFormat('MMM d, yyyy').format(widget.predictedDate),
              style: theme.textTheme.h2?.copyWith(
                fontWeight: FontWeight.bold,
                color: widget.isLate ? Colors.orange : AppTheme.primaryPink,
              ),
            ),
          ],

          const SizedBox(height: 12),

          // Days countdown
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: theme.colorScheme.background,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              widget.isLate
                  ? '${widget.daysLate} days late'
                  : widget.daysUntilPeriod == 0
                  ? 'Expected today'
                  : widget.daysUntilPeriod == 1
                  ? 'Tomorrow'
                  : 'In ${widget.daysUntilPeriod} days',
              style: theme.textTheme.p?.copyWith(
                fontWeight: FontWeight.w600,
                color: widget.isLate
                    ? Colors.orange
                    : widget.daysUntilPeriod <= 3
                    ? AppTheme.primaryPink
                    : theme.colorScheme.foreground,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfidenceIndicator(ShadThemeData theme) {
    final confidenceText = _getConfidenceText();
    final confidenceColor = _getConfidenceColor();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.analytics, color: confidenceColor, size: 16),
            const SizedBox(width: 8),
            Text(
              'Prediction Confidence',
              style: theme.textTheme.p?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.foreground,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Confidence level bars
        Row(
          children: [
            Expanded(
              child: Row(
                children: List.generate(5, (index) {
                  final isActive = index < widget.confidenceLevel;
                  return Expanded(
                    child: Container(
                      height: 6,
                      margin: const EdgeInsets.only(right: 4),
                      decoration: BoxDecoration(
                        color: isActive
                            ? confidenceColor
                            : theme.colorScheme.border,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              confidenceText,
              style: theme.textTheme.small?.copyWith(
                color: confidenceColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        Text(
          _getConfidenceDescription(),
          style: theme.textTheme.small?.copyWith(
            color: theme.colorScheme.mutedForeground,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(ShadThemeData theme) {
    return Row(
      children: [
        if (widget.onSetReminder != null) ...[
          Expanded(
            child: ShadButton.outline(
              onPressed: widget.onSetReminder,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_outlined,
                    size: 16,
                    color: AppTheme.primaryPink,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Set Reminder',
                    style: TextStyle(
                      color: AppTheme.primaryPink,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
        ],

        Expanded(
          child: ShadButton(
            onPressed: () {
              // Navigate to cycle details or calendar
            },
            backgroundColor: AppTheme.primaryPink,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.calendar_view_month,
                  size: 16,
                  color: Colors.white,
                ),
                const SizedBox(width: 8),
                Text(
                  widget.isLate ? 'Log Period' : 'View Calendar',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _getConfidenceText() {
    switch (widget.confidenceLevel) {
      case 1:
        return 'Very Low';
      case 2:
        return 'Low';
      case 3:
        return 'Medium';
      case 4:
        return 'High';
      case 5:
        return 'Very High';
      default:
        return 'Medium';
    }
  }

  Color _getConfidenceColor() {
    switch (widget.confidenceLevel) {
      case 1:
      case 2:
        return Colors.orange;
      case 3:
        return AppTheme.secondaryPurple;
      case 4:
      case 5:
        return AppTheme.fertilityGreen;
      default:
        return AppTheme.secondaryPurple;
    }
  }

  String _getConfidenceDescription() {
    if (widget.confidenceLevel <= 2) {
      return 'Track more cycles for better predictions';
    } else if (widget.confidenceLevel == 3) {
      return 'Based on recent cycle patterns';
    } else {
      return 'High accuracy based on consistent cycle data';
    }
  }
}
