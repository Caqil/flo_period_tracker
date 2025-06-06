import 'package:floor/floor.dart';

import '../entities/period_entity.dart';

@dao
abstract class PeriodDao {
  @Query('SELECT * FROM periods ORDER BY startDate DESC')
  Future<List<PeriodEntity>> getAllPeriods();

  @Query(
    'SELECT * FROM periods WHERE startDate >= :startDate AND startDate <= :endDate ORDER BY startDate DESC',
  )
  Future<List<PeriodEntity>> getPeriodsInRange(
    DateTime startDate,
    DateTime endDate,
  );

  @Query('SELECT * FROM periods ORDER BY startDate DESC LIMIT 1')
  Future<PeriodEntity?> getLastPeriod();

  @Query('SELECT * FROM periods WHERE id = :id')
  Future<PeriodEntity?> getPeriodById(int id);

  @Query('SELECT AVG(cycleLength) FROM periods WHERE isConfirmed = 1')
  Future<double?> getAverageCycleLength();

  @Query(
    'SELECT AVG(julianday(endDate) - julianday(startDate) + 1) FROM periods WHERE endDate IS NOT NULL AND isConfirmed = 1',
  )
  Future<double?> getAveragePeriodLength();

  @insert
  Future<int> insertPeriod(PeriodEntity period);

  @update
  Future<void> updatePeriod(PeriodEntity period);

  @delete
  Future<void> deletePeriod(PeriodEntity period);

  @Query('DELETE FROM periods WHERE id = :id')
  Future<void> deletePeriodById(int id);

  @Query('SELECT COUNT(*) FROM periods')
  Future<int?> getPeriodsCount();
}
