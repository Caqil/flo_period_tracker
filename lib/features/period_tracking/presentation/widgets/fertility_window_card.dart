import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';

class FertilityWindowCard extends StatelessWidget {
  final DateTime? fertileWindowStart;
  final DateTime? fertileWindowEnd;
  final DateTime? ovulationDate;
  final bool isCurrentlyFertile;
  final bool isCurrentlyOvulating;
  final int daysToFertileWindow;
  final int daysToOvulation;

  const FertilityWindowCard({
    super.key,
    this.fertileWindowStart,
    this.fertileWindowEnd,
    this.ovulationDate,
    this.isCurrentlyFertile = false,
    this.isCurrentlyOvulating = false,
    this.daysToFertileWindow = 0,
    this.daysToOvulation = 0,
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
                Icon(Icons.eco, color: AppTheme.fertilityGreen, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Fertility Window',
                  style: theme.textTheme.h4?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Current status
            _buildCurrentStatus(theme),

            const SizedBox(height: 20),

            // Fertility window dates
            if (fertileWindowStart != null && fertileWindowEnd != null) ...[
              _buildDateSection(theme),
              const SizedBox(height: 20),
            ],

            // Timeline visualization
            if (fertileWindowStart != null) ...[
              _buildTimelineVisualization(context, theme),
              const SizedBox(height: 20),
            ],

            // Tips and information
            _buildTipsSection(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentStatus(ShadThemeData theme) {
    Color statusColor;
    IconData statusIcon;
    String statusTitle;
    String statusDescription;

    if (isCurrentlyOvulating) {
      statusColor = AppTheme.ovulationBlue;
      statusIcon = Icons.circle;
      statusTitle = 'Ovulation Day';
      statusDescription = 'Peak fertility - highest chance of conception';
    } else if (isCurrentlyFertile) {
      statusColor = AppTheme.fertilityGreen;
      statusIcon = Icons.eco;
      statusTitle = 'Fertile Window';
      statusDescription = 'High fertility period - conception is possible';
    } else if (daysToFertileWindow > 0 && daysToFertileWindow <= 7) {
      statusColor = AppTheme.secondaryPurple;
      statusIcon = Icons.schedule;
      statusTitle = 'Approaching Fertility';
      statusDescription = 'Fertile window starts in $daysToFertileWindow days';
    } else {
      statusColor = theme.colorScheme.mutedForeground;
      statusIcon = Icons.circle_outlined;
      statusTitle = 'Low Fertility';
      statusDescription = 'Outside fertile window';
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor.withOpacity(0.3), width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(statusIcon, color: statusColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  statusTitle,
                  style: theme.textTheme.p?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  statusDescription,
                  style: theme.textTheme.small?.copyWith(
                    color: theme.colorScheme.mutedForeground,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSection(ShadThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Important Dates',
          style: theme.textTheme.p?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.foreground,
          ),
        ),
        const SizedBox(height: 12),

        Row(
          children: [
            Expanded(
              child: _buildDateItem(
                theme,
                'Fertile Window',
                '${DateFormat('MMM d').format(fertileWindowStart!)} - ${DateFormat('MMM d').format(fertileWindowEnd!)}',
                AppTheme.fertilityGreen,
                Icons.eco,
              ),
            ),
            if (ovulationDate != null) ...[
              const SizedBox(width: 12),
              Expanded(
                child: _buildDateItem(
                  theme,
                  'Ovulation',
                  DateFormat('MMM d').format(ovulationDate!),
                  AppTheme.ovulationBlue,
                  Icons.circle,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildDateItem(
    ShadThemeData theme,
    String label,
    String date,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.muted.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 14),
              const SizedBox(width: 6),
              Text(
                label,
                style: theme.textTheme.small?.copyWith(
                  color: theme.colorScheme.mutedForeground,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            date,
            style: theme.textTheme.p?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineVisualization(
    BuildContext context,
    ShadThemeData theme,
  ) {
    final today = DateTime.now();
    final cycleStart = fertileWindowStart!.subtract(const Duration(days: 10));
    final cycleEnd = fertileWindowEnd!.add(const Duration(days: 10));
    final totalDays = cycleEnd.difference(cycleStart).inDays;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cycle Timeline',
          style: theme.textTheme.p?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.foreground,
          ),
        ),
        const SizedBox(height: 12),

        Container(
          height: 40,
          decoration: BoxDecoration(
            color: theme.colorScheme.muted.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              // Fertile window highlight
              Positioned(
                left:
                    (fertileWindowStart!.difference(cycleStart).inDays /
                        totalDays) *
                    MediaQuery.of(context).size.width *
                    0.7,
                width:
                    (fertileWindowEnd!.difference(fertileWindowStart!).inDays /
                        totalDays) *
                    MediaQuery.of(context).size.width *
                    0.7,
                top: 8,
                bottom: 8,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.fertilityGreen.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              // Ovulation marker
              if (ovulationDate != null)
                Positioned(
                  left:
                      (ovulationDate!.difference(cycleStart).inDays /
                          totalDays) *
                      MediaQuery.of(context).size.width *
                      0.7,
                  top: 12,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: AppTheme.ovulationBlue,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),

              // Today marker
              Positioned(
                left:
                    (today.difference(cycleStart).inDays / totalDays) *
                    MediaQuery.of(context).size.width *
                    0.7,
                top: 0,
                child: Container(
                  width: 2,
                  height: 40,
                  color: AppTheme.primaryPink,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        // Timeline labels
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Today',
              style: theme.textTheme.small?.copyWith(
                color: AppTheme.primaryPink,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Fertile Window',
              style: theme.textTheme.small?.copyWith(
                color: AppTheme.fertilityGreen,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (ovulationDate != null)
              Text(
                'Ovulation',
                style: theme.textTheme.small?.copyWith(
                  color: AppTheme.ovulationBlue,
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildTipsSection(ShadThemeData theme) {
    final tips = _getFertilityTips();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Fertility Tips',
          style: theme.textTheme.p?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.foreground,
          ),
        ),
        const SizedBox(height: 12),

        ...tips
            .map(
              (tip) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(tip.icon, size: 16, color: tip.color),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        tip.text,
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

  List<FertilityTip> _getFertilityTips() {
    if (isCurrentlyFertile || isCurrentlyOvulating) {
      return [
        FertilityTip(
          text: 'This is your most fertile time for conception',
          icon: Icons.favorite,
          color: AppTheme.primaryPink,
        ),
        FertilityTip(
          text: 'Track cervical mucus and basal body temperature',
          icon: Icons.thermostat,
          color: AppTheme.fertilityGreen,
        ),
        FertilityTip(
          text: 'Stay hydrated and maintain a healthy lifestyle',
          icon: Icons.local_drink,
          color: AppTheme.ovulationBlue,
        ),
      ];
    } else {
      return [
        FertilityTip(
          text: 'Prepare for your fertile window with good nutrition',
          icon: Icons.restaurant,
          color: AppTheme.fertilityGreen,
        ),
        FertilityTip(
          text: 'Regular exercise can support hormonal balance',
          icon: Icons.fitness_center,
          color: AppTheme.secondaryPurple,
        ),
        FertilityTip(
          text: 'Track symptoms to better understand your cycle',
          icon: Icons.track_changes,
          color: AppTheme.primaryPink,
        ),
      ];
    }
  }
}

class FertilityTip {
  final String text;
  final IconData icon;
  final Color color;

  FertilityTip({required this.text, required this.icon, required this.color});
}
