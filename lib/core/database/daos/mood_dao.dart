import 'package:floor/floor.dart';

import '../entities/mood_entity.dart';

@dao
abstract class MoodDao {
  // Basic CRUD Operations
  @Query('SELECT * FROM moods ORDER BY date DESC')
  Future<List<MoodEntity>> getAllMoods();

  @Query('SELECT * FROM moods WHERE id = :id')
  Future<MoodEntity?> getMoodById(int id);

  @Query(
    'SELECT * FROM moods WHERE date = :date ORDER BY createdAt DESC LIMIT 1',
  )
  Future<MoodEntity?> getMoodByDate(DateTime date);

  @insert
  Future<int> insertMood(MoodEntity mood);

  @insert
  Future<List<int>> insertMoods(List<MoodEntity> moods);

  @update
  Future<void> updateMood(MoodEntity mood);

  @delete
  Future<void> deleteMood(MoodEntity mood);

  @Query('DELETE FROM moods WHERE id = :id')
  Future<void> deleteMoodById(int id);

  // Date Range Queries
  @Query(
    'SELECT * FROM moods WHERE date >= :startDate AND date <= :endDate ORDER BY date DESC',
  )
  Future<List<MoodEntity>> getMoodsInRange(
    DateTime startDate,
    DateTime endDate,
  );

  @Query(
    'SELECT * FROM moods WHERE date >= :startDate AND date <= :endDate AND mood = :moodType ORDER BY date DESC',
  )
  Future<List<MoodEntity>> getMoodsInRangeByType(
    DateTime startDate,
    DateTime endDate,
    String moodType,
  );

  @Query(
    'SELECT * FROM moods WHERE date >= :startDate AND date <= :endDate AND intensity >= :minIntensity ORDER BY date DESC',
  )
  Future<List<MoodEntity>> getMoodsInRangeByIntensity(
    DateTime startDate,
    DateTime endDate,
    int minIntensity,
  );

  // Recent Moods
  @Query('SELECT * FROM moods ORDER BY date DESC LIMIT :limit')
  Future<List<MoodEntity>> getRecentMoods(int limit);

  @Query('SELECT * FROM moods ORDER BY createdAt DESC LIMIT 1')
  Future<MoodEntity?> getLastMood();

  @Query(
    'SELECT * FROM moods WHERE date >= :date ORDER BY date DESC LIMIT :limit',
  )
  Future<List<MoodEntity>> getMoodsSince(DateTime date, int limit);

  // Statistical Queries
  @Query('SELECT COUNT(*) FROM moods')
  Future<int?> getMoodsCount();

  @Query(
    'SELECT COUNT(*) FROM moods WHERE date >= :startDate AND date <= :endDate',
  )
  Future<int?> getMoodsCountInRange(DateTime startDate, DateTime endDate);

  @Query('SELECT AVG(intensity) FROM moods')
  Future<double?> getAverageMoodIntensity();

  @Query(
    'SELECT AVG(intensity) FROM moods WHERE date >= :startDate AND date <= :endDate',
  )
  Future<double?> getAverageMoodIntensityInRange(
    DateTime startDate,
    DateTime endDate,
  );

  @Query('SELECT AVG(intensity) FROM moods WHERE mood = :moodType')
  Future<double?> getAverageIntensityByMoodType(String moodType);

  // Mood Pattern Analysis - Simplified queries
  @Query('SELECT mood FROM moods GROUP BY mood ORDER BY COUNT(*) DESC LIMIT 1')
  Future<String?> getMostFrequentMood();

  @Query(
    'SELECT mood FROM moods WHERE date >= :startDate AND date <= :endDate GROUP BY mood ORDER BY COUNT(*) DESC LIMIT 1',
  )
  Future<String?> getMostFrequentMoodInRange(
    DateTime startDate,
    DateTime endDate,
  );

  @Query('SELECT COUNT(*) FROM moods WHERE mood = :moodType')
  Future<int?> getMoodFrequencyByType(String moodType);

  @Query(
    'SELECT COUNT(*) FROM moods WHERE date >= :startDate AND date <= :endDate AND mood = :moodType',
  )
  Future<int?> getMoodFrequencyByTypeInRange(
    DateTime startDate,
    DateTime endDate,
    String moodType,
  );

  @Query('SELECT COUNT(*) FROM moods WHERE intensity = :intensity')
  Future<int?> getIntensityCount(int intensity);

  // Emotion Analysis
  @Query('SELECT * FROM moods WHERE emotions LIKE :emotion ORDER BY date DESC')
  Future<List<MoodEntity>> getMoodsByEmotion(String emotion);

  @Query('SELECT COUNT(*) FROM moods WHERE emotions LIKE :emotion')
  Future<int?> getEmotionFrequency(String emotion);

