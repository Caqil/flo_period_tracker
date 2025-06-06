import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/verify_token_usecase.dart';
import '../../../../core/utils/logger.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase _loginUsecase;
  final RegisterUsecase _registerUsecase;
  final LogoutUsecase _logoutUsecase;
  final VerifyTokenUsecase _verifyTokenUsecase;

  AuthBloc(
    this._loginUsecase,
    this._registerUsecase,
    this._logoutUsecase,
    this._verifyTokenUsecase,
  ) : super(const AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthRegisterRequested>(_onRegisterRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading());

      final result = await _verifyTokenUsecase();

      result.fold(
        (failure) {
          AppLogger.d('Auth check failed: ${failure.message}');
          emit(const AuthUnauthenticated());
        },
        (user) {
          AppLogger.i('User authenticated: ${user.email}');
          emit(AuthAuthenticated(user: user));
        },
      );
    } catch (e, stackTrace) {
      AppLogger.e('Auth check error', e, stackTrace);
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading());

      final result = await _loginUsecase(
        LoginParams(email: event.email, password: event.password),
      );

      result.fold(
        (failure) {
          AppLogger.w('Login failed: ${failure.message}');
          emit(AuthError(message: failure.message));
        },
        (user) {
          AppLogger.i('User logged in: ${user.email}');
          emit(AuthAuthenticated(user: user));
        },
      );
    } catch (e, stackTrace) {
      AppLogger.e('Login error', e, stackTrace);
      emit(const AuthError(message: 'An unexpected error occurred'));
    }
  }

  Future<void> _onRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading());

      final result = await _registerUsecase(
        RegisterParams(
          email: event.email,
          password: event.password,
          name: event.name,
        ),
      );

      result.fold(
        (failure) {
          AppLogger.w('Registration failed: ${failure.message}');
          emit(AuthError(message: failure.message));
        },
        (user) {
          AppLogger.i('User registered: ${user.email}');
          emit(AuthAuthenticated(user: user));
        },
      );
    } catch (e, stackTrace) {
      AppLogger.e('Registration error', e, stackTrace);
      emit(const AuthError(message: 'Registration failed'));
    }
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading());

      final result = await _logoutUsecase();

      result.fold(
        (failure) {
          AppLogger.w('Logout failed: ${failure.message}');
          // Even if logout fails, clear local state
          emit(const AuthUnauthenticated());
        },
        (_) {
          AppLogger.i('User logged out');
          emit(const AuthUnauthenticated());
        },
      );
    } catch (e, stackTrace) {
      AppLogger.e('Logout error', e, stackTrace);
      emit(const AuthUnauthenticated());
    }
  }
}
