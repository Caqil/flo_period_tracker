import 'package:floor/floor.dart';

import '../entities/symptom_entity.dart';

@dao
abstract class SymptomDao {
  // Basic CRUD Operations
  @Query('SELECT * FROM symptoms ORDER BY date DESC, createdAt DESC')
  Future<List<SymptomEntity>> getAllSymptoms();

  @Query('SELECT * FROM symptoms WHERE id = :id')
  Future<SymptomEntity?> getSymptomById(int id);

  @Query('SELECT * FROM symptoms WHERE date = :date ORDER BY createdAt DESC')
  Future<List<SymptomEntity>> getSymptomsByDate(DateTime date);

  @insert
  Future<int> insertSymptom(SymptomEntity symptom);

  @insert
  Future<List<int>> insertSymptoms(List<SymptomEntity> symptoms);

  @update
  Future<void> updateSymptom(SymptomEntity symptom);

  @delete
  Future<void> deleteSymptom(SymptomEntity symptom);

  @Query('DELETE FROM symptoms WHERE id = :id')
  Future<void> deleteSymptomById(int id);

  // Date Range Queries
  @Query(
    'SELECT * FROM symptoms WHERE date >= :startDate AND date <= :endDate ORDER BY date DESC, createdAt DESC',
  )
  Future<List<SymptomEntity>> getSymptomsInRange(
    DateTime startDate,
    DateTime endDate,
  );

  @Query(
    'SELECT * FROM symptoms WHERE date >= :startDate AND date <= :endDate AND category = :category ORDER BY date DESC',
  )
  Future<List<SymptomEntity>> getSymptomsInRangeByCategory(
    DateTime startDate,
    DateTime endDate,
    String category,
  );

  @Query(
    'SELECT * FROM symptoms WHERE date >= :startDate AND date <= :endDate AND intensity >= :minIntensity ORDER BY date DESC',
  )
  Future<List<SymptomEntity>> getSymptomsInRangeByIntensity(
    DateTime startDate,
    DateTime endDate,
    int minIntensity,
  );

  // Category-based Queries
  @Query('SELECT DISTINCT category FROM symptoms ORDER BY category')
  Future<List<String>> getAllCategories();

  @Query('SELECT * FROM symptoms WHERE category = :category ORDER BY date DESC')
  Future<List<SymptomEntity>> getSymptomsByCategory(String category);

  @Query(
    'SELECT * FROM symptoms WHERE category = :category AND date >= :startDate ORDER BY date DESC',
  )
  Future<List<SymptomEntity>> getSymptomsByCategorySince(
    String category,
    DateTime startDate,
  );

  @Query('SELECT COUNT(*) FROM symptoms WHERE category = :category')
  Future<int?> getSymptomCountByCategory(String category);

  // Symptom Name Queries
  @Query(
    'SELECT DISTINCT name FROM symptoms WHERE category = :category ORDER BY name',
  )
  Future<List<String>> getSymptomNamesByCategory(String category);

  @Query('SELECT * FROM symptoms WHERE name = :name ORDER BY date DESC')
  Future<List<SymptomEntity>> getSymptomsByName(String name);

  @Query(
    'SELECT * FROM symptoms WHERE name = :name AND date >= :startDate ORDER BY date DESC',
  )
  Future<List<SymptomEntity>> getSymptomsByNameSince(
    String name,
    DateTime startDate,
  );

  // Intensity Analysis
  @Query('SELECT AVG(intensity) FROM symptoms')
  Future<double?> getAverageSymptomIntensity();

  @Query('SELECT AVG(intensity) FROM symptoms WHERE category = :category')
  Future<double?> getAverageIntensityByCategory(String category);

  @Query('SELECT AVG(intensity) FROM symptoms WHERE name = :name')
  Future<double?> getAverageIntensityByName(String name);

  @Query(
    'SELECT AVG(intensity) FROM symptoms WHERE date >= :startDate AND date <= :endDate',
  )
  Future<double?> getAverageIntensityInRange(
    DateTime startDate,
    DateTime endDate,
  );

  @Query(
    'SELECT intensity, COUNT(*) as count FROM symptoms GROUP BY intensity ORDER BY intensity',
  )
  Future<List<Map<String, dynamic>>> getIntensityDistribution();

  // Frequency Analysis
  @Query(
    'SELECT name, COUNT(*) as frequency FROM symptoms GROUP BY name ORDER BY frequency DESC',
  )
  Future<List<Map<String, dynamic>>> getSymptomFrequency();

  @Query(
    'SELECT category, COUNT(*) as frequency FROM symptoms GROUP BY category ORDER BY frequency DESC',
  )
  Future<List<Map<String, dynamic>>> getCategoryFrequency();

  @Query(
    'SELECT name, COUNT(*) as frequency FROM symptoms WHERE date >= :startDate AND date <= :endDate GROUP BY name ORDER BY frequency DESC',
  )
  Future<List<Map<String, dynamic>>> getSymptomFrequencyInRange(
    DateTime startDate,
    DateTime endDate,
  );

