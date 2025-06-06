import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:go_router/go_router.dart';

import '../../../config/routes/route_names.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.background,
          border: Border(
            top: BorderSide(color: theme.colorScheme.border, width: 1),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon: Icons.home_rounded,
                  label: 'Home',
                  isActive: _isCurrentRoute(context, RouteNames.home),
                  onTap: () => context.go(RouteNames.home),
                ),
                _NavItem(
                  icon: Icons.calendar_month_rounded,
                  label: 'Calendar',
                  isActive: _isCurrentRoute(context, RouteNames.calendar),
                  onTap: () => context.go(RouteNames.calendar),
                ),
                _NavItem(
                  icon: Icons.favorite_rounded,
                  label: 'Symptoms',
                  isActive: _isCurrentRoute(context, RouteNames.symptoms),
                  onTap: () => context.go(RouteNames.symptoms),
                ),
                _NavItem(
                  icon: Icons.analytics_rounded,
                  label: 'Insights',
                  isActive: _isCurrentRoute(context, RouteNames.analytics),
                  onTap: () => context.go(RouteNames.analytics),
                ),
                _NavItem(
                  icon: Icons.settings_rounded,
                  label: 'Settings',
                  isActive: _isCurrentRoute(context, RouteNames.settings),
                  onTap: () => context.go(RouteNames.settings),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _isCurrentRoute(BuildContext context, String route) {
    final location = GoRouterState.of(context).fullPath ?? '';
    return location == route;
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? theme.colorScheme.primary.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: isActive
                  ? theme.colorScheme.primary
                  : theme.colorScheme.mutedForeground,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: theme.textTheme.small?.copyWith(
                color: isActive
                    ? theme.colorScheme.primary
                    : theme.colorScheme.mutedForeground,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