  // Weekly/Monthly Analysis - Simplified individual queries
  @Query('''SELECT AVG(intensity) FROM moods 
       WHERE date >= :startDate AND date <= :endDate''')
  Future<double?> getAvgIntensityInPeriod(DateTime startDate, DateTime endDate);

  @Query('''SELECT COUNT(*) FROM moods 
       WHERE date >= :startDate AND date <= :endDate''')
  Future<int?> getMoodCountInPeriod(DateTime startDate, DateTime endDate);

  // Notes Analysis
  @Query('SELECT * FROM moods WHERE notes IS NOT NULL AND notes != ""')
  Future<List<MoodEntity>> getMoodsWithNotes();

  @Query('SELECT * FROM moods WHERE notes LIKE :searchTerm ORDER BY date DESC')
  Future<List<MoodEntity>> searchMoodsByNotes(String searchTerm);

  @Query('SELECT COUNT(*) FROM moods WHERE notes IS NOT NULL AND notes != ""')
  Future<int?> getMoodsWithNotesCount();

  // Data Cleanup
  @Query('DELETE FROM moods WHERE date < :beforeDate')
  Future<void> deleteMoodsBeforeDate(DateTime beforeDate);

  @Query('DELETE FROM moods')
  Future<void> deleteAllMoods();

  // Backup/Export Queries
  @Query('SELECT * FROM moods WHERE createdAt >= :sinceDate ORDER BY date ASC')
  Future<List<MoodEntity>> getMoodsForBackup(DateTime sinceDate);

  @Query('SELECT * FROM moods WHERE updatedAt >= :sinceDate ORDER BY date ASC')
  Future<List<MoodEntity>> getModifiedMoodsSince(DateTime sinceDate);

  // Validation Queries
  @Query('SELECT COUNT(*) FROM moods WHERE date = :date')
  Future<int?> getMoodCountForDate(DateTime date);

  @Query('SELECT EXISTS(SELECT 1 FROM moods WHERE date = :date LIMIT 1)')
  Future<bool?> hasMoodForDate(DateTime date);

  // Advanced Analytics - Simplified individual queries
  @Query(
    'SELECT intensity FROM moods WHERE date = :date ORDER BY createdAt DESC LIMIT 1',
  )
  Future<int?> getIntensityForDate(DateTime date);

  @Query(
    'SELECT mood FROM moods WHERE date = :date ORDER BY createdAt DESC LIMIT 1',
  )
  Future<String?> getMoodTypeForDate(DateTime date);

  // Mood stats by type - individual queries
  @Query('''SELECT AVG(intensity) FROM moods 
       WHERE date >= :startDate AND date <= :endDate AND mood = :moodType''')
  Future<double?> getAvgIntensityByMoodTypeInRange(
    DateTime startDate,
    DateTime endDate,
    String moodType,
  );

  @Query('''SELECT MIN(intensity) FROM moods 
       WHERE date >= :startDate AND date <= :endDate AND mood = :moodType''')
  Future<int?> getMinIntensityByMoodTypeInRange(
    DateTime startDate,
    DateTime endDate,
    String moodType,
  );

  @Query('''SELECT MAX(intensity) FROM moods 
       WHERE date >= :startDate AND date <= :endDate AND mood = :moodType''')
  Future<int?> getMaxIntensityByMoodTypeInRange(
    DateTime startDate,
    DateTime endDate,
    String moodType,
  );

  @Query('''SELECT COUNT(*) FROM moods 
       WHERE date >= :startDate AND date <= :endDate AND mood = :moodType''')
  Future<int?> getFrequencyByMoodTypeInRange(
    DateTime startDate,
    DateTime endDate,
    String moodType,
  );

  // Cycle day analysis - simplified
  @Query('''SELECT AVG(intensity) FROM moods 
       WHERE date >= :cycleStartDate''')
  Future<double?> getAvgIntensitySinceCycleStart(DateTime cycleStartDate);

  @Query('''SELECT COUNT(*) FROM moods 
       WHERE date >= :cycleStartDate''')
  Future<int?> getMoodCountSinceCycleStart(DateTime cycleStartDate);

  // Streak analysis - simplified
  @Query('''SELECT COUNT(DISTINCT date) FROM moods 
       WHERE date >= :startDate''')
  Future<int?> getDaysWithMoodsSince(DateTime startDate);

  @Query('''SELECT MAX(intensity) FROM moods''')
  Future<int?> getHighestIntensityEver();

  @Query('''SELECT MIN(intensity) FROM moods''')
  Future<int?> getLowestIntensityEver();

  @Query('''SELECT COUNT(DISTINCT mood) FROM moods''')
  Future<int?> getUniqueMoodTypesCount();
}
