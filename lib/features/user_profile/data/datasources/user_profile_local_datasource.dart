import 'package:injectable/injectable.dart';

import '../../../../core/database/entities/user_entity.dart';
import '../../domain/entities/user_profile.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/error/exceptions.dart';

abstract class UserProfileLocalDatasource {
  Future<UserProfile?> getCurrentProfile();
  Future<UserProfile> createProfile(UserProfile profile);
  Future<UserProfile> updateProfile(UserProfile profile);
  Future<void> deleteProfile();
}

@LazySingleton(as: UserProfileLocalDatasource)
class UserProfileLocalDatasourceImpl implements UserProfileLocalDatasource {
  final AppDatabase _database;

  UserProfileLocalDatasourceImpl(this._database);

  @override
  Future<UserProfile?> getCurrentProfile() async {
    try {
      final userEntity = await _database.userDao.getCurrentUser();
      if (userEntity == null) return null;

      return UserProfile(
        id: userEntity.id,
        name: userEntity.name,
        dateOfBirth: userEntity.dateOfBirth,
        averageCycleLength: userEntity.averageCycleLength,
        averagePeriodLength: userEntity.averagePeriodLength,
        lastPeriodDate: userEntity.lastPeriodDate,
        isSetupCompleted: userEntity.isOnboardingCompleted,
        profileImagePath: userEntity.profileImageUrl,
        createdAt: userEntity.createdAt,
        updatedAt: userEntity.updatedAt,
      );
    } catch (e) {
      throw DatabaseException(message: 'Failed to get profile: $e');
    }
  }

  @override
  Future<UserProfile> createProfile(UserProfile profile) async {
    try {
      final userEntity = profile.toUserEntity();
      await _database.userDao.insertUser(userEntity);
      return profile;
    } catch (e) {
      throw DatabaseException(message: 'Failed to create profile: $e');
    }
  }

  @override
  Future<UserProfile> updateProfile(UserProfile profile) async {
    try {
      final userEntity = profile.toUserEntity();
      await _database.userDao.updateUser(userEntity);
      return profile;
    } catch (e) {
      throw DatabaseException(message: 'Failed to update profile: $e');
    }
  }

  @override
  Future<void> deleteProfile() async {
    try {
      await _database.userDao.deleteAllUsers();
    } catch (e) {
      throw DatabaseException(message: 'Failed to delete profile: $e');
    }
  }
}

// Extension for UserProfile
extension UserProfileExtensions on UserProfile {
  UserEntity toUserEntity() {
    return UserEntity(
      id: id,
      email: 'local@user.com', // Not used in local app
      name: name,
      dateOfBirth: dateOfBirth,
      averageCycleLength: averageCycleLength,
      averagePeriodLength: averagePeriodLength,
      lastPeriodDate: lastPeriodDate,
      isOnboardingCompleted: isSetupCompleted,
      profileImageUrl: profileImagePath,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