  @Query(
    'SELECT name FROM symptoms GROUP BY name ORDER BY COUNT(*) DESC LIMIT 1',
  )
  Future<String?> getMostFrequentSymptom();

  @Query(
    'SELECT category FROM symptoms GROUP BY category ORDER BY COUNT(*) DESC LIMIT 1',
  )
  Future<String?> getMostFrequentCategory();

  // Recent Symptoms
  @Query(
    'SELECT * FROM symptoms ORDER BY date DESC, createdAt DESC LIMIT :limit',
  )
  Future<List<SymptomEntity>> getRecentSymptoms(int limit);

  @Query('SELECT * FROM symptoms ORDER BY createdAt DESC LIMIT 1')
  Future<SymptomEntity?> getLastSymptom();

  @Query(
    'SELECT * FROM symptoms WHERE date >= :date ORDER BY date DESC, createdAt DESC LIMIT :limit',
  )
  Future<List<SymptomEntity>> getSymptomsSince(DateTime date, int limit);

  // Statistical Queries
  @Query('SELECT COUNT(*) FROM symptoms')
  Future<int?> getSymptomsCount();

  @Query(
    'SELECT COUNT(*) FROM symptoms WHERE date >= :startDate AND date <= :endDate',
  )
  Future<int?> getSymptomsCountInRange(DateTime startDate, DateTime endDate);

  @Query('SELECT COUNT(DISTINCT name) FROM symptoms')
  Future<int?> getUniqueSymptomNamesCount();

  @Query('SELECT COUNT(DISTINCT category) FROM symptoms')
  Future<int?> getUniqueCategoriesCount();

  @Query('SELECT COUNT(DISTINCT date) FROM symptoms')
  Future<int?> getDaysWithSymptomsCount();

  // Pattern Analysis
  @Query('''SELECT 
        strftime('%w', date) as dayOfWeek,
        COUNT(*) as frequency,
        AVG(intensity) as avgIntensity
       FROM symptoms 
       WHERE date >= :startDate
       GROUP BY strftime('%w', date) 
       ORDER BY frequency DESC''')
  Future<List<Map<String, dynamic>>> getSymptomsByDayOfWeek(DateTime startDate);

  @Query('''SELECT 
        strftime('%Y-%W', date) as week,
        COUNT(*) as symptomCount,
        AVG(intensity) as avgIntensity
       FROM symptoms 
       WHERE date >= :startDate 
       GROUP BY strftime('%Y-%W', date) 
       ORDER BY week DESC''')
  Future<List<Map<String, dynamic>>> getWeeklySymptomStats(DateTime startDate);

  @Query('''SELECT 
        strftime('%Y-%m', date) as month,
        COUNT(*) as symptomCount,
        AVG(intensity) as avgIntensity
       FROM symptoms 
       WHERE date >= :startDate 
       GROUP BY strftime('%Y-%m', date) 
       ORDER BY month DESC''')
  Future<List<Map<String, dynamic>>> getMonthlySymptomStats(DateTime startDate);

  // Cycle Day Analysis (for period tracking correlation)
  @Query('''SELECT 
        (julianday(date) - julianday(:cycleStartDate)) % :cycleLength + 1 as cycleDay,
        COUNT(*) as symptomCount,
        AVG(intensity) as avgIntensity
       FROM symptoms 
       WHERE date >= :cycleStartDate
       GROUP BY cycleDay 
       ORDER BY cycleDay''')
  Future<List<Map<String, dynamic>>> getSymptomsByCycleDay(
    DateTime cycleStartDate,
    int cycleLength,
  );

  @Query('''SELECT 
        (julianday(date) - julianday(:cycleStartDate)) % :cycleLength + 1 as cycleDay,
        name,
        COUNT(*) as frequency
       FROM symptoms 
       WHERE date >= :cycleStartDate AND name = :symptomName
       GROUP BY cycleDay, name
       ORDER BY cycleDay''')
  Future<List<Map<String, dynamic>>> getSpecificSymptomByCycleDay(
    DateTime cycleStartDate,
    int cycleLength,
    String symptomName,
  );

  // Severity Analysis
  @Query('SELECT * FROM symptoms WHERE intensity >= 4 ORDER BY date DESC')
  Future<List<SymptomEntity>> getSevereSymptoms();

  @Query(
    'SELECT * FROM symptoms WHERE intensity >= :threshold AND date >= :startDate ORDER BY date DESC',
  )
  Future<List<SymptomEntity>> getSevereSymptomsInRange(
    int threshold,
    DateTime startDate,
  );

  @Query('''SELECT 
        name,
        MAX(intensity) as maxIntensity,
        AVG(intensity) as avgIntensity,
        COUNT(*) as frequency
       FROM symptoms 
       GROUP BY name 
       ORDER BY maxIntensity DESC, avgIntensity DESC''')
  Future<List<Map<String, dynamic>>> getSymptomSeverityAnalysis();

