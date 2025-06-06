import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../bloc/period_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/validators.dart';

class LogPeriodPage extends StatefulWidget {
  final DateTime date;

  const LogPeriodPage({super.key, required this.date});

  @override
  State<LogPeriodPage> createState() => _LogPeriodPageState();
}

class _LogPeriodPageState extends State<LogPeriodPage> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;
  String _flowIntensity = 'medium';
  bool _isOngoing = true;

  final List<FlowIntensityOption> _flowOptions = [
    FlowIntensityOption(
      value: 'spotting',
      label: 'Spotting',
      description: 'Very light, brownish discharge',
      color: const Color(0xFFFFE0B2),
      icon: Icons.water_drop_outlined,
    ),
    FlowIntensityOption(
      value: 'light',
      label: 'Light',
      description: 'Light flow, change pad/tampon every 3-4 hours',
      color: const Color(0xFFFFCDD2),
      icon: Icons.water_drop,
    ),
    FlowIntensityOption(
      value: 'medium',
      label: 'Medium',
      description: 'Normal flow, change every 2-3 hours',
      color: AppTheme.primaryPink.withOpacity(0.7),
      icon: Icons.water_drop,
    ),
    FlowIntensityOption(
      value: 'heavy',
      label: 'Heavy',
      description: 'Heavy flow, change every 1-2 hours',
      color: AppTheme.primaryPink,
      icon: Icons.water_drop,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _startDate = widget.date;
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<PeriodBloc>().add(
        PeriodLogRequested(
          startDate: _startDate!,
          endDate: _isOngoing ? null : _endDate,
          flowIntensity: _flowIntensity,
          notes: _notesController.text.trim().isEmpty
              ? null
              : _notesController.text.trim(),
        ),
      );
    }
  }

  Future<void> _selectDate({required bool isStartDate}) async {
    final initialDate = isStartDate ? _startDate : _endDate;
    final firstDate = DateTime.now().subtract(const Duration(days: 365));
    final lastDate = DateTime.now().add(const Duration(days: 30));

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(
              context,
            ).colorScheme.copyWith(primary: AppTheme.primaryPink),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      setState(() {
        if (isStartDate) {
          _startDate = selectedDate;
          // If end date is before start date, clear it
          if (_endDate != null && _endDate!.isBefore(_startDate!)) {
            _endDate = null;
          }
        } else {
          _endDate = selectedDate;
        }
      });
    }
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
          'Log Period',
          style: theme.textTheme.h3?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.foreground,
          ),
        ),
        leading: ShadButton.ghost(
          onPressed: () => context.pop(),
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: BlocListener<PeriodBloc, PeriodState>(
        listener: (context, state) {
          if (state is PeriodLoaded && !state.isLoading) {
            ShadToaster.of(context).show(
              ShadToast(
                title: const Text('Period Logged'),
                description: const Text(
                  'Your period has been logged successfully',
                ),
              ),
            );
            context.pop();
          } else if (state is PeriodLoaded && state.error != null) {
            ShadToaster.of(context).show(
              ShadToast.destructive(
                title: const Text('Error'),
                description: Text(state.error!),
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Date selection
                _buildDateSection(theme),

                const SizedBox(height: 24),

                // Flow intensity selection
                _buildFlowIntensitySection(theme),

                const SizedBox(height: 24),

                // Notes section
                _buildNotesSection(theme),

                const SizedBox(height: 32),

                // Save button
                BlocBuilder<PeriodBloc, PeriodState>(
                  builder: (context, state) {
                    final isLoading = state is PeriodLoaded && state.isLoading;

                    return ShadButton(
                      onPressed: isLoading ? null : _handleSave,
                      backgroundColor: AppTheme.primaryPink,
                      child: isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'Save Period',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateSection(ShadThemeData theme) {
    return ShadCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Period Dates',
              style: theme.textTheme.h4?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            // Start date
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Start Date',
                        style: theme.textTheme.p?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () => _selectDate(isStartDate: true),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: theme.colorScheme.border),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 16,
                                color: theme.colorScheme.mutedForeground,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _startDate != null
                                    ? DateFormat(
                                        'MMM d, yyyy',
                                      ).format(_startDate!)
                                    : 'Select date',
                                style: theme.textTheme.p,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Ongoing toggle
            Row(
              children: [
                ShadCheckbox(
                  value: _isOngoing,
                  onChanged: (value) {
                    setState(() {
                      _isOngoing = value ?? true;
                      if (_isOngoing) {
                        _endDate = null;
                      }
                    });
                  },
                ),
                const SizedBox(width: 12),
                Text(
                  'Period is ongoing',
                  style: theme.textTheme.p?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            // End date (if not ongoing)
            if (!_isOngoing) ...[
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'End Date',
                    style: theme.textTheme.p?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => _selectDate(isStartDate: false),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: theme.colorScheme.border),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 16,
                            color: theme.colorScheme.mutedForeground,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _endDate != null
                                ? DateFormat('MMM d, yyyy').format(_endDate!)
                                : 'Select end date',
                            style: theme.textTheme.p,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFlowIntensitySection(ShadThemeData theme) {
    return ShadCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Flow Intensity',
              style: theme.textTheme.h4?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            ...(_flowOptions.map((option) {
              final isSelected = _flowIntensity == option.value;

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _flowIntensity = option.value;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? option.color.withOpacity(0.1)
                          : Colors.transparent,
                      border: Border.all(
                        color: isSelected
                            ? option.color
                            : theme.colorScheme.border,
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: option.color.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            option.icon,
                            color: option.color,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
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
                              const SizedBox(height: 2),
                              Text(
                                option.description,
                                style: theme.textTheme.small?.copyWith(
                                  color: theme.colorScheme.mutedForeground,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isSelected)
                          Icon(
                            Icons.check_circle,
                            color: option.color,
                            size: 20,
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList()),
          ],
        ),
      ),
    );
  }

  Widget _buildNotesSection(ShadThemeData theme) {
    return ShadCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notes (Optional)',
              style: theme.textTheme.h4?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            ShadInputFormField(
              controller: _notesController,
              placeholder: const Text('Add any notes about your period...'),
              maxLines: 4,
              decoration: ShadDecoration(
                border: ShadBorder.all(
                  color: theme.colorScheme.border,
                  width: 1,
                ),
              ),
            ),
          ],
        ),
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

  const FlowIntensityOption({
    required this.value,
    required this.label,
    required this.description,
    required this.color,
    required this.icon,
  });
}
