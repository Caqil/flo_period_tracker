import 'package:floor/floor.dart';

import '../entities/period_entity.dart';

@dao
abstract class PeriodDao {
  // Basic CRUD Operations
  @Query('SELECT * FROM periods ORDER BY startDate DESC')
  Future<List<PeriodEntity>> getAllPeriods();

  @Query('SELECT * FROM periods WHERE id = :id')
  Future<PeriodEntity?> getPeriodById(int id);

  @insert
  Future<int> insertPeriod(PeriodEntity period);

  @insert
  Future<List<int>> insertPeriods(List<PeriodEntity> periods);

  @update
  Future<void> updatePeriod(PeriodEntity period);

  @delete
  Future<void> deletePeriod(PeriodEntity period);

  @Query('DELETE FROM periods WHERE id = :id')
  Future<void> deletePeriodById(int id);

  // Date Range Queries
  @Query(
    'SELECT * FROM periods WHERE startDate >= :startDate AND startDate <= :endDate ORDER BY startDate DESC',
  )
  Future<List<PeriodEntity>> getPeriodsInRange(
    DateTime startDate,
    DateTime endDate,
  );

  @Query(
    'SELECT * FROM periods WHERE (startDate BETWEEN :startDate AND :endDate) OR (endDate BETWEEN :startDate AND :endDate) OR (startDate <= :startDate AND endDate >= :endDate) ORDER BY startDate DESC',
  )
  Future<List<PeriodEntity>> getPeriodsOverlappingRange(
    DateTime startDate,
    DateTime endDate,
  );

  // Recent and Current Period Queries
  @Query('SELECT * FROM periods ORDER BY startDate DESC LIMIT 1')
  Future<PeriodEntity?> getLastPeriod();

  @Query('SELECT * FROM periods ORDER BY startDate DESC LIMIT :limit')
  Future<List<PeriodEntity>> getRecentPeriods(int limit);

  @Query(
    'SELECT * FROM periods WHERE endDate IS NULL ORDER BY startDate DESC LIMIT 1',
  )
  Future<PeriodEntity?> getCurrentPeriod();

  @Query(
    'SELECT * FROM periods WHERE startDate <= :date AND (endDate IS NULL OR endDate >= :date) LIMIT 1',
  )
  Future<PeriodEntity?> getPeriodContainingDate(DateTime date);

  // Cycle Length Calculations
  @Query('SELECT AVG(cycleLength) FROM periods WHERE isConfirmed = 1')
  Future<double?> getAverageCycleLength();

  @Query(
    'SELECT AVG(cycleLength) FROM periods WHERE isConfirmed = 1 AND startDate >= :sinceDate',
  )
  Future<double?> getAverageCycleLengthSince(DateTime sinceDate);

  @Query(
    'SELECT AVG(julianday(endDate) - julianday(startDate) + 1) FROM periods WHERE endDate IS NOT NULL AND isConfirmed = 1',
  )
  Future<double?> getAveragePeriodLength();

  @Query(
    'SELECT AVG(julianday(endDate) - julianday(startDate) + 1) FROM periods WHERE endDate IS NOT NULL AND isConfirmed = 1 AND startDate >= :sinceDate',
  )
  Future<double?> getAveragePeriodLengthSince(DateTime sinceDate);

  // Flow Intensity Analysis - Simplified queries
  @Query(
    'SELECT flowIntensity FROM periods GROUP BY flowIntensity ORDER BY COUNT(*) DESC LIMIT 1',
  )
  Future<String?> getMostCommonFlowIntensity();

  @Query(
    'SELECT * FROM periods WHERE flowIntensity = :intensity ORDER BY startDate DESC',
  )
  Future<List<PeriodEntity>> getPeriodsByFlowIntensity(String intensity);

  // Statistical Queries
  @Query('SELECT COUNT(*) FROM periods')
  Future<int?> getPeriodsCount();

  @Query('SELECT COUNT(*) FROM periods WHERE isConfirmed = 1')
  Future<int?> getConfirmedPeriodsCount();

  @Query(
    'SELECT COUNT(*) FROM periods WHERE startDate >= :startDate AND startDate <= :endDate',
  )
  Future<int?> getPeriodsCountInRange(DateTime startDate, DateTime endDate);

  // Simplified cycle stats
  @Query('SELECT MIN(cycleLength) FROM periods WHERE isConfirmed = 1')
  Future<int?> getMinCycleLength();

  @Query('SELECT MAX(cycleLength) FROM periods WHERE isConfirmed = 1')
  Future<int?> getMaxCycleLength();

  @Query('SELECT AVG(cycleLength) FROM periods WHERE isConfirmed = 1')
  Future<double?> getAvgCycleLength();

  // Simplified period stats
  @Query(
    'SELECT MIN(julianday(endDate) - julianday(startDate) + 1) FROM periods WHERE endDate IS NOT NULL AND isConfirmed = 1',
  )
  Future<double?> getMinPeriodLength();

  @Query(
    'SELECT MAX(julianday(endDate) - julianday(startDate) + 1) FROM periods WHERE endDate IS NOT NULL AND isConfirmed = 1',
  )
  Future<double?> getMaxPeriodLength();

