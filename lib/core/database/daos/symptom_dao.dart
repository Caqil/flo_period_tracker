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

  // Frequency Analysis - Simplified queries
  @Query(
    'SELECT name FROM symptoms GROUP BY name ORDER BY COUNT(*) DESC LIMIT 1',
  )
  Future<String?> getMostFrequentSymptom();

  @Query(
    'SELECT category FROM symptoms GROUP BY category ORDER BY COUNT(*) DESC LIMIT 1',
  )
  Future<String?> getMostFrequentCategory();

  @Query('SELECT COUNT(*) FROM symptoms WHERE name = :name')
  Future<int?> getSymptomFrequencyByName(String name);

  @Query('SELECT COUNT(*) FROM symptoms WHERE category = :category')
  Future<int?> getCategoryFrequency(String category);

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

  @Query('SELECT MAX(intensity) FROM symptoms WHERE name = :name')
  Future<int?> getMaxIntensityByName(String name);

  @Query('SELECT AVG(intensity) FROM symptoms WHERE name = :name')
  Future<double?> getAvgIntensityByName(String name);

  @Query('SELECT COUNT(*) FROM symptoms WHERE name = :name')
  Future<int?> getFrequencyByName(String name);

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

  // Correlation Analysis - Simplified
  @Query('SELECT DISTINCT name FROM symptoms WHERE date = :date')
  Future<List<String>> getSymptomNamesForDate(DateTime date);

  @Query('SELECT COUNT(*) FROM symptoms WHERE date = :date AND name = :name')
  Future<int?> getSymptomCountForDateAndName(DateTime date, String name);

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

  // Advanced Analytics - Simplified individual queries
  @Query('''SELECT COUNT(DISTINCT name) FROM symptoms WHERE date = :date''')
  Future<int?> getUniqueSymptomCountForDate(DateTime date);

  @Query('''SELECT AVG(intensity) FROM symptoms WHERE date = :date''')
  Future<double?> getAvgIntensityForDate(DateTime date);

  @Query('''SELECT MAX(intensity) FROM symptoms WHERE date = :date''')
  Future<int?> getMaxIntensityForDate(DateTime date);

  // Detailed symptom stats - individual queries
  @Query('''SELECT AVG(intensity) FROM symptoms 
       WHERE date >= :startDate AND date <= :endDate AND category = :category AND name = :name''')
  Future<double?> getAvgIntensityForSymptom(
    DateTime startDate,
    DateTime endDate,
    String category,
    String name,
  );

  @Query('''SELECT MIN(intensity) FROM symptoms 
       WHERE date >= :startDate AND date <= :endDate AND category = :category AND name = :name''')
  Future<int?> getMinIntensityForSymptom(
    DateTime startDate,
    DateTime endDate,
    String category,
    String name,
  );

  @Query('''SELECT MAX(intensity) FROM symptoms 
       WHERE date >= :startDate AND date <= :endDate AND category = :category AND name = :name''')
  Future<int?> getMaxIntensityForSymptom(
    DateTime startDate,
    DateTime endDate,
    String category,
    String name,
  );

  @Query('''SELECT COUNT(*) FROM symptoms 
       WHERE date >= :startDate AND date <= :endDate AND category = :category AND name = :name''')
  Future<int?> getFrequencyForSymptom(
    DateTime startDate,
    DateTime endDate,
    String category,
    String name,
  );

  @Query('''SELECT COUNT(DISTINCT date) FROM symptoms 
       WHERE date >= :startDate AND date <= :endDate AND category = :category AND name = :name''')
  Future<int?> getDayCountForSymptom(
    DateTime startDate,
    DateTime endDate,
    String category,
    String name,
  );

  // Health Insights - Simplified individual queries
  @Query('''SELECT COUNT(DISTINCT name) FROM symptoms 
       WHERE date >= :startDate AND date <= :endDate AND category = :category''')
  Future<int?> getUniqueSymptomsByCategory(
    DateTime startDate,
    DateTime endDate,
    String category,
  );

  @Query('''SELECT COUNT(*) FROM symptoms 
       WHERE date >= :startDate AND date <= :endDate AND category = :category''')
  Future<int?> getTotalOccurrencesByCategory(
    DateTime startDate,
    DateTime endDate,
    String category,
  );

  @Query('''SELECT AVG(intensity) FROM symptoms 
       WHERE date >= :startDate AND date <= :endDate AND category = :category''')
  Future<double?> getAvgIntensityByCategory(
    DateTime startDate,
    DateTime endDate,
    String category,
  );
}
