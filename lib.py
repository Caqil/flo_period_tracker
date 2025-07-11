import os

def create_directory_structure(base_path):
    # Define the directory structure for lib folder only
    directories = [
        'lib',
        'lib/core',
        'lib/core/theme',
        'lib/core/constants',
        'lib/core/database',
        'lib/core/database/daos',
        'lib/core/database/entities',
        'lib/core/services',
        'lib/core/utils',
        'lib/core/error',
        'lib/core/network',
        'lib/features',
        'lib/features/authentication',
        'lib/features/authentication/data',
        'lib/features/authentication/data/datasources',
        'lib/features/authentication/data/models',
        'lib/features/authentication/data/repositories',
        'lib/features/authentication/domain',
        'lib/features/authentication/domain/entities',
        'lib/features/authentication/domain/repositories',
        'lib/features/authentication/domain/usecases',
        'lib/features/authentication/presentation',
        'lib/features/authentication/presentation/bloc',
        'lib/features/authentication/presentation/pages',
        'lib/features/authentication/presentation/widgets',
        'lib/features/onboarding',
        'lib/features/onboarding/presentation',
        'lib/features/onboarding/presentation/bloc',
        'lib/features/onboarding/presentation/pages',
        'lib/features/onboarding/presentation/widgets',
        'lib/features/onboarding/data',
        'lib/features/onboarding/data/models',
        'lib/features/period_tracking',
        'lib/features/period_tracking/data',
        'lib/features/period_tracking/data/datasources',
        'lib/features/period_tracking/data/models',
        'lib/features/period_tracking/data/repositories',
        'lib/features/period_tracking/domain',
        'lib/features/period_tracking/domain/entities',
        'lib/features/period_tracking/domain/repositories',
        'lib/features/period_tracking/domain/usecases',
        'lib/features/period_tracking/presentation',
        'lib/features/period_tracking/presentation/bloc',
        'lib/features/period_tracking/presentation/pages',
        'lib/features/period_tracking/presentation/widgets',
        'lib/features/symptom_tracking',
        'lib/features/symptom_tracking/data',
        'lib/features/symptom_tracking/data/datasources',
        'lib/features/symptom_tracking/data/models',
        'lib/features/symptom_tracking/data/repositories',
        'lib/features/symptom_tracking/domain',
        'lib/features/symptom_tracking/domain/entities',
        'lib/features/symptom_tracking/domain/repositories',
        'lib/features/symptom_tracking/domain/usecases',
        'lib/features/symptom_tracking/presentation',
        'lib/features/symptom_tracking/presentation/bloc',
        'lib/features/symptom_tracking/presentation/pages',
        'lib/features/symptom_tracking/presentation/widgets',
        'lib/features/mood_tracking',
        'lib/features/mood_tracking/data',
        'lib/features/mood_tracking/data/datasources',
        'lib/features/mood_tracking/data/models',
        'lib/features/mood_tracking/data/repositories',
        'lib/features/mood_tracking/domain',
        'lib/features/mood_tracking/domain/entities',
        'lib/features/mood_tracking/domain/repositories',
        'lib/features/mood_tracking/domain/usecases',
        'lib/features/mood_tracking/presentation',
        'lib/features/mood_tracking/presentation/bloc',
        'lib/features/mood_tracking/presentation/pages',
        'lib/features/mood_tracking/presentation/widgets',
        'lib/features/analytics',
        'lib/features/analytics/data',
        'lib/features/analytics/data/datasources',
        'lib/features/analytics/data/models',
        'lib/features/analytics/data/repositories',
        'lib/features/analytics/domain',
        'lib/features/analytics/domain/entities',
        'lib/features/analytics/domain/repositories',
        'lib/features/analytics/domain/usecases',
        'lib/features/analytics/presentation',
        'lib/features/analytics/presentation/bloc',
        'lib/features/analytics/presentation/pages',
        'lib/features/analytics/presentation/widgets',
        'lib/features/calendar',
        'lib/features/calendar/presentation',
        'lib/features/calendar/presentation/bloc',
        'lib/features/calendar/presentation/pages',
        'lib/features/calendar/presentation/widgets',
        'lib/features/calendar/domain',
        'lib/features/calendar/domain/entities',
        'lib/features/calendar/domain/usecases',
        'lib/features/settings',
        'lib/features/settings/data',
        'lib/features/settings/data/datasources',
        'lib/features/settings/data/models',
        'lib/features/settings/data/repositories',
        'lib/features/settings/domain',
        'lib/features/settings/domain/entities',
        'lib/features/settings/domain/repositories',
        'lib/features/settings/domain/usecases',
        'lib/features/settings/presentation',
        'lib/features/settings/presentation/bloc',
        'lib/features/settings/presentation/pages',
        'lib/features/settings/presentation/widgets',
        'lib/features/reminders',
        'lib/features/reminders/data',
        'lib/features/reminders/data/datasources',
        'lib/features/reminders/data/models',
        'lib/features/reminders/data/repositories',
        'lib/features/reminders/domain',
        'lib/features/reminders/domain/entities',
        'lib/features/reminders/domain/repositories',
        'lib/features/reminders/domain/usecases',
        'lib/features/reminders/presentation',
        'lib/features/reminders/presentation/bloc',
        'lib/features/reminders/presentation/pages',
        'lib/features/reminders/presentation/widgets',
        'lib/shared',
        'lib/shared/presentation',
        'lib/shared/presentation/widgets',
        'lib/shared/presentation/widgets/custom_charts',
        'lib/shared/presentation/widgets/animations',
        'lib/shared/presentation/layouts',
        'lib/shared/domain',
        'lib/shared/domain/entities',
        'lib/config',
        'lib/config/routes',
        'lib/config/localization',
        'lib/config/localization/l10n',
        'lib/config/localization/generated',
        'lib/config/di',
    ]

    # Define the files to be created
    files = {
        'lib/main.dart': '',
        'lib/app.dart': '',
        'lib/core/theme/app_theme.dart': '',
        'lib/core/theme/shadcn_theme.dart': '',
        'lib/core/theme/theme_extensions.dart': '',
        'lib/core/constants/app_constants.dart': '',
        'lib/core/constants/api_constants.dart': '',
        'lib/core/constants/storage_keys.dart': '',
        'lib/core/constants/assets.dart': '',
        'lib/core/database/app_database.dart': '',
        'lib/core/database/daos/period_dao.dart': '',
        'lib/core/database/daos/symptom_dao.dart': '',
        'lib/core/database/daos/mood_dao.dart': '',
        'lib/core/database/daos/user_dao.dart': '',
        'lib/core/database/entities/period_entity.dart': '',
        'lib/core/database/entities/cycle_entity.dart': '',
        'lib/core/database/entities/symptom_entity.dart': '',
        'lib/core/database/entities/mood_entity.dart': '',
        'lib/core/database/entities/user_entity.dart': '',
        'lib/core/services/notification_service.dart': '',
        'lib/core/services/analytics_service.dart': '',
        'lib/core/services/prediction_service.dart': '',
        'lib/core/services/backup_service.dart': '',
        'lib/core/services/haptic_service.dart': '',
        'lib/core/utils/date_helpers.dart': '',
        'lib/core/utils/validators.dart': '',
        'lib/core/utils/formatters.dart': '',
        'lib/core/utils/cycle_calculator.dart': '',
        'lib/core/utils/extensions.dart': '',
        'lib/core/utils/logger.dart': '',
        'lib/core/error/exceptions.dart': '',
        'lib/core/error/failures.dart': '',
        'lib/core/error/error_handler.dart': '',
        'lib/core/network/api_client.dart': '',
        'lib/core/network/network_info.dart': '',
        'lib/core/network/interceptors.dart': '',
        'lib/features/authentication/data/datasources/auth_local_datasource.dart': '',
        'lib/features/authentication/data/datasources/auth_remote_datasource.dart': '',
        'lib/features/authentication/data/models/user_model.dart': '',
        'lib/features/authentication/data/models/auth_response_model.dart': '',
        'lib/features/authentication/data/repositories/auth_repository_impl.dart': '',
        'lib/features/authentication/domain/entities/user.dart': '',
        'lib/features/authentication/domain/repositories/auth_repository.dart': '',
        'lib/features/authentication/domain/usecases/login_usecase.dart': '',
        'lib/features/authentication/domain/usecases/register_usecase.dart': '',
        'lib/features/authentication/domain/usecases/logout_usecase.dart': '',
        'lib/features/authentication/domain/usecases/verify_token_usecase.dart': '',
        'lib/features/authentication/presentation/bloc/auth_bloc.dart': '',
        'lib/features/authentication/presentation/bloc/auth_event.dart': '',
        'lib/features/authentication/presentation/bloc/auth_state.dart': '',
        'lib/features/authentication/presentation/pages/login_page.dart': '',
        'lib/features/authentication/presentation/pages/register_page.dart': '',
        'lib/features/authentication/presentation/pages/forgot_password_page.dart': '',
        'lib/features/authentication/presentation/pages/profile_setup_page.dart': '',
        'lib/features/authentication/presentation/widgets/auth_form.dart': '',
        'lib/features/authentication/presentation/widgets/social_auth_buttons.dart': '',
        'lib/features/authentication/presentation/widgets/password_strength_indicator.dart': '',
        'lib/features/authentication/presentation/widgets/biometric_login_button.dart': '',
        'lib/features/onboarding/presentation/bloc/onboarding_bloc.dart': '',
        'lib/features/onboarding/presentation/bloc/onboarding_event.dart': '',
        'lib/features/onboarding/presentation/bloc/onboarding_state.dart': '',
        'lib/features/onboarding/presentation/pages/splash_page.dart': '',
        'lib/features/onboarding/presentation/pages/onboarding_page.dart': '',
        'lib/features/onboarding/presentation/pages/welcome_page.dart': '',
        'lib/features/onboarding/presentation/pages/cycle_setup_page.dart': '',
        'lib/features/onboarding/presentation/widgets/onboarding_step.dart': '',
        'lib/features/onboarding/presentation/widgets/progress_steps.dart': '',
        'lib/features/onboarding/presentation/widgets/cycle_length_selector.dart': '',
        'lib/features/onboarding/data/models/onboarding_data.dart': '',
        'lib/features/period_tracking/data/datasources/period_local_datasource.dart': '',
        'lib/features/period_tracking/data/models/period_model.dart': '',
        'lib/features/period_tracking/data/models/cycle_model.dart': '',
        'lib/features/period_tracking/data/models/flow_model.dart': '',
        'lib/features/period_tracking/data/repositories/period_repository_impl.dart': '',
        'lib/features/period_tracking/domain/entities/period.dart': '',
        'lib/features/period_tracking/domain/entities/cycle.dart': '',
        'lib/features/period_tracking/domain/entities/flow.dart': '',
        'lib/features/period_tracking/domain/entities/prediction.dart': '',
        'lib/features/period_tracking/domain/repositories/period_repository.dart': '',
        'lib/features/period_tracking/domain/usecases/log_period_usecase.dart': '',
        'lib/features/period_tracking/domain/usecases/get_current_cycle_usecase.dart': '',
        'lib/features/period_tracking/domain/usecases/predict_next_period_usecase.dart': '',
        'lib/features/period_tracking/domain/usecases/calculate_fertility_usecase.dart': '',
        'lib/features/period_tracking/domain/usecases/get_cycle_history_usecase.dart': '',
        'lib/features/period_tracking/presentation/bloc/period_bloc.dart': '',
        'lib/features/period_tracking/presentation/bloc/period_event.dart': '',
        'lib/features/period_tracking/presentation/bloc/period_state.dart': '',
        'lib/features/period_tracking/presentation/pages/period_home_page.dart': '',
        'lib/features/period_tracking/presentation/pages/log_period_page.dart': '',
        'lib/features/period_tracking/presentation/pages/cycle_overview_page.dart': '',
        'lib/features/period_tracking/presentation/pages/fertility_page.dart': '',
        'lib/features/period_tracking/presentation/widgets/cycle_ring_chart.dart': '',
        'lib/features/period_tracking/presentation/widgets/period_calendar_widget.dart': '',
        'lib/features/period_tracking/presentation/widgets/flow_intensity_selector.dart': '',
        'lib/features/period_tracking/presentation/widgets/next_period_prediction_card.dart': '',
        'lib/features/period_tracking/presentation/widgets/fertility_window_card.dart': '',
        'lib/features/period_tracking/presentation/widgets/cycle_statistics_card.dart': '',
        'lib/features/symptom_tracking/data/datasources/symptom_local_datasource.dart': '',
        'lib/features/symptom_tracking/data/models/symptom_model.dart': '',
        'lib/features/symptom_tracking/data/repositories/symptom_repository_impl.dart': '',
        'lib/features/symptom_tracking/domain/entities/symptom.dart': '',
        'lib/features/symptom_tracking/domain/repositories/symptom_repository.dart': '',
        'lib/features/symptom_tracking/domain/usecases/log_symptom_usecase.dart': '',
        'lib/features/symptom_tracking/domain/usecases/get_symptoms_usecase.dart': '',
        'lib/features/symptom_tracking/domain/usecases/analyze_symptom_patterns_usecase.dart': '',
        'lib/features/symptom_tracking/presentation/bloc/symptom_bloc.dart': '',
        'lib/features/symptom_tracking/presentation/bloc/symptom_event.dart': '',
        'lib/features/symptom_tracking/presentation/bloc/symptom_state.dart': '',
        'lib/features/symptom_tracking/presentation/pages/symptom_tracker_page.dart': '',
        'lib/features/symptom_tracking/presentation/pages/symptom_insights_page.dart': '',
        'lib/features/symptom_tracking/presentation/widgets/symptom_category_card.dart': '',
        'lib/features/symptom_tracking/presentation/widgets/symptom_intensity_slider.dart': '',
        'lib/features/symptom_tracking/presentation/widgets/symptom_grid.dart': '',
        'lib/features/symptom_tracking/presentation/widgets/symptom_trends_chart.dart': '',
        'lib/features/mood_tracking/data/datasources/mood_local_datasource.dart': '',
        'lib/features/mood_tracking/data/models/mood_model.dart': '',
        'lib/features/mood_tracking/data/repositories/mood_repository_impl.dart': '',
        'lib/features/mood_tracking/domain/entities/mood.dart': '',
        'lib/features/mood_tracking/domain/repositories/mood_repository.dart': '',
        'lib/features/mood_tracking/domain/usecases/log_mood_usecase.dart': '',
        'lib/features/mood_tracking/domain/usecases/get_mood_history_usecase.dart': '',
        'lib/features/mood_tracking/domain/usecases/analyze_mood_patterns_usecase.dart': '',
        'lib/features/mood_tracking/presentation/bloc/mood_bloc.dart': '',
        'lib/features/mood_tracking/presentation/bloc/mood_event.dart': '',
        'lib/features/mood_tracking/presentation/bloc/mood_state.dart': '',
        'lib/features/mood_tracking/presentation/pages/mood_tracker_page.dart': '',
        'lib/features/mood_tracking/presentation/pages/mood_insights_page.dart': '',
        'lib/features/mood_tracking/presentation/widgets/mood_selector_wheel.dart': '',
        'lib/features/mood_tracking/presentation/widgets/emotion_tags.dart': '',
        'lib/features/mood_tracking/presentation/widgets/mood_calendar.dart': '',
        'lib/features/mood_tracking/presentation/widgets/mood_patterns_chart.dart': '',
        'lib/features/analytics/data/datasources/analytics_datasource.dart': '',
        'lib/features/analytics/data/models/cycle_stats_model.dart': '',
        'lib/features/analytics/data/models/health_insights_model.dart': '',
        'lib/features/analytics/data/repositories/analytics_repository_impl.dart': '',
        'lib/features/analytics/domain/entities/cycle_statistics.dart': '',
        'lib/features/analytics/domain/entities/health_insights.dart': '',
        'lib/features/analytics/domain/repositories/analytics_repository.dart': '',
        'lib/features/analytics/domain/usecases/generate_cycle_analytics_usecase.dart': '',
        'lib/features/analytics/domain/usecases/generate_health_insights_usecase.dart': '',
        'lib/features/analytics/domain/usecases/export_data_usecase.dart': '',
        'lib/features/analytics/presentation/bloc/analytics_bloc.dart': '',
        'lib/features/analytics/presentation/bloc/analytics_event.dart': '',
        'lib/features/analytics/presentation/bloc/analytics_state.dart': '',
        'lib/features/analytics/presentation/pages/analytics_page.dart': '',
        'lib/features/analytics/presentation/pages/insights_page.dart': '',
        'lib/features/analytics/presentation/pages/reports_page.dart': '',
        'lib/features/analytics/presentation/widgets/analytics_dashboard.dart': '',
        'lib/features/analytics/presentation/widgets/cycle_length_chart.dart': '',
        'lib/features/analytics/presentation/widgets/health_score_card.dart': '',
        'lib/features/analytics/presentation/widgets/pattern_insights_card.dart': '',
        'lib/features/analytics/presentation/widgets/export_dialog.dart': '',
        'lib/features/calendar/presentation/bloc/calendar_bloc.dart': '',
        'lib/features/calendar/presentation/bloc/calendar_event.dart': '',
        'lib/features/calendar/presentation/bloc/calendar_state.dart': '',
        'lib/features/calendar/presentation/pages/calendar_page.dart': '',
        'lib/features/calendar/presentation/pages/day_details_page.dart': '',
        'lib/features/calendar/presentation/widgets/custom_calendar.dart': '',
        'lib/features/calendar/presentation/widgets/calendar_day_cell.dart': '',
        'lib/features/calendar/presentation/widgets/month_view_header.dart': '',
        'lib/features/calendar/presentation/widgets/day_events_list.dart': '',
        'lib/features/calendar/presentation/widgets/calendar_legend.dart': '',
        'lib/features/calendar/domain/entities/calendar_day.dart': '',
        'lib/features/calendar/domain/usecases/get_calendar_data_usecase.dart': '',
        'lib/features/calendar/domain/usecases/get_day_details_usecase.dart': '',
        'lib/features/settings/data/datasources/settings_local_datasource.dart': '',
        'lib/features/settings/data/models/app_settings_model.dart': '',
        'lib/features/settings/data/models/notification_settings_model.dart': '',
        'lib/features/settings/data/repositories/settings_repository_impl.dart': '',
        'lib/features/settings/domain/entities/app_settings.dart': '',
        'lib/features/settings/domain/entities/notification_settings.dart': '',
        'lib/features/settings/domain/repositories/settings_repository.dart': '',
        'lib/features/settings/domain/usecases/get_settings_usecase.dart': '',
        'lib/features/settings/domain/usecases/update_settings_usecase.dart': '',
        'lib/features/settings/domain/usecases/reset_settings_usecase.dart': '',
        'lib/features/settings/presentation/bloc/settings_bloc.dart': '',
        'lib/features/settings/presentation/bloc/settings_event.dart': '',
        'lib/features/settings/presentation/bloc/settings_state.dart': '',
        'lib/features/settings/presentation/pages/settings_page.dart': '',
        'lib/features/settings/presentation/pages/notifications_page.dart': '',
        'lib/features/settings/presentation/pages/privacy_page.dart': '',
        'lib/features/settings/presentation/pages/data_export_page.dart': '',
        'lib/features/settings/presentation/pages/about_page.dart': '',
        'lib/features/settings/presentation/widgets/settings_section.dart': '',
        'lib/features/settings/presentation/widgets/setting_toggle.dart': '',
        'lib/features/settings/presentation/widgets/setting_slider.dart': '',
        'lib/features/settings/presentation/widgets/setting_picker.dart': '',
        'lib/features/settings/presentation/widgets/danger_zone.dart': '',
        'lib/features/reminders/data/datasources/reminder_local_datasource.dart': '',
        'lib/features/reminders/data/models/reminder_model.dart': '',
        'lib/features/reminders/data/repositories/reminder_repository_impl.dart': '',
        'lib/features/reminders/domain/entities/reminder.dart': '',
        'lib/features/reminders/domain/repositories/reminder_repository.dart': '',
        'lib/features/reminders/domain/usecases/create_reminder_usecase.dart': '',
        'lib/features/reminders/domain/usecases/update_reminder_usecase.dart': '',
        'lib/features/reminders/domain/usecases/delete_reminder_usecase.dart': '',
        'lib/features/reminders/domain/usecases/get_reminders_usecase.dart': '',
        'lib/features/reminders/presentation/bloc/reminder_bloc.dart': '',
        'lib/features/reminders/presentation/bloc/reminder_event.dart': '',
        'lib/features/reminders/presentation/bloc/reminder_state.dart': '',
        'lib/features/reminders/presentation/pages/reminders_page.dart': '',
        'lib/features/reminders/presentation/widgets/reminder_card.dart': '',
        'lib/features/reminders/presentation/widgets/add_reminder_dialog.dart': '',
        'lib/features/reminders/presentation/widgets/reminder_time_picker.dart': '',
        'lib/shared/presentation/widgets/app_navigation.dart': '',
        'lib/shared/presentation/widgets/loading_overlay.dart': '',
        'lib/shared/presentation/widgets/error_display.dart': '',
        'lib/shared/presentation/widgets/empty_state.dart': '',
        'lib/shared/presentation/widgets/custom_charts/donut_chart.dart': '',
        'lib/shared/presentation/widgets/custom_charts/line_chart.dart': '',
        'lib/shared/presentation/widgets/custom_charts/bar_chart.dart': '',
        'lib/shared/presentation/widgets/animations/fade_in_animation.dart': '',
        'lib/shared/presentation/widgets/animations/slide_animation.dart': '',
        'lib/shared/presentation/widgets/animations/scale_animation.dart': '',
        'lib/shared/presentation/layouts/main_layout.dart': '',
        'lib/shared/presentation/layouts/auth_layout.dart': '',
        'lib/shared/presentation/layouts/onboarding_layout.dart': '',
        'lib/shared/domain/entities/base_entity.dart': '',
        'lib/config/routes/app_router.dart': '',
        'lib/config/routes/route_names.dart': '',
        'lib/config/routes/route_guards.dart': '',
        'lib/config/localization/app_localizations.dart': '',
        'lib/config/localization/l10n/app_en.arb': '',
        'lib/config/localization/l10n/app_es.arb': '',
        'lib/config/localization/l10n/app_fr.arb': '',
        'lib/config/localization/l10n/app_de.arb': '',
        'lib/config/di/injection_container.dart': '',
        'lib/config/di/injection_container.config.dart': '',
        'lib/bootstrap.dart': '',
    }

    # Create directories
    for directory in directories:
        dir_path = os.path.join(base_path, directory)
        os.makedirs(dir_path, exist_ok=True)
        print(f"Created directory: {dir_path}")

    # Create files
    for file_path, content in files.items():
        full_path = os.path.join(base_path, file_path)
        with open(full_path, 'w') as f:
            f.write(content)
        print(f"Created file: {full_path}")

def main():
    base_path = 'flo_period_tracker'
    os.makedirs(base_path, exist_ok=True)
    create_directory_structure(base_path)
    print(f"Successfully created 'lib' folder structure in {base_path}")

if __name__ == '__main__':
    main()
