import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../bloc/symptom_bloc.dart';
import '../../../../core/theme/app_theme.dart';

class SymptomTrackerPage extends StatefulWidget {
  const SymptomTrackerPage({super.key});

  @override
  State<SymptomTrackerPage> createState() => _SymptomTrackerPageState();
}

class _SymptomTrackerPageState extends State<SymptomTrackerPage> {
  final Map<String, int> _selectedSymptoms = {};
  DateTime _selectedDate = DateTime.now();

  final List<SymptomCategory> _symptomCategories = [
    const SymptomCategory(
      name: 'Physical',
      color: AppTheme.primaryPink,
      icon: Icons.favorite,
      symptoms: [
        Symptom('cramps', 'Cramps', Icons.waves),
        Symptom('bloating', 'Bloating', Icons.circle_outlined),
        Symptom('headache', 'Headache', Icons.psychology),
        Symptom('backache', 'Back Pain', Icons.back_hand),
        Symptom('breast_pain', 'Breast Pain', Icons.favorite_border),
        Symptom('nausea', 'Nausea', Icons.sick),
        Symptom('fatigue', 'Fatigue', Icons.battery_0_bar),
        Symptom('acne', 'Acne', Icons.face),
      ],
    ),
    const SymptomCategory(
      name: 'Emotional',
      color: AppTheme.secondaryPurple,
      icon: Icons.mood,
      symptoms: [
        Symptom('mood_swings', 'Mood Swings', Icons.mood_bad),
        Symptom('irritability', 'Irritability', Icons.sentiment_dissatisfied),
        Symptom('anxiety', 'Anxiety', Icons.psychology_alt),
        Symptom('depression', 'Sadness', Icons.sentiment_very_dissatisfied),
        Symptom('crying', 'Crying Spells', Icons.water_drop),
        Symptom('anger', 'Anger', Icons.local_fire_department),
      ],
    ),
    const SymptomCategory(
      name: 'Digestive',
      color: AppTheme.fertilityGreen,
      icon: Icons.restaurant,
      symptoms: [
        Symptom('constipation', 'Constipation', Icons.block),
        Symptom('diarrhea', 'Diarrhea', Icons.water),
        Symptom('food_cravings', 'Food Cravings', Icons.fastfood),
        Symptom('appetite_changes', 'Appetite Changes', Icons.restaurant_menu),
      ],
    ),
    const SymptomCategory(
      name: 'Sleep',
      color: AppTheme.ovulationBlue,
      icon: Icons.bedtime,
      symptoms: [
        Symptom('insomnia', 'Insomnia', Icons.bedtime_off),
        Symptom('vivid_dreams', 'Vivid Dreams', Icons.psychology),
        Symptom('night_sweats', 'Night Sweats', Icons.thermostat),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    context.read<SymptomBloc>().add(SymptomLoadRequested(date: _selectedDate));
  }

  void _handleSaveSymptoms() {
    if (_selectedSymptoms.isNotEmpty) {
      for (final entry in _selectedSymptoms.entries) {
        context.read<SymptomBloc>().add(
          SymptomLogRequested(
            date: _selectedDate,
            symptomName: entry.key,
            intensity: entry.value,
          ),
        );
      }
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
          'Track Symptoms',
          style: theme.textTheme.h3?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.foreground,
          ),
        ),
        actions: [
          ShadButton.ghost(
            onPressed: () {
              // TODO: Navigate to symptom insights
            },
            child: const Icon(Icons.insights),
          ),
        ],
      ),
      body: BlocListener<SymptomBloc, SymptomState>(
        listener: (context, state) {
          if (state is SymptomLogged) {
            ShadToaster.of(context).show(
              const ShadToast(
                title: Text('Symptoms Logged'),
                description: Text('Your symptoms have been saved'),
              ),
            );
          } else if (state is SymptomError) {
            ShadToaster.of(context).show(
              ShadToast.destructive(
                title: const Text('Error'),
                description: Text(state.message),
              ),
            );
          }
        },
        child: Column(
          children: [
            // Date selector
            Container(
              margin: const EdgeInsets.all(16),
              child: ShadCard(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        color: AppTheme.primaryPink,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Today, ${_formatDate(_selectedDate)}',
                        style: theme.textTheme.p?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      ShadButton.ghost(
                        onPressed: _selectDate,
                        child: const Icon(Icons.edit_calendar),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Symptom categories
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _symptomCategories.length,
                itemBuilder: (context, index) {
                  final category = _symptomCategories[index];
                  return _buildSymptomCategory(theme, category);
                },
              ),
            ),

            // Save button
            Container(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: BlocBuilder<SymptomBloc, SymptomState>(
                  builder: (context, state) {
                    final isLoading = state is SymptomLoading;

                    return ShadButton(
                      onPressed: _selectedSymptoms.isEmpty || isLoading
                          ? null
                          : _handleSaveSymptoms,
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
                          : Text(
                              'Save Symptoms (${_selectedSymptoms.length})',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSymptomCategory(ShadThemeData theme, SymptomCategory category) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: ShadCard(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: category.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(category.icon, color: category.color, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    category.name,
                    style: theme.textTheme.h4?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: category.color,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: category.symptoms.map((symptom) {
                  final isSelected = _selectedSymptoms.containsKey(symptom.id);
                  final intensity = _selectedSymptoms[symptom.id] ?? 0;

                  return GestureDetector(
                    onTap: () => _showIntensityPicker(symptom, category.color),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? category.color.withOpacity(0.1)
                            : theme.colorScheme.muted.withOpacity(0.3),
                        border: Border.all(
                          color: isSelected
                              ? category.color
                              : theme.colorScheme.border,
                          width: isSelected ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            symptom.icon,
                            size: 16,
                            color: isSelected
                                ? category.color
                                : theme.colorScheme.mutedForeground,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            symptom.name,
                            style: theme.textTheme.small?.copyWith(
                              color: isSelected
                                  ? category.color
                                  : theme.colorScheme.foreground,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                            ),
                          ),
                          if (isSelected) ...[
                            const SizedBox(width: 4),
                            Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: category.color,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '$intensity',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showIntensityPicker(Symptom symptom, Color color) {
    showDialog(
      context: context,
      builder: (context) => ShadDialog(
        title: Text('${symptom.name} Intensity'),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'How intense is your ${symptom.name.toLowerCase()}?',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [1, 2, 3, 4, 5].map((intensity) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedSymptoms[symptom.id] = intensity;
                    });
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: color.withOpacity(intensity * 0.2),
                      border: Border.all(color: color),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '$intensity',
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Mild', style: Theme.of(context).textTheme.bodySmall),
                Text('Severe', style: Theme.of(context).textTheme.bodySmall),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: ShadButton.ghost(
                    onPressed: () {
                      setState(() {
                        _selectedSymptoms.remove(symptom.id);
                      });
                      Navigator.of(context).pop();
                    },
                    child: const Text('Remove'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ShadButton.ghost(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
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

    if (selectedDate != null && selectedDate != _selectedDate) {
      setState(() {
        _selectedDate = selectedDate;
        _selectedSymptoms.clear();
      });
      context.read<SymptomBloc>().add(
        SymptomLoadRequested(date: _selectedDate),
      );
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return 'Today';
    } else if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day - 1) {
      return 'Yesterday';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}

class SymptomCategory {
  final String name;
  final Color color;
  final IconData icon;
  final List<Symptom> symptoms;

  const SymptomCategory({
    required this.name,
    required this.color,
    required this.icon,
    required this.symptoms,
  });
}

class Symptom {
  final String id;
  final String name;
  final IconData icon;

  const Symptom(this.id, this.name, this.icon);
}
