// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../core/services/notification_service.dart' as _i4;
import '../../features/authentication/presentation/bloc/auth_bloc.dart'
    as _i180;
import '../../features/calendar/domain/repositories/calendar_repository.dart'
    as _i241;
import '../../features/calendar/domain/usecases/get_calendar_data_usecase.dart'
    as _i516;
import '../../features/calendar/presentation/bloc/calendar_bloc.dart' as _i1021;
import '../../features/period_tracking/presentation/bloc/period_bloc.dart'
    as _i633;
import '../../features/settings/presentation/bloc/settings_bloc.dart' as _i585;

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
    gh.lazySingleton<_i4.NotificationService>(() => _i4.NotificationService());
    gh.factory<_i585.SettingsBloc>(() => _i585.SettingsBloc(
          gh<InvalidType>(),
          gh<InvalidType>(),
        ));
    gh.factory<_i516.GetCalendarDataUsecase>(
        () => _i516.GetCalendarDataUsecase(gh<_i241.CalendarRepository>()));
    gh.factory<_i633.PeriodBloc>(() => _i633.PeriodBloc(
          gh<InvalidType>(),
          gh<InvalidType>(),
          gh<InvalidType>(),
        ));
    gh.factory<_i180.AuthBloc>(() => _i180.AuthBloc(
          gh<InvalidType>(),
          gh<InvalidType>(),
          gh<InvalidType>(),
          gh<InvalidType>(),
        ));
    gh.factory<_i1021.CalendarBloc>(
        () => _i1021.CalendarBloc(gh<_i516.GetCalendarDataUsecase>()));
    return this;
  }
}
