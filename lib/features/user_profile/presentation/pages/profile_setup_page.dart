import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../config/routes/route_names.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/validators.dart';
import '../bloc/user_profile_bloc.dart';

class ProfileSetupPage extends StatefulWidget {
  const ProfileSetupPage({super.key});

  @override
  State<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cycleLengthController = TextEditingController(text: '28');
  final _periodLengthController = TextEditingController(text: '5');

  DateTime? _dateOfBirth;
  DateTime? _lastPeriodDate;

  @override
  void dispose() {
    _nameController.dispose();
    _cycleLengthController.dispose();
    _periodLengthController.dispose();
    super.dispose();
  }

  void _handleSetup() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<UserProfileBloc>().add(
        UserProfileSetupRequested(
          name: _nameController.text.trim().isEmpty
              ? null
              : _nameController.text.trim(),
          dateOfBirth: _dateOfBirth,
          averageCycleLength: int.parse(_cycleLengthController.text),
          averagePeriodLength: int.parse(_periodLengthController.text),
          lastPeriodDate: _lastPeriodDate,
        ),
      );
    }
  }

  Future<void> _selectDateOfBirth() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 25)),
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 60)),
      lastDate: DateTime.now().subtract(const Duration(days: 365 * 10)),
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
        _dateOfBirth = selectedDate;
      });
    }
  }

  Future<void> _selectLastPeriod() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 7)),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
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
        _lastPeriodDate = selectedDate;
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
          'Setup Your Profile',
          style: theme.textTheme.h3?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.foreground,
          ),
        ),
      ),
      body: BlocListener<UserProfileBloc, UserProfileState>(
        listener: (context, state) {
          if (state is UserProfileLoaded) {
            context.go(RouteNames.home);
          } else if (state is UserProfileError) {
            ShadToaster.of(context).show(
              ShadToast.destructive(
                title: const Text('Setup Failed'),
                description: Text(state.message),
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Name field (optional)
                ShadInputFormField(
                  controller: _nameController,
                  placeholder: const Text('Your name (optional)'),
                  decoration: ShadDecoration(
                    border: ShadBorder.all(
                      color: theme.colorScheme.border,
                      width: 1,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Date of birth (optional)
                GestureDetector(
                  onTap: _selectDateOfBirth,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: theme.colorScheme.border),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.cake,
                          color: theme.colorScheme.mutedForeground,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          _dateOfBirth != null
                              ? 'Born: ${DateFormat('MMM d, yyyy').format(_dateOfBirth!)}'
                              : 'Date of birth (optional)',
                          style: theme.textTheme.p?.copyWith(
                            color: _dateOfBirth != null
                                ? theme.colorScheme.foreground
                                : theme.colorScheme.mutedForeground,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Cycle information
                Text(
                  'Cycle Information',
                  style: theme.textTheme.h4?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: ShadInputFormField(
                        controller: _cycleLengthController,
                        placeholder: const Text('Cycle length'),
                        keyboardType: TextInputType.number,
                        validator: Validators.cycleLength,
                        decoration: ShadDecoration(
                          border: ShadBorder.all(
                            color: theme.colorScheme.border,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ShadInputFormField(
                        controller: _periodLengthController,
                        placeholder: const Text('Period length'),
                        keyboardType: TextInputType.number,
                        validator: Validators.periodLength,
                        decoration: ShadDecoration(
                          border: ShadBorder.all(
                            color: theme.colorScheme.border,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Last period date
                GestureDetector(
                  onTap: _selectLastPeriod,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: theme.colorScheme.border),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.water_drop,
                          color: AppTheme.primaryPink,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          _lastPeriodDate != null
                              ? 'Last period: ${DateFormat('MMM d, yyyy').format(_lastPeriodDate!)}'
                              : 'When was your last period? (optional)',
                          style: theme.textTheme.p?.copyWith(
                            color: _lastPeriodDate != null
                                ? theme.colorScheme.foreground
                                : theme.colorScheme.mutedForeground,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Setup button
                BlocBuilder<UserProfileBloc, UserProfileState>(
                  builder: (context, state) {
                    return ShadButton(
                      onPressed: state is UserProfileLoading
                          ? null
                          : _handleSetup,
                      backgroundColor: AppTheme.primaryPink,
                      child: state is UserProfileLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'Complete Setup',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    );
                  },
                ),

                const SizedBox(height: 16),

                // Skip option
                ShadButton.ghost(
                  onPressed: () {
                    context.read<UserProfileBloc>().add(
                      const UserProfileSetupRequested(
                        averageCycleLength: 28,
                        averagePeriodLength: 5,
                      ),
                    );
                  },
                  child: const Text('Skip for now'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
