import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/authentication/presentation/bloc/auth_bloc.dart';
import 'route_names.dart';

class RouteGuards {
  static String? authGuard(BuildContext context, GoRouterState state) {
    final authBloc = context.read<AuthBloc>();
    final authState = authBloc.state;
    final location = state.matchedLocation;

    // Routes that don't require authentication
    const publicRoutes = [
      RouteNames.splash,
      RouteNames.login,
      RouteNames.register,
    ];

    // If currently on a public route, no redirect needed
    if (publicRoutes.contains(location)) {
      return null;
    }

    // Check authentication state
    if (authState is AuthUnauthenticated || authState is AuthError) {
      // User is not authenticated, redirect to login
      return RouteNames.login;
    }

    if (authState is AuthAuthenticated) {
      // User is authenticated but hasn't completed onboarding
      if (!authState.user.isOnboardingCompleted &&
          location != RouteNames.onboarding) {
        return RouteNames.onboarding;
      }

      // User is authenticated and onboarded, no redirect needed
      return null;
    }

    // Auth state is loading or initial, stay on current route
    return null;
  }

  static bool isProtectedRoute(String route) {
    const protectedRoutes = [
      RouteNames.home,
      RouteNames.calendar,
      RouteNames.symptoms,
      RouteNames.analytics,
      RouteNames.settings,
      RouteNames.profile,
    ];

    return protectedRoutes.contains(route);
  }

  static bool requiresOnboarding(String route) {
    const onboardingRequiredRoutes = [
      RouteNames.home,
      RouteNames.calendar,
      RouteNames.symptoms,
      RouteNames.analytics,
    ];

    return onboardingRequiredRoutes.contains(route);
  }
}