  // Notes and Description Queries
  @Query(
    'SELECT * FROM symptoms WHERE description IS NOT NULL AND description != ""',
  )
  Future<List<SymptomEntity>> getSymptomsWithDescription();

  @Query(
    'SELECT * FROM symptoms WHERE description LIKE :searchTerm ORDER BY date DESC',
  )
  Future<List<SymptomEntity>> searchSymptomsByDescription(String searchTerm);

  @Query(
    'SELECT DISTINCT description FROM symptoms WHERE description IS NOT NULL AND description != "" ORDER BY description',
  )
  Future<List<String>> getAllDescriptions();

  // Symptom Correlation Analysis
  @Query('''SELECT 
        s1.name as symptom1,
        s2.name as symptom2,
        COUNT(*) as cooccurrence
       FROM symptoms s1
       JOIN symptoms s2 ON s1.date = s2.date AND s1.name < s2.name
       WHERE s1.date >= :startDate
       GROUP BY s1.name, s2.name
       HAVING cooccurrence >= :minCooccurrence
       ORDER BY cooccurrence DESC''')
  Future<List<Map<String, dynamic>>> getSymptomCorrelations(
    DateTime startDate,
    int minCooccurrence,
  );

  @Query('SELECT DISTINCT name FROM symptoms WHERE date = :date')
  Future<List<String>> getSymptomNamesForDate(DateTime date);

  // Validation Queries
  @Query('SELECT COUNT(*) FROM symptoms WHERE date = :date')
  Future<int?> getSymptomCountForDate(DateTime date);

  @Query('SELECT EXISTS(SELECT 1 FROM symptoms WHERE date = :date LIMIT 1)')
  Future<bool?> hasSymptomForDate(DateTime date);

  @Query(
    'SELECT EXISTS(SELECT 1 FROM symptoms WHERE name = :name AND date = :date LIMIT 1)',
  )
  Future<bool?> hasSpecificSymptomForDate(String name, DateTime date);

  // Data Cleanup
  @Query('DELETE FROM symptoms WHERE date < :beforeDate')
  Future<void> deleteSymptomsBeforeDate(DateTime beforeDate);

  @Query('DELETE FROM symptoms WHERE category = :category')
  Future<void> deleteSymptomsByCategory(String category);

  @Query('DELETE FROM symptoms')
  Future<void> deleteAllSymptoms();

  // Backup/Export Queries
  @Query(
    'SELECT * FROM symptoms WHERE createdAt >= :sinceDate ORDER BY date ASC',
  )
  Future<List<SymptomEntity>> getSymptomsForBackup(DateTime sinceDate);

  @Query(
    'SELECT * FROM symptoms WHERE updatedAt >= :sinceDate ORDER BY date ASC',
  )
  Future<List<SymptomEntity>> getModifiedSymptomsSince(DateTime sinceDate);

  // Advanced Analytics
  @Query('''SELECT 
        date,
        COUNT(DISTINCT name) as uniqueSymptoms,
        AVG(intensity) as avgIntensity,
        MAX(intensity) as maxIntensity
       FROM symptoms 
       WHERE date >= :startDate
       GROUP BY date 
       ORDER BY date DESC''')
  Future<List<Map<String, dynamic>>> getDailySymptomSummary(DateTime startDate);

  @Query('''SELECT 
        category,
        name,
        AVG(intensity) as avgIntensity,
        MIN(intensity) as minIntensity,
        MAX(intensity) as maxIntensity,
        COUNT(*) as frequency,
        COUNT(DISTINCT date) as dayCount
       FROM symptoms 
       WHERE date >= :startDate AND date <= :endDate
       GROUP BY category, name
       ORDER BY category, frequency DESC''')
  Future<List<Map<String, dynamic>>> getDetailedSymptomStats(
    DateTime startDate,
    DateTime endDate,
  );

  // Trend Analysis
  @Query('''SELECT 
        date,
        name,
        intensity,
        LAG(intensity) OVER (PARTITION BY name ORDER BY date) as previousIntensity
       FROM symptoms 
       WHERE name = :symptomName AND date >= :startDate 
       ORDER BY date''')
  Future<List<Map<String, dynamic>>> getSymptomTrend(
    String symptomName,
    DateTime startDate,
  );

  // Health Insights
  @Query('''SELECT 
        category,
        COUNT(DISTINCT name) as uniqueSymptoms,
        COUNT(*) as totalOccurrences,
        AVG(intensity) as avgIntensity
       FROM symptoms 
       WHERE date >= :startDate AND date <= :endDate
       GROUP BY category
       ORDER BY totalOccurrences DESC''')
  Future<List<Map<String, dynamic>>> getCategoryInsights(
    DateTime startDate,
    DateTime endDate,
  );
}
