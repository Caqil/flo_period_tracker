part of 'user_profile_bloc.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object?> get props => [];
}

class UserProfileLoadRequested extends UserProfileEvent {
  const UserProfileLoadRequested();
}

class UserProfileSetupRequested extends UserProfileEvent {
  final String? name;
  final DateTime? dateOfBirth;
  final int averageCycleLength;
  final int averagePeriodLength;
  final DateTime? lastPeriodDate;

  const UserProfileSetupRequested({
    this.name,
    this.dateOfBirth,
    required this.averageCycleLength,
    required this.averagePeriodLength,
    this.lastPeriodDate,
  });

  @override
  List<Object?> get props => [
    name,
    dateOfBirth,
    averageCycleLength,
    averagePeriodLength,
    lastPeriodDate,
  ];
}

class UserProfileUpdateRequested extends UserProfileEvent {
  final UserProfile profile;

  const UserProfileUpdateRequested({required this.profile});

  @override
  List<Object> get props => [profile];
}

class UserProfilePinSetRequested extends UserProfileEvent {
  final String pin;

  const UserProfilePinSetRequested({required this.pin});

  @override
  List<Object> get props => [pin];
}

class UserProfileBiometricToggled extends UserProfileEvent {
  final bool enabled;

  const UserProfileBiometricToggled({required this.enabled});

  @override
  List<Object> get props => [enabled];
}
