import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/user_profile/presentation/bloc/user_profile_bloc.dart';
import '../../features/onboarding/presentation/pages/splash_page.dart';
import '../../features/user_profile/presentation/pages/welcome_page.dart';
import '../../features/user_profile/presentation/pages/profile_setup_page.dart';
import '../../features/period_tracking/presentation/pages/period_home_page.dart';
import '../../features/calendar/presentation/pages/calendar_page.dart';
import '../../features/symptom_tracking/presentation/pages/symptom_tracker_page.dart';
import '../../features/analytics/presentation/pages/analytics_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../shared/presentation/layouts/main_layout.dart';
import 'route_names.dart';
import 'route_guards.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.splash,
    redirect: RouteGuards.profileGuard,
    routes: [
      // Splash route
      GoRoute(
        path: RouteNames.splash,
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),

      // Welcome and setup routes
      GoRoute(
        path: RouteNames.welcome,
        name: 'welcome',
        builder: (context, state) => const WelcomePage(),
      ),
      GoRoute(
        path: RouteNames.profileSetup,
        name: 'profileSetup',
        builder: (context, state) => const ProfileSetupPage(),
      ),

      // Main app shell with bottom navigation
      ShellRoute(
        builder: (context, state, child) => MainLayout(child: child),
        routes: [
          // Home/Period tracking
          GoRoute(
            path: RouteNames.home,
            name: 'home',
            builder: (context, state) => const PeriodHomePage(),
          ),

          // Calendar
          GoRoute(
            path: RouteNames.calendar,
            name: 'calendar',
            builder: (context, state) => const CalendarPage(),
          ),

          // Symptoms
          GoRoute(
            path: RouteNames.symptoms,
            name: 'symptoms',
            builder: (context, state) => const SymptomTrackerPage(),
          ),

          // Analytics
          GoRoute(
            path: RouteNames.analytics,
            name: 'analytics',
            builder: (context, state) => const AnalyticsPage(),
          ),

          // Settings
          GoRoute(
            path: RouteNames.settings,
            name: 'settings',
            builder: (context, state) => const SettingsPage(),
          ),
        ],
      ),

      // Detail pages (outside shell)
      GoRoute(
        path: '${RouteNames.logPeriod}/:date',
        name: 'logPeriod',
        builder: (context, state) {
          final dateStr = state.pathParameters['date']!;
          return LogPeriodPage(date: DateTime.parse(dateStr));
        },
      ),

      GoRoute(
        path: '${RouteNames.dayDetails}/:date',
        name: 'dayDetails',
        builder: (context, state) {
          final dateStr = state.pathParameters['date']!;
          return DayDetailsPage(date: DateTime.parse(dateStr));
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Page not found: ${state.error}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(RouteNames.home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
}
