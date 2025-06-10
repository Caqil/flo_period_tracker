import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:go_router/go_router.dart';

import '../bloc/period_bloc.dart';
import '../../../../config/routes/route_names.dart';
import '../../../../core/theme/app_theme.dart';
import '../widgets/cycle_ring_chart.dart';
import '../widgets/next_period_prediction_card.dart';
import '../widgets/quick_log_card.dart';

class PeriodHomePage extends StatefulWidget {
  const PeriodHomePage({super.key});

  @override
  State<PeriodHomePage> createState() => _PeriodHomePageState();
}

class _PeriodHomePageState extends State<PeriodHomePage> {
  @override
  void initState() {
    super.initState();
    context.read<PeriodBloc>().add(const PeriodLoadRequested());
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
          'Flo',
          style: theme.textTheme.h3?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.foreground,
          ),
        ),
        actions: [
          ShadButton.ghost(
            onPressed: () => context.go(RouteNames.profile),
            child: const Icon(Icons.person_rounded),
          ),
        ],
      ),
      body: BlocBuilder<PeriodBloc, PeriodState>(
        builder: (context, state) {
          if (state is PeriodLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PeriodError) {
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
                  Text('Something went wrong', style: theme.textTheme.h4),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    style: theme.textTheme.p?.copyWith(
                      color: theme.colorScheme.mutedForeground,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ShadButton(
                    onPressed: () {
                      context.read<PeriodBloc>().add(
                        const PeriodLoadRequested(),
                      );
                    },
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Welcome message
                _buildWelcomeCard(theme),

                const SizedBox(height: 24),

                // Cycle overview
                if (state is PeriodLoaded && state.currentCycle != null)
                  CycleRingChart(
                    currentDay: state.currentCycle!.currentDay,
                    cycleLength: state.currentCycle!.length,
                    isPeriodDay: state.currentCycle!.isPeriodDay,
                    isFertileDay: state.currentCycle!.isFertileDay,
                  ),

                const SizedBox(height: 24),

                // Next period prediction
                if (state is PeriodLoaded && state.nextPeriodPrediction != null)
                  NextPeriodPredictionCard(
                    predictedDate: state.nextPeriodPrediction!,
                    confidenceLevel: 4, // optional
                    isLate: false, // optional
                    onSetReminder: () {}, // optional
                  ),

                const SizedBox(height: 16),

                // Quick actions
                QuickLogCard(
                  onLogPeriod: () {
                    context.go(
                      '${RouteNames.logPeriod}/${DateTime.now().toIso8601String()}',
                    );
                  },
                  onLogSymptoms: () {
                    context.go(RouteNames.symptoms);
                  },
                ),

                const SizedBox(height: 24),

                // Today's insights
                _buildInsightsCard(theme),

                const SizedBox(height: 100), // Bottom navigation space
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildWelcomeCard(ShadThemeData theme) {
    return ShadCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppTheme.primaryPink.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.waving_hand,
                color: AppTheme.primaryPink,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Good morning!',
                    style: theme.textTheme.h4?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'How are you feeling today?',
                    style: theme.textTheme.p?.copyWith(
                      color: theme.colorScheme.mutedForeground,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInsightsCard(ShadThemeData theme) {
    return ShadCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.lightbulb_outline,
                  color: AppTheme.primaryPink,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Today\'s Insights',
                  style: theme.textTheme.h4?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.fertilityGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.eco,
                    color: AppTheme.fertilityGreen,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'You\'re in your fertile window. Consider tracking any symptoms.',
                      style: theme.textTheme.p?.copyWith(
                        color: AppTheme.fertilityGreen,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
