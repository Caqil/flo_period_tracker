// lib/features/user_profile/presentation/pages/welcome_page.dart
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routes/route_names.dart';
import '../../../../core/theme/app_theme.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),

              // App logo and branding
              Column(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryPink,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryPink.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.favorite_rounded,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Welcome to Flo',
                    style: theme.textTheme.h1?.copyWith(
                      color: theme.colorScheme.foreground,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Your personal period tracking companion.\nTrack your cycle, symptoms, and insights - all stored privately on your device.',
                    style: theme.textTheme.p?.copyWith(
                      color: theme.colorScheme.mutedForeground,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              const Spacer(),

              // Features list
              Column(
                children: [
                  _buildFeatureItem(
                    theme,
                    Icons.calendar_month_rounded,
                    'Track Your Cycle',
                    'Log periods and predict future cycles',
                    AppTheme.primaryPink,
                  ),
                  const SizedBox(height: 16),
                  _buildFeatureItem(
                    theme,
                    Icons.favorite_rounded,
                    'Monitor Symptoms',
                    'Track symptoms and mood patterns',
                    AppTheme.secondaryPurple,
                  ),
                  const SizedBox(height: 16),
                  _buildFeatureItem(
                    theme,
                    Icons.analytics_rounded,
                    'Health Insights',
                    'Get personalized cycle insights',
                    AppTheme.fertilityGreen,
                  ),
                  const SizedBox(height: 16),
                  _buildFeatureItem(
                    theme,
                    Icons.lock_rounded,
                    'Private & Secure',
                    'All data stays on your device',
                    AppTheme.ovulationBlue,
                  ),
                ],
              ),

              const Spacer(),

              // Get started button
              ShadButton(
                onPressed: () => context.go(RouteNames.profileSetup),
                backgroundColor: AppTheme.primaryPink,
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Privacy note
              Text(
                'By continuing, you agree that all your data will be stored locally on your device and not shared with anyone.',
                style: theme.textTheme.small?.copyWith(
                  color: theme.colorScheme.mutedForeground,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(
    ShadThemeData theme,
    IconData icon,
    String title,
    String description,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.p?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.foreground,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
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
}
