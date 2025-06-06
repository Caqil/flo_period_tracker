// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../core/database/app_database.dart' as _i50;
import '../../core/services/notification_service.dart' as _i4;
import '../../features/authentication/presentation/bloc/auth_bloc.dart'
    as _i180;
import '../../features/calendar/data/datasources/calendar_local_datasource.dart'
    as _i494;
import '../../features/calendar/domain/repositories/calendar_repository.dart'
    as _i241;
import '../../features/calendar/domain/repositories/calendar_repository_impl.dart'
    as _i377;
import '../../features/calendar/domain/usecases/get_calendar_data_usecase.dart'
    as _i516;
import '../../features/calendar/presentation/bloc/calendar_bloc.dart' as _i1021;
import '../../features/period_tracking/data/datasources/period_local_datasource.dart'
    as _i865;
import '../../features/period_tracking/domain/repositories/period_repository_impl.dart'
    as _i203;
import '../../features/period_tracking/domain/usecases/log_period_usecase.dart'
    as _i1063;
import '../../features/period_tracking/domain/usecases/predict_next_period_usecase.dart'
    as _i421;
import '../../features/period_tracking/presentation/bloc/period_bloc.dart'
    as _i633;
import '../../features/settings/presentation/bloc/settings_bloc.dart' as _i585;
import '../../features/symptom_tracking/presentation/bloc/symptom_bloc.dart'
    as _i163;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i163.SymptomBloc>(() => _i163.SymptomBloc());
    gh.lazySingleton<_i4.NotificationService>(() => _i4.NotificationService());
    gh.lazySingleton<_i241.CalendarRepository>(
        () => _i377.CalendarRepositoryImpl(gh<InvalidType>()));
    gh.factory<_i585.SettingsBloc>(() => _i585.SettingsBloc(
          gh<InvalidType>(),
          gh<InvalidType>(),
        ));
    gh.lazySingleton<_i203.PeriodRepositoryImpl>(
        () => _i203.PeriodRepositoryImpl(gh<InvalidType>()));
    gh.factory<_i421.PredictNextPeriodUsecase>(
        () => _i421.PredictNextPeriodUsecase(gh<InvalidType>()));
    gh.lazySingleton<_i865.PeriodLocalDatasource>(
        () => _i865.PeriodLocalDatasourceImpl(gh<_i50.AppDatabase>()));
    gh.factory<_i516.GetCalendarDataUsecase>(
        () => _i516.GetCalendarDataUsecase(gh<_i241.CalendarRepository>()));
    gh.lazySingleton<_i494.CalendarLocalDatasource>(
        () => _i494.CalendarLocalDatasourceImpl(gh<_i50.AppDatabase>()));
    gh.factory<_i180.AuthBloc>(() => _i180.AuthBloc(
          gh<InvalidType>(),
          gh<InvalidType>(),
          gh<InvalidType>(),
          gh<InvalidType>(),
        ));
    gh.factory<_i633.PeriodBloc>(() => _i633.PeriodBloc(
          gh<_i1063.LogPeriodUsecase>(),
          gh<_i1063.GetCurrentCycleUsecase>(),
          gh<_i421.PredictNextPeriodUsecase>(),
        ));
    gh.factory<_i1021.CalendarBloc>(
        () => _i1021.CalendarBloc(gh<_i516.GetCalendarDataUsecase>()));
    return this;
  }
}
