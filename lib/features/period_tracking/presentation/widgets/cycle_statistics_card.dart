import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../../core/theme/app_theme.dart';

class CycleStatisticsCard extends StatelessWidget {
  final int averageCycleLength;
  final int averagePeriodLength;
  final int currentCycleDay;
  final int? previousCycleLength;
  final DateTime? lastPeriodDate;
  final int totalCyclesTracked;

  const CycleStatisticsCard({
    super.key,
    required this.averageCycleLength,
    required this.averagePeriodLength,
    required this.currentCycleDay,
    this.previousCycleLength,
    this.lastPeriodDate,
    this.totalCyclesTracked = 0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return ShadCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.analytics_rounded,
                  color: AppTheme.primaryPink,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Cycle Statistics',
                  style: theme.textTheme.h4?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Main statistics grid
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    theme,
                    'Average Cycle',
                    '$averageCycleLength days',
                    AppTheme.primaryPink,
                    Icons.loop,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatItem(
                    theme,
                    'Period Length',
                    '$averagePeriodLength days',
                    AppTheme.secondaryPurple,
                    Icons.water_drop,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    theme,
                    'Current Day',
                    'Day $currentCycleDay',
                    AppTheme.fertilityGreen,
                    Icons.today,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatItem(
                    theme,
                    'Cycles Tracked',
                    '$totalCyclesTracked',
                    AppTheme.ovulationBlue,
                    Icons.trending_up,
                  ),
                ),
              ],
            ),

            if (previousCycleLength != null) ...[
              const SizedBox(height: 20),
              _buildComparisonSection(theme),
            ],

            const SizedBox(height: 20),
            _buildInsightsSection(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    ShadThemeData theme,
    String label,
    String value,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 16),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  label,
                  style: theme.textTheme.small?.copyWith(
                    color: theme.colorScheme.mutedForeground,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.p?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonSection(ShadThemeData theme) {
    final difference = previousCycleLength! - averageCycleLength;
    final isLonger = difference > 0;
    final isEqual = difference == 0;

    Color indicatorColor;
    IconData indicatorIcon;
    String comparisonText;

    if (isEqual) {
      indicatorColor = AppTheme.fertilityGreen;
      indicatorIcon = Icons.check_circle;
      comparisonText = 'Same as average';
    } else if (isLonger) {
      indicatorColor = AppTheme.ovulationBlue;
      indicatorIcon = Icons.trending_up;
      comparisonText = '${difference.abs()} days longer';
    } else {
      indicatorColor = AppTheme.secondaryPurple;
      indicatorIcon = Icons.trending_down;
      comparisonText = '${difference.abs()} days shorter';
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.muted.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(indicatorIcon, color: indicatorColor, size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Last cycle vs average',
                  style: theme.textTheme.small?.copyWith(
                    color: theme.colorScheme.mutedForeground,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  comparisonText,
                  style: theme.textTheme.p?.copyWith(
                    color: indicatorColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '$previousCycleLength days',
            style: theme.textTheme.p?.copyWith(
              color: theme.colorScheme.foreground,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightsSection(ShadThemeData theme) {
    final insights = _generateInsights();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Insights',
          style: theme.textTheme.p?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.foreground,
          ),
        ),
        const SizedBox(height: 12),
        ...insights
            .map(
              (insight) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      margin: const EdgeInsets.only(top: 6, right: 12),
                      decoration: BoxDecoration(
                        color: insight.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        insight.text,
                        style: theme.textTheme.small?.copyWith(
                          color: theme.colorScheme.mutedForeground,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ],
    );
  }

  List<CycleInsight> _generateInsights() {
    final insights = <CycleInsight>[];

    // Cycle regularity insight
    if (averageCycleLength >= 21 && averageCycleLength <= 35) {
      insights.add(
        CycleInsight(
          text: 'Your cycle length is within the normal range (21-35 days)',
          color: AppTheme.fertilityGreen,
        ),
      );
    } else if (averageCycleLength < 21) {
      insights.add(
        CycleInsight(
          text:
              'Your cycles are shorter than average. Consider tracking for more accuracy.',
          color: AppTheme.secondaryPurple,
        ),
      );
    } else {
      insights.add(
        CycleInsight(
          text:
              'Your cycles are longer than average. This can be normal for some people.',
          color: AppTheme.ovulationBlue,
        ),
      );
    }

    // Period length insight
    if (averagePeriodLength >= 3 && averagePeriodLength <= 7) {
      insights.add(
        CycleInsight(
          text: 'Your period length is typical (3-7 days)',
          color: AppTheme.fertilityGreen,
        ),
      );
    }

    // Tracking progress insight
    if (totalCyclesTracked < 3) {
      insights.add(
        CycleInsight(
          text: 'Track more cycles for better predictions and insights',
          color: AppTheme.primaryPink,
        ),
      );
    } else if (totalCyclesTracked >= 6) {
      insights.add(
        CycleInsight(
          text: 'Great job tracking consistently! Your data is reliable.',
          color: AppTheme.fertilityGreen,
        ),
      );
    }

    return insights;
  }
}

class CycleInsight {
  final String text;
  final Color color;

  CycleInsight({required this.text, required this.color});
}
