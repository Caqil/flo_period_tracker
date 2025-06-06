import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'route_names.dart';

class RouteGuards {
  static String? profileGuard(BuildContext context, GoRouterState state) {
    final profileBloc = context.read<UserProfileBloc>();
    final profileState = profileBloc.state;
    final location = state.matchedLocation;

    // Routes that don't require profile setup
    const publicRoutes = [
      RouteNames.splash,
      RouteNames.welcome,
      RouteNames.profileSetup,
    ];

    // If currently on a public route, no redirect needed
    if (publicRoutes.contains(location)) {
      return null;
    }

    // Check profile state
    if (profileState is UserProfileNotFound) {
      // No profile exists, redirect to welcome
      return RouteNames.welcome;
    }

    if (profileState is UserProfileLoaded) {
      // Profile exists but setup not completed
      if (!profileState.profile.isSetupCompleted &&
          location != RouteNames.profileSetup) {
        return RouteNames.profileSetup;
      }

      // Profile is complete, no redirect needed
      return null;
    }

    // Profile state is loading or initial, stay on current route
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

  static bool requiresSetup(String route) {
    const setupRequiredRoutes = [
      RouteNames.home,
      RouteNames.calendar,
      RouteNames.symptoms,
      RouteNames.analytics,
    ];

    return setupRequiredRoutes.contains(route);
  }
}
