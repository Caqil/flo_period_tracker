import 'package:floor/floor.dart';

import '../entities/user_entity.dart';

@dao
abstract class UserDao {
  // Basic CRUD Operations
  @Query('SELECT * FROM users ORDER BY createdAt DESC')
  Future<List<UserEntity>> getAllUsers();

  @Query('SELECT * FROM users WHERE id = :id')
  Future<UserEntity?> getUserById(String id);

  @Query('SELECT * FROM users WHERE email = :email')
  Future<UserEntity?> getUserByEmail(String email);

  @Query('SELECT * FROM users LIMIT 1')
  Future<UserEntity?> getCurrentUser();

  @insert
  Future<void> insertUser(UserEntity user);

  @insert
  Future<void> insertUsers(List<UserEntity> users);

  @update
  Future<void> updateUser(UserEntity user);

  @delete
  Future<void> deleteUser(UserEntity user);

  @Query('DELETE FROM users WHERE id = :id')
  Future<void> deleteUserById(String id);

  // Profile Management
  @Query('UPDATE users SET name = :name, updatedAt = :updatedAt WHERE id = :id')
  Future<void> updateUserName(String id, String name, DateTime updatedAt);

  @Query(
    'UPDATE users SET email = :email, updatedAt = :updatedAt WHERE id = :id',
  )
  Future<void> updateUserEmail(String id, String email, DateTime updatedAt);

  @Query(
    'UPDATE users SET dateOfBirth = :dateOfBirth, updatedAt = :updatedAt WHERE id = :id',
  )
  Future<void> updateUserDateOfBirth(
    String id,
    DateTime dateOfBirth,
    DateTime updatedAt,
  );

  @Query(
    'UPDATE users SET profileImageUrl = :profileImageUrl, updatedAt = :updatedAt WHERE id = :id',
  )
  Future<void> updateUserProfileImage(
    String id,
    String profileImageUrl,
    DateTime updatedAt,
  );

  // Cycle Settings Management
  @Query(
    'UPDATE users SET averageCycleLength = :cycleLength, updatedAt = :updatedAt WHERE id = :id',
  )
  Future<void> updateAverageCycleLength(
    String id,
    int cycleLength,
    DateTime updatedAt,
  );

  @Query(
    'UPDATE users SET averagePeriodLength = :periodLength, updatedAt = :updatedAt WHERE id = :id',
  )
  Future<void> updateAveragePeriodLength(
    String id,
    int periodLength,
    DateTime updatedAt,
  );

  @Query(
    'UPDATE users SET lastPeriodDate = :lastPeriodDate, updatedAt = :updatedAt WHERE id = :id',
  )
  Future<void> updateLastPeriodDate(
    String id,
    DateTime lastPeriodDate,
    DateTime updatedAt,
  );

  @Query(
    'UPDATE users SET averageCycleLength = :cycleLength, averagePeriodLength = :periodLength, updatedAt = :updatedAt WHERE id = :id',
  )
  Future<void> updateCycleSettings(
    String id,
    int cycleLength,
    int periodLength,
    DateTime updatedAt,
  );

  // Onboarding Management
  @Query(
    'UPDATE users SET isOnboardingCompleted = :isCompleted, updatedAt = :updatedAt WHERE id = :id',
  )
  Future<void> updateOnboardingStatus(
    String id,
    bool isCompleted,
    DateTime updatedAt,
  );

  @Query('SELECT isOnboardingCompleted FROM users WHERE id = :id')
  Future<bool?> isOnboardingCompleted(String id);

  @Query('SELECT isOnboardingCompleted FROM users LIMIT 1')
  Future<bool?> isCurrentUserOnboardingCompleted();

  // User Statistics and Information
  @Query('SELECT COUNT(*) FROM users')
  Future<int?> getUsersCount();

  @Query('SELECT createdAt FROM users WHERE id = :id')
  Future<DateTime?> getUserCreatedDate(String id);

  @Query('SELECT updatedAt FROM users WHERE id = :id')
  Future<DateTime?> getUserLastUpdated(String id);

  @Query('SELECT averageCycleLength FROM users WHERE id = :id')
  Future<int?> getUserAverageCycleLength(String id);

  @Query('SELECT averagePeriodLength FROM users WHERE id = :id')
  Future<int?> getUserAveragePeriodLength(String id);

  @Query('SELECT lastPeriodDate FROM users WHERE id = :id')
  Future<DateTime?> getUserLastPeriodDate(String id);

  // User Age Calculations
  @Query('SELECT dateOfBirth FROM users WHERE id = :id')
  Future<DateTime?> getUserDateOfBirth(String id);

  @Query(
    'SELECT CAST((julianday("now") - julianday(dateOfBirth)) / 365.25 AS INTEGER) as age FROM users WHERE id = :id',
  )
  Future<int?> getUserAge(String id);

