
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../models/period_model.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/error/exceptions.dart';

abstract class PeriodLocalDatasource {
  Future<PeriodModel> logPeriod(PeriodModel period);
  Future<List<PeriodModel>> getAllPeriods();
  Future<PeriodModel?> getPeriodById(String id);
  Future<void> updatePeriod(PeriodModel period);
  Future<void> deletePeriod(String id);
  Future<List<PeriodModel>> getPeriodsInRange(
    DateTime startDate,
    DateTime endDate,
  );
}

@LazySingleton(as: PeriodLocalDatasource)
class PeriodLocalDatasourceImpl implements PeriodLocalDatasource {
  final AppDatabase _database;

  PeriodLocalDatasourceImpl(this._database);

  @override
  Future<PeriodModel> logPeriod(PeriodModel period) async {
    try {
      final entity = period.toDatabaseEntity();
      final id = await _database.periodDao.insertPeriod(entity);

      return period.copyWith(id: id.toString());
    } catch (e) {
      throw DatabaseException(message: 'Failed to log period: $e');
    }
  }

  @override
  Future<List<PeriodModel>> getAllPeriods() async {
    try {
      final entities = await _database.periodDao.getAllPeriods();
      return entities.map((e) => PeriodModel.fromDatabaseEntity(e)).toList();
    } catch (e) {
      throw DatabaseException(message: 'Failed to get periods: $e');
    }
  }

  @override
  Future<PeriodModel?> getPeriodById(String id) async {
    try {
      final periodId = int.tryParse(id);
      if (periodId == null) return null;

      final entity = await _database.periodDao.getPeriodById(periodId);
      return entity != null ? PeriodModel.fromDatabaseEntity(entity) : null;
    } catch (e) {
      throw DatabaseException(message: 'Failed to get period: $e');
    }
  }

  @override
  Future<void> updatePeriod(PeriodModel period) async {
    try {
      final entity = period.toDatabaseEntity();
      await _database.periodDao.updatePeriod(entity);
    } catch (e) {
      throw DatabaseException(message: 'Failed to update period: $e');
    }
  }

  @override
  Future<void> deletePeriod(String id) async {
    try {
      final periodId = int.tryParse(id);
      if (periodId != null) {
        await _database.periodDao.deletePeriodById(periodId);
      }
    } catch (e) {
      throw DatabaseException(message: 'Failed to delete period: $e');
    }
  }

  @override
  Future<List<PeriodModel>> getPeriodsInRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final entities = await _database.periodDao.getPeriodsInRange(
        startDate,
        endDate,
      );
      return entities.map((e) => PeriodModel.fromDatabaseEntity(e)).toList();
    } catch (e) {
      throw DatabaseException(message: 'Failed to get periods in range: $e');
    }
  }
}
