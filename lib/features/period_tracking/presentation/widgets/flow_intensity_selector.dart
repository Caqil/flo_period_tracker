import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../../core/theme/app_theme.dart';

class FlowIntensitySelector extends StatefulWidget {
  final String selectedIntensity;
  final Function(String) onIntensityChanged;
  final bool enabled;

  const FlowIntensitySelector({
    super.key,
    required this.selectedIntensity,
    required this.onIntensityChanged,
    this.enabled = true,
  });

  @override
  State<FlowIntensitySelector> createState() => _FlowIntensitySelectorState();
}

class _FlowIntensitySelectorState extends State<FlowIntensitySelector>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  final List<FlowIntensityOption> _options = [
    FlowIntensityOption(
      value: 'spotting',
      label: 'Spotting',
      description: 'Very light, brownish discharge',
      color: const Color(0xFFFFE0B2),
      icon: Icons.water_drop_outlined,
      intensity: 1,
    ),
    FlowIntensityOption(
      value: 'light',
      label: 'Light',
      description: 'Light flow, change pad every 3-4 hours',
      color: const Color(0xFFFFCDD2),
      icon: Icons.water_drop,
      intensity: 2,
    ),
    FlowIntensityOption(
      value: 'medium',
      label: 'Medium',
      description: 'Normal flow, change every 2-3 hours',
      color: AppTheme.primaryPink.withOpacity(0.7),
      icon: Icons.water_drop,
      intensity: 3,
    ),
    FlowIntensityOption(
      value: 'heavy',
      label: 'Heavy',
      description: 'Heavy flow, change every 1-2 hours',
      color: AppTheme.primaryPink,
      icon: Icons.water_drop,
      intensity: 4,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Flow Intensity',
          style: theme.textTheme.h4?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.foreground,
          ),
        ),
        const SizedBox(height: 16),

        // Visual intensity scale
        _buildIntensityScale(theme),

        const SizedBox(height: 20),

        // Intensity options
        Column(
          children: _options.map((option) {
            final isSelected = widget.selectedIntensity == option.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildIntensityOption(theme, option, isSelected),
            );
          }).toList(),
        ),

        const SizedBox(height: 16),

        // Selected option description
        _buildSelectedDescription(theme),
      ],
    );
  }

  Widget _buildIntensityScale(ShadThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.muted.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            'Flow Intensity Scale',
            style: theme.textTheme.small?.copyWith(
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.mutedForeground,
            ),
          ),
          const SizedBox(height: 12),

          Row(
            children: _options.map((option) {
              final isSelected = widget.selectedIntensity == option.value;
              final selectedIndex = _options.indexWhere(
                (o) => o.value == widget.selectedIntensity,
              );
              final currentIndex = _options.indexOf(option);
              final isActive = currentIndex <= selectedIndex;

              return Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  child: Column(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: 8 + (option.intensity * 4),
                        decoration: BoxDecoration(
                          color: isActive
                              ? option.color
                              : theme.colorScheme.border,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Icon(
                        option.icon,
                        size: 12 + option.intensity * 2,
                        color: isSelected
                            ? option.color
                            : theme.colorScheme.mutedForeground,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Light',
                style: theme.textTheme.small?.copyWith(
                  color: theme.colorScheme.mutedForeground,
                ),
              ),
              Text(
                'Heavy',
                style: theme.textTheme.small?.copyWith(
                  color: theme.colorScheme.mutedForeground,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIntensityOption(
    ShadThemeData theme,
    FlowIntensityOption option,
    bool isSelected,
  ) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: isSelected ? _scaleAnimation.value : 1.0,
          child: GestureDetector(
            onTap: widget.enabled
                ? () {
                    _animationController.forward().then((_) {
                      _animationController.reverse();
                    });
                    widget.onIntensityChanged(option.value);
                  }
                : null,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected
                    ? option.color.withOpacity(0.1)
                    : Colors.transparent,
                border: Border.all(
                  color: isSelected ? option.color : theme.colorScheme.border,
                  width: isSelected ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  // Intensity indicator
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: option.color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          option.icon,
                          color: option.color,
                          size: 16 + option.intensity * 2,
                        ),
                        const SizedBox(height: 2),
                        // Intensity dots
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(4, (index) {
                            return Container(
                              width: 3,
                              height: 3,
                              margin: const EdgeInsets.symmetric(horizontal: 1),
                              decoration: BoxDecoration(
                                color: index < option.intensity
                                    ? option.color
                                    : option.color.withOpacity(0.3),
                                shape: BoxShape.circle,
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Option details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          option.label,
                          style: theme.textTheme.p?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: isSelected
                                ? option.color
                                : theme.colorScheme.foreground,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          option.description,
                          style: theme.textTheme.small?.copyWith(
                            color: theme.colorScheme.mutedForeground,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Selection indicator
                  if (isSelected)
                    Icon(Icons.check_circle, color: option.color, size: 20)
                  else
                    Icon(
                      Icons.circle_outlined,
                      color: theme.colorScheme.border,
                      size: 20,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSelectedDescription(ShadThemeData theme) {
    final selectedOption = _options.firstWhere(
      (option) => option.value == widget.selectedIntensity,
      orElse: () => _options[1], // Default to light
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: selectedOption.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: selectedOption.color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: selectedOption.color, size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selected: ${selectedOption.label}',
                  style: theme.textTheme.small?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: selectedOption.color,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  selectedOption.description,
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
}

class FlowIntensityOption {
  final String value;
  final String label;
  final String description;
  final Color color;
  final IconData icon;
  final int intensity;

  const FlowIntensityOption({
    required this.value,
    required this.label,
    required this.description,
    required this.color,
    required this.icon,
    required this.intensity,
  });
}
