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

  // Mood Pattern Analysis
  @Query(
    'SELECT mood, COUNT(*) as count FROM moods GROUP BY mood ORDER BY count DESC',
  )
  Future<List<Map<String, dynamic>>> getMoodFrequency();

  @Query(
    'SELECT mood, COUNT(*) as count FROM moods WHERE date >= :startDate AND date <= :endDate GROUP BY mood ORDER BY count DESC',
  )
  Future<List<Map<String, dynamic>>> getMoodFrequencyInRange(
    DateTime startDate,
    DateTime endDate,
  );

  @Query(
    'SELECT intensity, COUNT(*) as count FROM moods GROUP BY intensity ORDER BY intensity',
  )
  Future<List<Map<String, dynamic>>> getIntensityDistribution();

  @Query('SELECT mood FROM moods GROUP BY mood ORDER BY COUNT(*) DESC LIMIT 1')
  Future<String?> getMostFrequentMood();

  @Query(
    'SELECT mood FROM moods WHERE date >= :startDate AND date <= :endDate GROUP BY mood ORDER BY COUNT(*) DESC LIMIT 1',
  )
  Future<String?> getMostFrequentMoodInRange(
    DateTime startDate,
    DateTime endDate,
  );

  // Emotion Analysis
  @Query(
    'SELECT emotions FROM moods WHERE emotions IS NOT NULL AND emotions != ""',
  )
  Future<List<String>> getAllEmotions();

  @Query('SELECT * FROM moods WHERE emotions LIKE :emotion ORDER BY date DESC')
  Future<List<MoodEntity>> getMoodsByEmotion(String emotion);

  // Weekly/Monthly Analysis
  @Query('''SELECT 
        strftime('%Y-%W', date) as week,
        AVG(intensity) as avgIntensity,
        COUNT(*) as count
       FROM moods 
       WHERE date >= :startDate 
       GROUP BY strftime('%Y-%W', date) 
       ORDER BY week DESC''')
  Future<List<Map<String, dynamic>>> getWeeklyMoodStats(DateTime startDate);

  @Query('''SELECT 
        strftime('%Y-%m', date) as month,
        AVG(intensity) as avgIntensity,
        COUNT(*) as count
       FROM moods 
       WHERE date >= :startDate 
       GROUP BY strftime('%Y-%m', date) 
       ORDER BY month DESC''')
  Future<List<Map<String, dynamic>>> getMonthlyMoodStats(DateTime startDate);

  // Streak Analysis
  @Query('''SELECT COUNT(*) as streak 
       FROM (
         SELECT date, 
                ROW_NUMBER() OVER (ORDER BY date) - 
                ROW_NUMBER() OVER (PARTITION BY date ORDER BY date) as grp
         FROM moods 
         WHERE date >= :startDate
       ) 
       GROUP BY grp 
       ORDER BY streak DESC 
       LIMIT 1''')
  Future<int?> getLongestMoodStreak(DateTime startDate);

  // Notes Analysis
  @Query('SELECT * FROM moods WHERE notes IS NOT NULL AND notes != ""')
  Future<List<MoodEntity>> getMoodsWithNotes();

  @Query('SELECT * FROM moods WHERE notes LIKE :searchTerm ORDER BY date DESC')
  Future<List<MoodEntity>> searchMoodsByNotes(String searchTerm);

  // Cycle Day Analysis (for period tracking correlation)
  @Query('''SELECT 
        (julianday(date) - julianday(:cycleStartDate)) % :cycleLength + 1 as cycleDay,
        AVG(intensity) as avgIntensity,
        COUNT(*) as count
       FROM moods 
       WHERE date >= :cycleStartDate
       GROUP BY cycleDay 
       ORDER BY cycleDay''')
  Future<List<Map<String, dynamic>>> getMoodByCycleDay(
    DateTime cycleStartDate,
    int cycleLength,
  );

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

  // Advanced Analytics
  @Query('''SELECT 
        date,
        mood,
        intensity,
        LAG(intensity) OVER (ORDER BY date) as previousIntensity
       FROM moods 
       WHERE date >= :startDate 
       ORDER BY date''')
  Future<List<Map<String, dynamic>>> getMoodTrends(DateTime startDate);

  @Query('''SELECT 
        mood,
        AVG(intensity) as avgIntensity,
        MIN(intensity) as minIntensity,
        MAX(intensity) as maxIntensity,
        COUNT(*) as frequency
       FROM moods 
       WHERE date >= :startDate AND date <= :endDate
       GROUP BY mood
       ORDER BY frequency DESC''')
  Future<List<Map<String, dynamic>>> getMoodStatsByType(
    DateTime startDate,
    DateTime endDate,
  );
}
