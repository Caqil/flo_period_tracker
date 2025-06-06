import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'config/localization/app_localizations.dart';
import 'config/routes/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'features/settings/presentation/bloc/settings_bloc.dart';
import 'features/period_tracking/presentation/bloc/period_bloc.dart';
import 'features/calendar/presentation/bloc/calendar_bloc.dart';
import 'features/symptom_tracking/presentation/bloc/symptom_bloc.dart';
import 'config/di/injection_container.dart' as di;

class FloApp extends StatelessWidget {
  const FloApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              di.sl<UserProfileBloc>()..add(const UserProfileLoadRequested()),
        ),
        BlocProvider(
          create: (_) =>
              di.sl<SettingsBloc>()..add(const SettingsLoadRequested()),
        ),
        BlocProvider(create: (_) => di.sl<PeriodBloc>()),
        BlocProvider(create: (_) => di.sl<CalendarBloc>()),
        BlocProvider(create: (_) => di.sl<SymptomBloc>()),
      ],
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, settingsState) {
          return ShadApp.router(
            title: 'Flo Period Tracker',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme(settingsState),
            darkTheme: AppTheme.darkTheme(settingsState),
            themeMode: settingsState.themeMode,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            locale: settingsState.locale,
            routerConfig: AppRouter.router,
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: TextScaler.linear(settingsState.textScale),
                ),
                child: child ?? const SizedBox.shrink(),
              );
            },
          );
        },
      ),
    );
  }
}