  // Profile Completeness - Simplified individual queries
  @Query('SELECT name FROM users WHERE id = :id')
  Future<String?> getUserName(String id);

  @Query('SELECT profileImageUrl FROM users WHERE id = :id')
  Future<String?> getUserProfileImageUrl(String id);

  @Query('SELECT email FROM users WHERE id = :id')
  Future<String?> getUserEmail(String id);

  @Query('SELECT (name IS NOT NULL) FROM users WHERE id = :id')
  Future<bool?> hasUserName(String id);

  @Query('SELECT (dateOfBirth IS NOT NULL) FROM users WHERE id = :id')
  Future<bool?> hasUserDateOfBirth(String id);

  @Query('SELECT (profileImageUrl IS NOT NULL) FROM users WHERE id = :id')
  Future<bool?> hasUserProfileImage(String id);

  @Query('SELECT (averageCycleLength > 0) FROM users WHERE id = :id')
  Future<bool?> hasUserCycleLength(String id);

  @Query('SELECT (averagePeriodLength > 0) FROM users WHERE id = :id')
  Future<bool?> hasUserPeriodLength(String id);

  @Query('SELECT (lastPeriodDate IS NOT NULL) FROM users WHERE id = :id')
  Future<bool?> hasUserLastPeriodDate(String id);

  // User Activity Analysis
  @Query(
    'SELECT (julianday("now") - julianday(updatedAt)) as daysSinceLastUpdate FROM users WHERE id = :id',
  )
  Future<double?> getDaysSinceLastUpdate(String id);

  @Query(
    'SELECT (julianday("now") - julianday(createdAt)) as daysSinceRegistration FROM users WHERE id = :id',
  )
  Future<double?> getDaysSinceRegistration(String id);

  // Data Validation
  @Query('SELECT EXISTS(SELECT 1 FROM users WHERE email = :email LIMIT 1)')
  Future<bool?> isEmailTaken(String email);

  @Query('SELECT EXISTS(SELECT 1 FROM users WHERE id = :id LIMIT 1)')
  Future<bool?> userExists(String id);

  @Query('SELECT id FROM users WHERE email = :email')
  Future<String?> getUserIdByEmail(String email);

  // User Preferences and Settings (if stored in user table)
  @Query('SELECT * FROM users WHERE isOnboardingCompleted = 1')
  Future<List<UserEntity>> getCompletedUsers();

  @Query('SELECT * FROM users WHERE isOnboardingCompleted = 0')
  Future<List<UserEntity>> getIncompleteUsers();

  @Query('SELECT * FROM users WHERE profileImageUrl IS NOT NULL')
  Future<List<UserEntity>> getUsersWithProfileImages();

  @Query('SELECT * FROM users WHERE profileImageUrl IS NULL')
  Future<List<UserEntity>> getUsersWithoutProfileImages();

  // Health Profile Analysis - Simplified individual queries
  @Query(
    'SELECT AVG(averageCycleLength) FROM users WHERE averageCycleLength > 0',
  )
  Future<double?> getAvgCycleLength();

  @Query(
    'SELECT MIN(averageCycleLength) FROM users WHERE averageCycleLength > 0',
  )
  Future<int?> getMinCycleLength();

  @Query(
    'SELECT MAX(averageCycleLength) FROM users WHERE averageCycleLength > 0',
  )
  Future<int?> getMaxCycleLength();

  @Query(
    'SELECT AVG(averagePeriodLength) FROM users WHERE averagePeriodLength > 0',
  )
  Future<double?> getAvgPeriodLength();

  @Query(
    'SELECT MIN(averagePeriodLength) FROM users WHERE averagePeriodLength > 0',
  )
  Future<int?> getMinPeriodLength();

  @Query(
    'SELECT MAX(averagePeriodLength) FROM users WHERE averagePeriodLength > 0',
  )
  Future<int?> getMaxPeriodLength();

  @Query('SELECT COUNT(*) FROM users WHERE averageCycleLength = :cycleLength')
  Future<int?> getUsersWithCycleLength(int cycleLength);

  // User Demographics - Simplified counts by age ranges
  @Query('''SELECT COUNT(*) FROM users 
       WHERE dateOfBirth IS NOT NULL 
       AND (julianday("now") - julianday(dateOfBirth)) / 365.25 < 20''')
  Future<int?> getUsersUnder20();

  @Query('''SELECT COUNT(*) FROM users 
       WHERE dateOfBirth IS NOT NULL 
       AND (julianday("now") - julianday(dateOfBirth)) / 365.25 >= 20 
       AND (julianday("now") - julianday(dateOfBirth)) / 365.25 < 30''')
  Future<int?> getUsers20to29();

