import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'dart:math' as math;

import '../../../../core/theme/app_theme.dart';

class CycleRingChart extends StatefulWidget {
  final int currentDay;
  final int cycleLength;
  final bool isPeriodDay;
  final bool isFertileDay;
  final bool isOvulationDay;

  const CycleRingChart({
    super.key,
    required this.currentDay,
    required this.cycleLength,
    this.isPeriodDay = false,
    this.isFertileDay = false,
    this.isOvulationDay = false,
  });

  @override
  State<CycleRingChart> createState() => _CycleRingChartState();
}

class _CycleRingChartState extends State<CycleRingChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _progressAnimation =
        Tween<double>(
          begin: 0.0,
          end: widget.currentDay / widget.cycleLength,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );

    _animationController.forward();
  }

  @override
  void didUpdateWidget(CycleRingChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentDay != widget.currentDay ||
        oldWidget.cycleLength != widget.cycleLength) {
      _progressAnimation =
          Tween<double>(
            begin: _progressAnimation.value,
            end: widget.currentDay / widget.cycleLength,
          ).animate(
            CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeInOut,
            ),
          );
      _animationController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color get _currentPhaseColor {
    if (widget.isPeriodDay) return AppTheme.primaryPink;
    if (widget.isOvulationDay) return AppTheme.ovulationBlue;
    if (widget.isFertileDay) return AppTheme.fertilityGreen;
    return AppTheme.secondaryPurple.withOpacity(0.3);
  }

  String get _currentPhaseText {
    if (widget.isPeriodDay) return 'Period';
    if (widget.isOvulationDay) return 'Ovulation';
    if (widget.isFertileDay) return 'Fertile Window';
    return 'Follicular Phase';
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return ShadCard(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              'Cycle Day ${widget.currentDay}',
              style: theme.textTheme.h4.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.foreground,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _currentPhaseText,
              style: theme.textTheme.p.copyWith(
                color: _currentPhaseColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 32),

            // Cycle ring chart
            SizedBox(
              width: 200,
              height: 200,
              child: Stack(
                children: [
                  // Background circle
                  CustomPaint(
                    size: const Size(200, 200),
                    painter: _BackgroundCirclePainter(
                      backgroundColor: theme.colorScheme.muted.withOpacity(0.3),
                    ),
                  ),

                  // Animated progress circle
                  AnimatedBuilder(
                    animation: _progressAnimation,
                    builder: (context, child) {
                      return CustomPaint(
                        size: const Size(200, 200),
                        painter: _ProgressCirclePainter(
                          progress: _progressAnimation.value,
                          color: _currentPhaseColor,
                          strokeWidth: 12,
                        ),
                      );
                    },
                  ),

                  // Center content
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${widget.currentDay}',
                          style: theme.textTheme.h1.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.foreground,
                          ),
                        ),
                        Text(
                          'of ${widget.cycleLength}',
                          style: theme.textTheme.p.copyWith(
                            color: theme.colorScheme.mutedForeground,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Phase indicators
                  _buildPhaseIndicators(theme),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Phase legend
            _buildPhaseLegend(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildPhaseIndicators(ShadThemeData theme) {
    final radius = 85.0;
    final center = const Offset(100, 100);

    return Stack(
      children: [
        // Period indicator (days 1-5)
        _buildPhaseIndicator(
          center: center,
          radius: radius,
          angle: _dayToAngle(3),
          color: AppTheme.primaryPink,
          icon: Icons.water_drop,
          label: 'P',
        ),

        // Ovulation indicator (day 14)
        _buildPhaseIndicator(
          center: center,
          radius: radius,
          angle: _dayToAngle(14),
          color: AppTheme.ovulationBlue,
          icon: Icons.circle,
          label: 'O',
        ),

        // Fertile window start (day 10)
        _buildPhaseIndicator(
          center: center,
          radius: radius,
          angle: _dayToAngle(10),
          color: AppTheme.fertilityGreen,
          icon: Icons.eco,
          label: 'F',
        ),
      ],
    );
  }

  Widget _buildPhaseIndicator({
    required Offset center,
    required double radius,
    required double angle,
    required Color color,
    required IconData icon,
    required String label,
  }) {
    final x = center.dx + radius * math.cos(angle);
    final y = center.dy + radius * math.sin(angle);

    return Positioned(
      left: x - 12,
      top: y - 12,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 12, color: Colors.white),
      ),
    );
  }

  Widget _buildPhaseLegend(ShadThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildLegendItem(
          theme,
          'Period',
          AppTheme.primaryPink,
          Icons.water_drop,
        ),
        _buildLegendItem(theme, 'Fertile', AppTheme.fertilityGreen, Icons.eco),
        _buildLegendItem(
          theme,
          'Ovulation',
          AppTheme.ovulationBlue,
          Icons.circle,
        ),
      ],
    );
  }

  Widget _buildLegendItem(
    ShadThemeData theme,
    String label,
    Color color,
    IconData icon,
  ) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 16),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.textTheme.small?.copyWith(
            color: theme.colorScheme.mutedForeground,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  double _dayToAngle(int day) {
    // Convert day to angle (0 = top, clockwise)
    return (day / widget.cycleLength) * 2 * math.pi - math.pi / 2;
  }
}

class _BackgroundCirclePainter extends CustomPainter {
  final Color backgroundColor;

  _BackgroundCirclePainter({required this.backgroundColor});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 6;

    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ProgressCirclePainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  _ProgressCirclePainter({
    required this.progress,
    required this.color,
    this.strokeWidth = 8,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - strokeWidth / 2;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    const startAngle = -math.pi / 2; // Start from top
    final sweepAngle = 2 * math.pi * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is _ProgressCirclePainter &&
        (oldDelegate.progress != progress || oldDelegate.color != color);
  }
}
