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
    String? profileImageUrl,
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
    DateTime? lastPeriodDate,
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

  @Query(
    'SELECT CAST((julianday("now") - julianday(dateOfBirth)) / 365.25 AS INTEGER) as age FROM users WHERE dateOfBirth IS NOT NULL',
  )
  Future<List<int>> getAllUserAges();

  // Profile Completeness
  @Query('''SELECT 
        CASE 
          WHEN name IS NOT NULL THEN 1 ELSE 0 END +
        CASE 
          WHEN dateOfBirth IS NOT NULL THEN 1 ELSE 0 END +
        CASE 
          WHEN profileImageUrl IS NOT NULL THEN 1 ELSE 0 END +
        CASE 
          WHEN averageCycleLength > 0 THEN 1 ELSE 0 END +
        CASE 
          WHEN averagePeriodLength > 0 THEN 1 ELSE 0 END
        as completedFields
       FROM users WHERE id = :id''')
  Future<int?> getProfileCompleteness(String id);

  @Query('''SELECT 
        (name IS NOT NULL) as hasName,
        (dateOfBirth IS NOT NULL) as hasDateOfBirth,
        (profileImageUrl IS NOT NULL) as hasProfileImage,
        (averageCycleLength > 0) as hasCycleLength,
        (averagePeriodLength > 0) as hasPeriodLength,
        (lastPeriodDate IS NOT NULL) as hasLastPeriodDate
       FROM users WHERE id = :id''')
  Future<Map<String, dynamic>?> getProfileCompletenessDetails(String id);

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

  // Health Profile Analysis
  @Query('''SELECT 
        AVG(averageCycleLength) as avgCycleLength,
        MIN(averageCycleLength) as minCycleLength,
        MAX(averageCycleLength) as maxCycleLength
       FROM users 
       WHERE averageCycleLength > 0''')
  Future<Map<String, dynamic>?> getCycleLengthStatistics();

  @Query('''SELECT 
        AVG(averagePeriodLength) as avgPeriodLength,
        MIN(averagePeriodLength) as minPeriodLength,
        MAX(averagePeriodLength) as maxPeriodLength
       FROM users 
       WHERE averagePeriodLength > 0''')
  Future<Map<String, dynamic>?> getPeriodLengthStatistics();

  @Query('''SELECT 
        averageCycleLength,
        COUNT(*) as userCount
       FROM users 
       WHERE averageCycleLength > 0
       GROUP BY averageCycleLength
       ORDER BY userCount DESC''')
  Future<List<Map<String, dynamic>>> getCycleLengthDistribution();

  // User Demographics (if date of birth is available)
  @Query('''SELECT 
        CASE 
          WHEN (julianday("now") - julianday(dateOfBirth)) / 365.25 < 20 THEN 'Under 20'
          WHEN (julianday("now") - julianday(dateOfBirth)) / 365.25 < 30 THEN '20-29'
          WHEN (julianday("now") - julianday(dateOfBirth)) / 365.25 < 40 THEN '30-39'
          WHEN (julianday("now") - julianday(dateOfBirth)) / 365.25 < 50 THEN '40-49'
          ELSE '50+'
        END as ageGroup,
        COUNT(*) as userCount
       FROM users 
       WHERE dateOfBirth IS NOT NULL
       GROUP BY ageGroup
       ORDER BY userCount DESC''')
  Future<List<Map<String, dynamic>>> getAgeGroupDistribution();

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

  // User Health Insights
  @Query(
    'SELECT * FROM users WHERE averageCycleLength < 21 OR averageCycleLength > 35',
  )
  Future<List<UserEntity>> getUsersWithIrregularCycles();

  @Query(
    'SELECT * FROM users WHERE averagePeriodLength < 3 OR averagePeriodLength > 7',
  )
  Future<List<UserEntity>> getUsersWithUnusualPeriodLength();

  @Query(
    'SELECT COUNT(*) FROM users WHERE lastPeriodDate IS NOT NULL AND (julianday("now") - julianday(lastPeriodDate)) > :days',
  )
  Future<int?> getUsersWithOldLastPeriodDate(int days);

  // Advanced User Analytics
  @Query('''SELECT 
        strftime('%Y-%m', createdAt) as registrationMonth,
        COUNT(*) as newUsers
       FROM users
       GROUP BY strftime('%Y-%m', createdAt)
       ORDER BY registrationMonth DESC''')
  Future<List<Map<String, dynamic>>> getMonthlyRegistrations();

  @Query('''SELECT 
        isOnboardingCompleted,
        COUNT(*) as userCount,
        AVG(julianday("now") - julianday(createdAt)) as avgDaysSinceRegistration
       FROM users
       GROUP BY isOnboardingCompleted''')
  Future<List<Map<String, dynamic>>> getOnboardingStatistics();

  // User Lifecycle
  @Query(
    'SELECT * FROM users WHERE (julianday("now") - julianday(updatedAt)) > :inactiveDays ORDER BY updatedAt ASC',
  )
  Future<List<UserEntity>> getInactiveUsers(int inactiveDays);

  @Query(
    'SELECT * FROM users WHERE (julianday("now") - julianday(createdAt)) <= :recentDays ORDER BY createdAt DESC',
  )
  Future<List<UserEntity>> getRecentUsers(int recentDays);
}
