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

  // Flow Intensity Analysis
  @Query(
    'SELECT flowIntensity, COUNT(*) as count FROM periods GROUP BY flowIntensity ORDER BY count DESC',
  )
  Future<List<Map<String, dynamic>>> getFlowIntensityDistribution();

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

  @Query(
    'SELECT MIN(cycleLength) as minCycle, MAX(cycleLength) as maxCycle, AVG(cycleLength) as avgCycle FROM periods WHERE isConfirmed = 1',
  )
  Future<Map<String, dynamic>?> getCycleLengthStats();

  @Query(
    'SELECT MIN(julianday(endDate) - julianday(startDate) + 1) as minPeriod, MAX(julianday(endDate) - julianday(startDate) + 1) as maxPeriod FROM periods WHERE endDate IS NOT NULL AND isConfirmed = 1',
  )
  Future<Map<String, dynamic>?> getPeriodLengthStats();

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
    'SELECT startDate, endDate, cycleLength FROM periods WHERE isConfirmed = 1 ORDER BY startDate DESC LIMIT :count',
  )
  Future<List<PeriodEntity>> getPeriodsForPrediction(int count);

  // Irregularity Detection
  @Query('''SELECT ABS(cycleLength - :targetLength) as deviation 
       FROM periods 
       WHERE isConfirmed = 1 AND startDate >= :sinceDate
       ORDER BY deviation DESC''')
  Future<List<int>> getCycleDeviations(int targetLength, DateTime sinceDate);

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

  // Weekly/Monthly Analysis
  @Query('''SELECT 
        strftime('%Y-%m', startDate) as month,
        COUNT(*) as periodCount,
        AVG(cycleLength) as avgCycleLength
       FROM periods 
       WHERE isConfirmed = 1 AND startDate >= :startDate 
       GROUP BY strftime('%Y-%m', startDate) 
       ORDER BY month DESC''')
  Future<List<Map<String, dynamic>>> getMonthlyPeriodStats(DateTime startDate);

  @Query('''SELECT 
        strftime('%Y', startDate) as year,
        COUNT(*) as periodCount,
        AVG(cycleLength) as avgCycleLength,
        AVG(julianday(endDate) - julianday(startDate) + 1) as avgPeriodLength
       FROM periods 
       WHERE isConfirmed = 1 AND startDate >= :startDate 
       GROUP BY strftime('%Y', startDate) 
       ORDER BY year DESC''')
  Future<List<Map<String, dynamic>>> getYearlyPeriodStats(DateTime startDate);

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

  // Calendar Integration
  @Query('''SELECT 
        startDate,
        endDate,
        flowIntensity,
        (CASE WHEN endDate IS NULL THEN 0 ELSE 1 END) as isComplete
       FROM periods 
       WHERE startDate >= :startDate AND startDate <= :endDate
       ORDER BY startDate''')
  Future<List<Map<String, dynamic>>> getPeriodsForCalendar(
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

  // Advanced Pattern Analysis
  @Query('''SELECT 
        cycleLength,
        COUNT(*) as frequency,
        AVG(julianday(endDate) - julianday(startDate) + 1) as avgPeriodLength
       FROM periods 
       WHERE isConfirmed = 1 AND endDate IS NOT NULL
       GROUP BY cycleLength 
       ORDER BY frequency DESC''')
  Future<List<Map<String, dynamic>>> getCycleLengthPatterns();

  @Query('''SELECT 
        strftime('%w', startDate) as dayOfWeek,
        COUNT(*) as frequency
       FROM periods 
       WHERE isConfirmed = 1
       GROUP BY strftime('%w', startDate) 
       ORDER BY frequency DESC''')
  Future<List<Map<String, dynamic>>> getPeriodStartDayPatterns();

  // Health Insights
  @Query('''SELECT 
        CASE 
          WHEN cycleLength < 21 THEN 'short'
          WHEN cycleLength > 35 THEN 'long'
          ELSE 'normal'
        END as cycleType,
        COUNT(*) as count
       FROM periods 
       WHERE isConfirmed = 1 AND startDate >= :sinceDate
       GROUP BY cycleType''')
  Future<List<Map<String, dynamic>>> getCycleTypeDistribution(
    DateTime sinceDate,
  );

  @Query('''SELECT 
        flowIntensity,
        AVG(julianday(endDate) - julianday(startDate) + 1) as avgDuration
       FROM periods 
       WHERE endDate IS NOT NULL AND isConfirmed = 1
       GROUP BY flowIntensity''')
  Future<List<Map<String, dynamic>>> getFlowIntensityDurationCorrelation();
}