  // Cycle Prediction Data
  @Query(
    'SELECT cycleLength FROM periods WHERE isConfirmed = 1 ORDER BY startDate DESC LIMIT :count',
  )
  Future<List<int>> getRecentCycleLengths(int count);

  @Query(
    'SELECT julianday(endDate) - julianday(startDate) + 1 as periodLength FROM periods WHERE endDate IS NOT NULL AND isConfirmed = 1 ORDER BY startDate DESC LIMIT :count',
  )
  Future<List<double>> getRecentPeriodLengths(int count);

  @Query(
    'SELECT * FROM periods WHERE isConfirmed = 1 ORDER BY startDate DESC LIMIT :count',
  )
  Future<List<PeriodEntity>> getPeriodsForPrediction(int count);

  // Irregularity Detection - Simplified
  @Query('''SELECT COUNT(*) 
       FROM periods 
       WHERE isConfirmed = 1 
       AND ABS(cycleLength - :targetLength) > :threshold 
       AND startDate >= :sinceDate''')
  Future<int?> getIrregularCyclesCount(
    int targetLength,
    int threshold,
    DateTime sinceDate,
  );

  // Notes and Symptoms
  @Query('SELECT * FROM periods WHERE notes IS NOT NULL AND notes != ""')
  Future<List<PeriodEntity>> getPeriodsWithNotes();

  @Query(
    'SELECT * FROM periods WHERE notes LIKE :searchTerm ORDER BY startDate DESC',
  )
  Future<List<PeriodEntity>> searchPeriodsByNotes(String searchTerm);

  // Validation Queries
  @Query(
    'SELECT * FROM periods WHERE (startDate BETWEEN :startDate AND :endDate) OR (endDate BETWEEN :startDate AND :endDate) ORDER BY startDate',
  )
  Future<List<PeriodEntity>> getOverlappingPeriods(
    DateTime startDate,
    DateTime endDate,
  );

  @Query('SELECT EXISTS(SELECT 1 FROM periods WHERE startDate = :date LIMIT 1)')
  Future<bool?> hasPeriodStartingOnDate(DateTime date);

  @Query(
    'SELECT EXISTS(SELECT 1 FROM periods WHERE startDate <= :date AND (endDate IS NULL OR endDate >= :date) LIMIT 1)',
  )
  Future<bool?> isPeriodActiveOnDate(DateTime date);

  // Calendar Integration - Return entities instead of maps
  @Query('''SELECT * FROM periods 
       WHERE startDate >= :startDate AND startDate <= :endDate
       ORDER BY startDate''')
  Future<List<PeriodEntity>> getPeriodsForCalendar(
    DateTime startDate,
    DateTime endDate,
  );

  // Data Cleanup and Maintenance
  @Query('DELETE FROM periods WHERE startDate < :beforeDate')
  Future<void> deletePeriodsBeforeDate(DateTime beforeDate);

  @Query(
    'DELETE FROM periods WHERE isConfirmed = 0 AND createdAt < :beforeDate',
  )
  Future<void> deleteUnconfirmedPeriodsBeforeDate(DateTime beforeDate);

  @Query('DELETE FROM periods')
  Future<void> deleteAllPeriods();

  @Query('UPDATE periods SET isConfirmed = 1 WHERE id = :id')
  Future<void> confirmPeriod(int id);

  @Query('UPDATE periods SET isConfirmed = 0 WHERE id = :id')
  Future<void> unconfirmPeriod(int id);

  // Backup/Export Queries
  @Query(
    'SELECT * FROM periods WHERE createdAt >= :sinceDate ORDER BY startDate ASC',
  )
  Future<List<PeriodEntity>> getPeriodsForBackup(DateTime sinceDate);

  @Query(
    'SELECT * FROM periods WHERE updatedAt >= :sinceDate ORDER BY startDate ASC',
  )
  Future<List<PeriodEntity>> getModifiedPeriodsSince(DateTime sinceDate);

  // Simplified statistical queries that return counts
  @Query('SELECT COUNT(*) FROM periods WHERE flowIntensity = :intensity')
  Future<int?> getFlowIntensityCount(String intensity);

  @Query(
    'SELECT COUNT(*) FROM periods WHERE cycleLength = :length AND isConfirmed = 1',
  )
  Future<int?> getCycleLengthCount(int length);

  // Health Insights - Simplified
  @Query('''SELECT COUNT(*) FROM periods 
       WHERE isConfirmed = 1 AND startDate >= :sinceDate AND cycleLength < 21''')
  Future<int?> getShortCyclesCount(DateTime sinceDate);

  @Query('''SELECT COUNT(*) FROM periods 
       WHERE isConfirmed = 1 AND startDate >= :sinceDate AND cycleLength > 35''')
  Future<int?> getLongCyclesCount(DateTime sinceDate);

  @Query('''SELECT COUNT(*) FROM periods 
       WHERE isConfirmed = 1 AND startDate >= :sinceDate AND cycleLength >= 21 AND cycleLength <= 35''')
  Future<int?> getNormalCyclesCount(DateTime sinceDate);
}