  @Query('''SELECT COUNT(*) FROM users 
       WHERE dateOfBirth IS NOT NULL 
       AND (julianday("now") - julianday(dateOfBirth)) / 365.25 >= 30 
       AND (julianday("now") - julianday(dateOfBirth)) / 365.25 < 40''')
  Future<int?> getUsers30to39();

  @Query('''SELECT COUNT(*) FROM users 
       WHERE dateOfBirth IS NOT NULL 
       AND (julianday("now") - julianday(dateOfBirth)) / 365.25 >= 40 
       AND (julianday("now") - julianday(dateOfBirth)) / 365.25 < 50''')
  Future<int?> getUsers40to49();

  @Query('''SELECT COUNT(*) FROM users 
       WHERE dateOfBirth IS NOT NULL 
       AND (julianday("now") - julianday(dateOfBirth)) / 365.25 >= 50''')
  Future<int?> getUsersOver50();

  // Data Export/Backup
  @Query(
    'SELECT * FROM users WHERE createdAt >= :sinceDate ORDER BY createdAt ASC',
  )
  Future<List<UserEntity>> getUsersForBackup(DateTime sinceDate);

  @Query(
    'SELECT * FROM users WHERE updatedAt >= :sinceDate ORDER BY updatedAt ASC',
  )
  Future<List<UserEntity>> getModifiedUsersSince(DateTime sinceDate);

  // Data Cleanup
  @Query(
    'DELETE FROM users WHERE createdAt < :beforeDate AND isOnboardingCompleted = 0',
  )
  Future<void> deleteIncompleteUsersBeforeDate(DateTime beforeDate);

  @Query('DELETE FROM users')
  Future<void> deleteAllUsers();

  // User Search and Filtering
  @Query('SELECT * FROM users WHERE name LIKE :searchTerm ORDER BY name')
  Future<List<UserEntity>> searchUsersByName(String searchTerm);

  @Query('SELECT * FROM users WHERE email LIKE :searchTerm ORDER BY email')
  Future<List<UserEntity>> searchUsersByEmail(String searchTerm);

  // Batch Updates
  @Query('UPDATE users SET isOnboardingCompleted = 1, updatedAt = :updatedAt')
  Future<void> markAllUsersOnboardingCompleted(DateTime updatedAt);

  @Query('UPDATE users SET profileImageUrl = NULL, updatedAt = :updatedAt')
  Future<void> clearAllProfileImages(DateTime updatedAt);

  // User Health Insights - Individual counts
  @Query(
    'SELECT COUNT(*) FROM users WHERE averageCycleLength < 21 OR averageCycleLength > 35',
  )
  Future<int?> getUsersWithIrregularCyclesCount();

  @Query(
    'SELECT COUNT(*) FROM users WHERE averagePeriodLength < 3 OR averagePeriodLength > 7',
  )
  Future<int?> getUsersWithUnusualPeriodLengthCount();

  @Query(
    'SELECT COUNT(*) FROM users WHERE lastPeriodDate IS NOT NULL AND (julianday("now") - julianday(lastPeriodDate)) > :days',
  )
  Future<int?> getUsersWithOldLastPeriodDate(int days);

  // Advanced User Analytics - Simplified counts
  @Query('''SELECT COUNT(*) FROM users WHERE isOnboardingCompleted = 1''')
  Future<int?> getCompletedUsersCount();

  @Query('''SELECT COUNT(*) FROM users WHERE isOnboardingCompleted = 0''')
  Future<int?> getIncompleteUsersCount();

  @Query(
    '''SELECT AVG(julianday("now") - julianday(createdAt)) FROM users WHERE isOnboardingCompleted = 1''',
  )
  Future<double?> getAvgDaysSinceRegistrationForCompleted();

  @Query(
    '''SELECT AVG(julianday("now") - julianday(createdAt)) FROM users WHERE isOnboardingCompleted = 0''',
  )
  Future<double?> getAvgDaysSinceRegistrationForIncomplete();

  // User Lifecycle
  @Query(
    'SELECT * FROM users WHERE (julianday("now") - julianday(updatedAt)) > :inactiveDays ORDER BY updatedAt ASC',
  )
  Future<List<UserEntity>> getInactiveUsers(int inactiveDays);

  @Query(
    'SELECT * FROM users WHERE (julianday("now") - julianday(createdAt)) <= :recentDays ORDER BY createdAt DESC',
  )
  Future<List<UserEntity>> getRecentUsers(int recentDays);

  @Query(
    'SELECT COUNT(*) FROM users WHERE (julianday("now") - julianday(updatedAt)) > :inactiveDays',
  )
  Future<int?> getInactiveUsersCount(int inactiveDays);

  @Query(
    'SELECT COUNT(*) FROM users WHERE (julianday("now") - julianday(createdAt)) <= :recentDays',
  )
  Future<int?> getRecentUsersCount(int recentDays);
}
