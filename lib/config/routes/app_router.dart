import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/authentication/presentation/bloc/auth_bloc.dart';
import '../../features/onboarding/presentation/pages/splash_page.dart';
import '../../features/authentication/presentation/pages/login_page.dart';
import '../../features/authentication/presentation/pages/register_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/period_tracking/presentation/pages/period_home_page.dart';
import '../../shared/presentation/layouts/main_layout.dart';
import 'route_names.dart';
import 'route_guards.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.splash,
    redirect: RouteGuards.authGuard,
    routes: [
      // Splash route
      GoRoute(
        path: RouteNames.splash,
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),

      // Authentication routes
      GoRoute(
        path: RouteNames.login,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RouteNames.register,
        name: 'register',
        builder: (context, state) => const RegisterPage(),
      ),

      // Onboarding routes
      GoRoute(
        path: RouteNames.onboarding,
        name: 'onboarding',
        builder: (context, state) => const OnboardingPage(),
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
