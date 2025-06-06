// lib/features/period_tracking/presentation/widgets/quick_log_card.dart

import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../../core/theme/app_theme.dart';

class QuickLogCard extends StatelessWidget {
  final VoidCallback onLogPeriod;
  final VoidCallback onLogSymptoms;

  const QuickLogCard({
    super.key,
    required this.onLogPeriod,
    required this.onLogSymptoms,
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
            Text(
              'Quick Actions',
              style: theme.textTheme.h4?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: ShadButton(
                    onPressed: onLogPeriod,
                    backgroundColor: AppTheme.primaryPink,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.water_drop, color: Colors.white, size: 18),
                        SizedBox(width: 8),
                        Text(
                          'Log Period',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ShadButton.outline(
                    onPressed: onLogSymptoms,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite,
                          color: AppTheme.primaryPink,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Log Symptoms',
                          style: TextStyle(
                            color: AppTheme.primaryPink,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
