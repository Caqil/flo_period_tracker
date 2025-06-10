// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(path, _migrations, _callback);
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  PeriodDao? _periodDaoInstance;

  SymptomDao? _symptomDaoInstance;

  MoodDao? _moodDaoInstance;

  UserDao? _userDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
          database,
          startVersion,
          endVersion,
          migrations,
        );

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
          'CREATE TABLE IF NOT EXISTS `periods` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `startDate` INTEGER NOT NULL, `endDate` INTEGER, `cycleLength` INTEGER NOT NULL, `flowIntensity` TEXT NOT NULL, `notes` TEXT, `isConfirmed` INTEGER NOT NULL, `createdAt` INTEGER NOT NULL, `updatedAt` INTEGER NOT NULL)',
        );
        await database.execute(
          'CREATE TABLE IF NOT EXISTS `symptoms` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `date` INTEGER NOT NULL, `category` TEXT NOT NULL, `name` TEXT NOT NULL, `intensity` INTEGER NOT NULL, `description` TEXT, `createdAt` INTEGER NOT NULL)',
        );
        await database.execute(
          'CREATE TABLE IF NOT EXISTS `moods` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `date` INTEGER NOT NULL, `mood` TEXT NOT NULL, `intensity` INTEGER NOT NULL, `emotions` TEXT NOT NULL, `notes` TEXT, `createdAt` INTEGER NOT NULL)',
        );
        await database.execute(
          'CREATE TABLE IF NOT EXISTS `users` (`id` TEXT NOT NULL, `email` TEXT NOT NULL, `name` TEXT, `dateOfBirth` INTEGER, `averageCycleLength` INTEGER NOT NULL, `averagePeriodLength` INTEGER NOT NULL, `lastPeriodDate` INTEGER, `isOnboardingCompleted` INTEGER NOT NULL, `profileImageUrl` TEXT, `createdAt` INTEGER NOT NULL, `updatedAt` INTEGER NOT NULL, PRIMARY KEY (`id`))',
        );

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PeriodDao get periodDao {
    return _periodDaoInstance ??= _$PeriodDao(database, changeListener);
  }

  @override
  SymptomDao get symptomDao {
    return _symptomDaoInstance ??= _$SymptomDao(database, changeListener);
  }

  @override
  MoodDao get moodDao {
    return _moodDaoInstance ??= _$MoodDao(database, changeListener);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }
}

class _$PeriodDao extends PeriodDao {
  _$PeriodDao(this.database, this.changeListener)
    : _queryAdapter = QueryAdapter(database),
      _periodEntityInsertionAdapter = InsertionAdapter(
        database,
        'periods',
        (PeriodEntity item) => <String, Object?>{
          'id': item.id,
          'startDate': _dateTimeConverter.encode(item.startDate),
          'endDate': _dateTimeNullableConverter.encode(item.endDate),
          'cycleLength': item.cycleLength,
          'flowIntensity': item.flowIntensity,
          'notes': item.notes,
          'isConfirmed': item.isConfirmed ? 1 : 0,
          'createdAt': _dateTimeConverter.encode(item.createdAt),
          'updatedAt': _dateTimeConverter.encode(item.updatedAt),
        },
      ),
      _periodEntityUpdateAdapter = UpdateAdapter(
        database,
        'periods',
        ['id'],
        (PeriodEntity item) => <String, Object?>{
          'id': item.id,
          'startDate': _dateTimeConverter.encode(item.startDate),
          'endDate': _dateTimeNullableConverter.encode(item.endDate),
          'cycleLength': item.cycleLength,
          'flowIntensity': item.flowIntensity,
          'notes': item.notes,
          'isConfirmed': item.isConfirmed ? 1 : 0,
          'createdAt': _dateTimeConverter.encode(item.createdAt),
          'updatedAt': _dateTimeConverter.encode(item.updatedAt),
        },
      ),
      _periodEntityDeletionAdapter = DeletionAdapter(
        database,
        'periods',
        ['id'],
        (PeriodEntity item) => <String, Object?>{
          'id': item.id,
          'startDate': _dateTimeConverter.encode(item.startDate),
          'endDate': _dateTimeNullableConverter.encode(item.endDate),
          'cycleLength': item.cycleLength,
          'flowIntensity': item.flowIntensity,
          'notes': item.notes,
          'isConfirmed': item.isConfirmed ? 1 : 0,
          'createdAt': _dateTimeConverter.encode(item.createdAt),
          'updatedAt': _dateTimeConverter.encode(item.updatedAt),
        },
      );

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PeriodEntity> _periodEntityInsertionAdapter;

  final UpdateAdapter<PeriodEntity> _periodEntityUpdateAdapter;

  final DeletionAdapter<PeriodEntity> _periodEntityDeletionAdapter;

  @override
  Future<List<PeriodEntity>> getAllPeriods() async {
    return _queryAdapter.queryList(
      'SELECT * FROM periods ORDER BY startDate DESC',
      mapper: (Map<String, Object?> row) => PeriodEntity(
        id: row['id'] as int?,
        startDate: _dateTimeConverter.decode(row['startDate'] as int),
        endDate: _dateTimeNullableConverter.decode(row['endDate'] as int?),
        cycleLength: row['cycleLength'] as int,
        flowIntensity: row['flowIntensity'] as String,
        notes: row['notes'] as String?,
        isConfirmed: (row['isConfirmed'] as int) != 0,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
        updatedAt: _dateTimeConverter.decode(row['updatedAt'] as int),
      ),
    );
  }

  @override
  Future<PeriodEntity?> getPeriodById(int id) async {
    return _queryAdapter.query(
      'SELECT * FROM periods WHERE id = ?1',
      mapper: (Map<String, Object?> row) => PeriodEntity(
        id: row['id'] as int?,
        startDate: _dateTimeConverter.decode(row['startDate'] as int),
        endDate: _dateTimeNullableConverter.decode(row['endDate'] as int?),
        cycleLength: row['cycleLength'] as int,
        flowIntensity: row['flowIntensity'] as String,
        notes: row['notes'] as String?,
        isConfirmed: (row['isConfirmed'] as int) != 0,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
        updatedAt: _dateTimeConverter.decode(row['updatedAt'] as int),
      ),
      arguments: [id],
    );
  }

  @override
  Future<void> deletePeriodById(int id) async {
    await _queryAdapter.queryNoReturn(
      'DELETE FROM periods WHERE id = ?1',
      arguments: [id],
    );
  }

  @override
  Future<List<PeriodEntity>> getPeriodsInRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    return _queryAdapter.queryList(
      'SELECT * FROM periods WHERE startDate >= ?1 AND startDate <= ?2 ORDER BY startDate DESC',
      mapper: (Map<String, Object?> row) => PeriodEntity(
        id: row['id'] as int?,
        startDate: _dateTimeConverter.decode(row['startDate'] as int),
        endDate: _dateTimeNullableConverter.decode(row['endDate'] as int?),
        cycleLength: row['cycleLength'] as int,
        flowIntensity: row['flowIntensity'] as String,
        notes: row['notes'] as String?,
        isConfirmed: (row['isConfirmed'] as int) != 0,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
        updatedAt: _dateTimeConverter.decode(row['updatedAt'] as int),
      ),
      arguments: [
        _dateTimeConverter.encode(startDate),
        _dateTimeConverter.encode(endDate),
      ],
    );
  }

  @override
  Future<List<PeriodEntity>> getPeriodsOverlappingRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    return _queryAdapter.queryList(
      'SELECT * FROM periods WHERE (startDate BETWEEN ?1 AND ?2) OR (endDate BETWEEN ?1 AND ?2) OR (startDate <= ?1 AND endDate >= ?2) ORDER BY startDate DESC',
      mapper: (Map<String, Object?> row) => PeriodEntity(
        id: row['id'] as int?,
        startDate: _dateTimeConverter.decode(row['startDate'] as int),
        endDate: _dateTimeNullableConverter.decode(row['endDate'] as int?),
        cycleLength: row['cycleLength'] as int,
        flowIntensity: row['flowIntensity'] as String,
        notes: row['notes'] as String?,
        isConfirmed: (row['isConfirmed'] as int) != 0,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
        updatedAt: _dateTimeConverter.decode(row['updatedAt'] as int),
      ),
      arguments: [
        _dateTimeConverter.encode(startDate),
        _dateTimeConverter.encode(endDate),
      ],
    );
  }

  @override
  Future<PeriodEntity?> getLastPeriod() async {
    return _queryAdapter.query(
      'SELECT * FROM periods ORDER BY startDate DESC LIMIT 1',
      mapper: (Map<String, Object?> row) => PeriodEntity(
        id: row['id'] as int?,
        startDate: _dateTimeConverter.decode(row['startDate'] as int),
        endDate: _dateTimeNullableConverter.decode(row['endDate'] as int?),
        cycleLength: row['cycleLength'] as int,
        flowIntensity: row['flowIntensity'] as String,
        notes: row['notes'] as String?,
        isConfirmed: (row['isConfirmed'] as int) != 0,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
        updatedAt: _dateTimeConverter.decode(row['updatedAt'] as int),
      ),
    );
  }

  @override
  Future<List<PeriodEntity>> getRecentPeriods(int limit) async {
    return _queryAdapter.queryList(
      'SELECT * FROM periods ORDER BY startDate DESC LIMIT ?1',
      mapper: (Map<String, Object?> row) => PeriodEntity(
        id: row['id'] as int?,
        startDate: _dateTimeConverter.decode(row['startDate'] as int),
        endDate: _dateTimeNullableConverter.decode(row['endDate'] as int?),
        cycleLength: row['cycleLength'] as int,
        flowIntensity: row['flowIntensity'] as String,
        notes: row['notes'] as String?,
        isConfirmed: (row['isConfirmed'] as int) != 0,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
        updatedAt: _dateTimeConverter.decode(row['updatedAt'] as int),
      ),
      arguments: [limit],
    );
  }

  @override
  Future<PeriodEntity?> getCurrentPeriod() async {
    return _queryAdapter.query(
      'SELECT * FROM periods WHERE endDate IS NULL ORDER BY startDate DESC LIMIT 1',
      mapper: (Map<String, Object?> row) => PeriodEntity(
        id: row['id'] as int?,
        startDate: _dateTimeConverter.decode(row['startDate'] as int),
        endDate: _dateTimeNullableConverter.decode(row['endDate'] as int?),
        cycleLength: row['cycleLength'] as int,
        flowIntensity: row['flowIntensity'] as String,
        notes: row['notes'] as String?,
        isConfirmed: (row['isConfirmed'] as int) != 0,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
        updatedAt: _dateTimeConverter.decode(row['updatedAt'] as int),
      ),
    );
  }

  @override
  Future<PeriodEntity?> getPeriodContainingDate(DateTime date) async {
    return _queryAdapter.query(
      'SELECT * FROM periods WHERE startDate <= ?1 AND (endDate IS NULL OR endDate >= ?1) LIMIT 1',
      mapper: (Map<String, Object?> row) => PeriodEntity(
        id: row['id'] as int?,
        startDate: _dateTimeConverter.decode(row['startDate'] as int),
        endDate: _dateTimeNullableConverter.decode(row['endDate'] as int?),
        cycleLength: row['cycleLength'] as int,
        flowIntensity: row['flowIntensity'] as String,
        notes: row['notes'] as String?,
        isConfirmed: (row['isConfirmed'] as int) != 0,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
        updatedAt: _dateTimeConverter.decode(row['updatedAt'] as int),
      ),
      arguments: [_dateTimeConverter.encode(date)],
    );
  }

  @override
  Future<double?> getAverageCycleLength() async {
    return _queryAdapter.query(
      'SELECT AVG(cycleLength) FROM periods WHERE isConfirmed = 1',
      mapper: (Map<String, Object?> row) => row.values.first as double,
    );
  }

  @override
  Future<double?> getAverageCycleLengthSince(DateTime sinceDate) async {
    return _queryAdapter.query(
      'SELECT AVG(cycleLength) FROM periods WHERE isConfirmed = 1 AND startDate >= ?1',
      mapper: (Map<String, Object?> row) => row.values.first as double,
      arguments: [_dateTimeConverter.encode(sinceDate)],
    );
  }

  @override
  Future<double?> getAveragePeriodLength() async {
    return _queryAdapter.query(
      'SELECT AVG(julianday(endDate) - julianday(startDate) + 1) FROM periods WHERE endDate IS NOT NULL AND isConfirmed = 1',
      mapper: (Map<String, Object?> row) => row.values.first as double,
    );
  }

  @override
  Future<double?> getAveragePeriodLengthSince(DateTime sinceDate) async {
    return _queryAdapter.query(
      'SELECT AVG(julianday(endDate) - julianday(startDate) + 1) FROM periods WHERE endDate IS NOT NULL AND isConfirmed = 1 AND startDate >= ?1',
      mapper: (Map<String, Object?> row) => row.values.first as double,
      arguments: [_dateTimeConverter.encode(sinceDate)],
    );
  }

  @override
  Future<String?> getMostCommonFlowIntensity() async {
    return _queryAdapter.query(
      'SELECT flowIntensity FROM periods GROUP BY flowIntensity ORDER BY COUNT(*) DESC LIMIT 1',
      mapper: (Map<String, Object?> row) => row.values.first as String,
    );
  }

  @override
  Future<List<PeriodEntity>> getPeriodsByFlowIntensity(String intensity) async {
    return _queryAdapter.queryList(
      'SELECT * FROM periods WHERE flowIntensity = ?1 ORDER BY startDate DESC',
      mapper: (Map<String, Object?> row) => PeriodEntity(
        id: row['id'] as int?,
        startDate: _dateTimeConverter.decode(row['startDate'] as int),
        endDate: _dateTimeNullableConverter.decode(row['endDate'] as int?),
        cycleLength: row['cycleLength'] as int,
        flowIntensity: row['flowIntensity'] as String,
        notes: row['notes'] as String?,
        isConfirmed: (row['isConfirmed'] as int) != 0,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
        updatedAt: _dateTimeConverter.decode(row['updatedAt'] as int),
      ),
      arguments: [intensity],
    );
  }

  @override
  Future<int?> getPeriodsCount() async {
    return _queryAdapter.query(
      'SELECT COUNT(*) FROM periods',
      mapper: (Map<String, Object?> row) => row.values.first as int,
    );
  }

  @override
  Future<int?> getConfirmedPeriodsCount() async {
    return _queryAdapter.query(
      'SELECT COUNT(*) FROM periods WHERE isConfirmed = 1',
      mapper: (Map<String, Object?> row) => row.values.first as int,
    );
  }

  @override
  Future<int?> getPeriodsCountInRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    return _queryAdapter.query(
      'SELECT COUNT(*) FROM periods WHERE startDate >= ?1 AND startDate <= ?2',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [
        _dateTimeConverter.encode(startDate),
        _dateTimeConverter.encode(endDate),
      ],
    );
  }

  @override
  Future<int?> getMinCycleLength() async {
    return _queryAdapter.query(
      'SELECT MIN(cycleLength) FROM periods WHERE isConfirmed = 1',
      mapper: (Map<String, Object?> row) => row.values.first as int,
    );
  }

  @override
  Future<int?> getMaxCycleLength() async {
    return _queryAdapter.query(
      'SELECT MAX(cycleLength) FROM periods WHERE isConfirmed = 1',
      mapper: (Map<String, Object?> row) => row.values.first as int,
    );
  }

  @override
  Future<double?> getAvgCycleLength() async {
    return _queryAdapter.query(
      'SELECT AVG(cycleLength) FROM periods WHERE isConfirmed = 1',
      mapper: (Map<String, Object?> row) => row.values.first as double,
    );
  }

  @override
  Future<double?> getMinPeriodLength() async {
    return _queryAdapter.query(
      'SELECT MIN(julianday(endDate) - julianday(startDate) + 1) FROM periods WHERE endDate IS NOT NULL AND isConfirmed = 1',
      mapper: (Map<String, Object?> row) => row.values.first as double,
    );
  }

  @override
  Future<double?> getMaxPeriodLength() async {
    return _queryAdapter.query(
      'SELECT MAX(julianday(endDate) - julianday(startDate) + 1) FROM periods WHERE endDate IS NOT NULL AND isConfirmed = 1',
      mapper: (Map<String, Object?> row) => row.values.first as double,
    );
  }

  @override
  Future<List<int>> getRecentCycleLengths(int count) async {
    return _queryAdapter.queryList(
      'SELECT cycleLength FROM periods WHERE isConfirmed = 1 ORDER BY startDate DESC LIMIT ?1',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [count],
    );
  }

  @override
  Future<List<double>> getRecentPeriodLengths(int count) async {
    return _queryAdapter.queryList(
      'SELECT julianday(endDate) - julianday(startDate) + 1 as periodLength FROM periods WHERE endDate IS NOT NULL AND isConfirmed = 1 ORDER BY startDate DESC LIMIT ?1',
      mapper: (Map<String, Object?> row) => row.values.first as double,
      arguments: [count],
    );
  }

  @override
  Future<List<PeriodEntity>> getPeriodsForPrediction(int count) async {
    return _queryAdapter.queryList(
      'SELECT * FROM periods WHERE isConfirmed = 1 ORDER BY startDate DESC LIMIT ?1',
      mapper: (Map<String, Object?> row) => PeriodEntity(
        id: row['id'] as int?,
        startDate: _dateTimeConverter.decode(row['startDate'] as int),
        endDate: _dateTimeNullableConverter.decode(row['endDate'] as int?),
        cycleLength: row['cycleLength'] as int,
        flowIntensity: row['flowIntensity'] as String,
        notes: row['notes'] as String?,
        isConfirmed: (row['isConfirmed'] as int) != 0,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
        updatedAt: _dateTimeConverter.decode(row['updatedAt'] as int),
      ),
      arguments: [count],
    );
  }

  @override
  Future<int?> getIrregularCyclesCount(
    int targetLength,
    int threshold,
    DateTime sinceDate,
  ) async {
    return _queryAdapter.query(
      'SELECT COUNT(*)         FROM periods         WHERE isConfirmed = 1         AND ABS(cycleLength - ?1) > ?2         AND startDate >= ?3',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [
        targetLength,
        threshold,
        _dateTimeConverter.encode(sinceDate),
      ],
    );
  }

  @override
  Future<List<PeriodEntity>> getPeriodsWithNotes() async {
    return _queryAdapter.queryList(
      'SELECT * FROM periods WHERE notes IS NOT NULL AND notes != \"\"',
      mapper: (Map<String, Object?> row) => PeriodEntity(
        id: row['id'] as int?,
        startDate: _dateTimeConverter.decode(row['startDate'] as int),
        endDate: _dateTimeNullableConverter.decode(row['endDate'] as int?),
        cycleLength: row['cycleLength'] as int,
        flowIntensity: row['flowIntensity'] as String,
        notes: row['notes'] as String?,
        isConfirmed: (row['isConfirmed'] as int) != 0,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
        updatedAt: _dateTimeConverter.decode(row['updatedAt'] as int),
      ),
    );
  }

  @override
  Future<List<PeriodEntity>> searchPeriodsByNotes(String searchTerm) async {
    return _queryAdapter.queryList(
      'SELECT * FROM periods WHERE notes LIKE ?1 ORDER BY startDate DESC',
      mapper: (Map<String, Object?> row) => PeriodEntity(
        id: row['id'] as int?,
        startDate: _dateTimeConverter.decode(row['startDate'] as int),
        endDate: _dateTimeNullableConverter.decode(row['endDate'] as int?),
        cycleLength: row['cycleLength'] as int,
        flowIntensity: row['flowIntensity'] as String,
        notes: row['notes'] as String?,
        isConfirmed: (row['isConfirmed'] as int) != 0,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
        updatedAt: _dateTimeConverter.decode(row['updatedAt'] as int),
      ),
      arguments: [searchTerm],
    );
  }

  @override
  Future<List<PeriodEntity>> getOverlappingPeriods(
    DateTime startDate,
    DateTime endDate,
  ) async {
    return _queryAdapter.queryList(
      'SELECT * FROM periods WHERE (startDate BETWEEN ?1 AND ?2) OR (endDate BETWEEN ?1 AND ?2) ORDER BY startDate',
      mapper: (Map<String, Object?> row) => PeriodEntity(
        id: row['id'] as int?,
        startDate: _dateTimeConverter.decode(row['startDate'] as int),
        endDate: _dateTimeNullableConverter.decode(row['endDate'] as int?),
        cycleLength: row['cycleLength'] as int,
        flowIntensity: row['flowIntensity'] as String,
        notes: row['notes'] as String?,
        isConfirmed: (row['isConfirmed'] as int) != 0,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
        updatedAt: _dateTimeConverter.decode(row['updatedAt'] as int),
      ),
      arguments: [
        _dateTimeConverter.encode(startDate),
        _dateTimeConverter.encode(endDate),
      ],
    );
  }

  @override
  Future<bool?> hasPeriodStartingOnDate(DateTime date) async {
    return _queryAdapter.query(
      'SELECT EXISTS(SELECT 1 FROM periods WHERE startDate = ?1 LIMIT 1)',
      mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
      arguments: [_dateTimeConverter.encode(date)],
    );
  }

  @override
  Future<bool?> isPeriodActiveOnDate(DateTime date) async {
    return _queryAdapter.query(
      'SELECT EXISTS(SELECT 1 FROM periods WHERE startDate <= ?1 AND (endDate IS NULL OR endDate >= ?1) LIMIT 1)',
      mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
      arguments: [_dateTimeConverter.encode(date)],
    );
  }

  @override
  Future<List<PeriodEntity>> getPeriodsForCalendar(
    DateTime startDate,
    DateTime endDate,
  ) async {
    return _queryAdapter.queryList(
      'SELECT * FROM periods         WHERE startDate >= ?1 AND startDate <= ?2        ORDER BY startDate',
      mapper: (Map<String, Object?> row) => PeriodEntity(
        id: row['id'] as int?,
        startDate: _dateTimeConverter.decode(row['startDate'] as int),
        endDate: _dateTimeNullableConverter.decode(row['endDate'] as int?),
        cycleLength: row['cycleLength'] as int,
        flowIntensity: row['flowIntensity'] as String,
        notes: row['notes'] as String?,
        isConfirmed: (row['isConfirmed'] as int) != 0,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
        updatedAt: _dateTimeConverter.decode(row['updatedAt'] as int),
      ),
      arguments: [
        _dateTimeConverter.encode(startDate),
        _dateTimeConverter.encode(endDate),
      ],
    );
  }

  @override
  Future<void> deletePeriodsBeforeDate(DateTime beforeDate) async {
    await _queryAdapter.queryNoReturn(
      'DELETE FROM periods WHERE startDate < ?1',
      arguments: [_dateTimeConverter.encode(beforeDate)],
    );
  }

  @override
  Future<void> deleteUnconfirmedPeriodsBeforeDate(DateTime beforeDate) async {
    await _queryAdapter.queryNoReturn(
      'DELETE FROM periods WHERE isConfirmed = 0 AND createdAt < ?1',
      arguments: [_dateTimeConverter.encode(beforeDate)],
    );
  }

  @override
  Future<void> deleteAllPeriods() async {
    await _queryAdapter.queryNoReturn('DELETE FROM periods');
  }

  @override
  Future<void> confirmPeriod(int id) async {
    await _queryAdapter.queryNoReturn(
      'UPDATE periods SET isConfirmed = 1 WHERE id = ?1',
      arguments: [id],
    );
  }

  @override
  Future<void> unconfirmPeriod(int id) async {
    await _queryAdapter.queryNoReturn(
      'UPDATE periods SET isConfirmed = 0 WHERE id = ?1',
      arguments: [id],
    );
  }

  @override
  Future<List<PeriodEntity>> getPeriodsForBackup(DateTime sinceDate) async {
    return _queryAdapter.queryList(
      'SELECT * FROM periods WHERE createdAt >= ?1 ORDER BY startDate ASC',
      mapper: (Map<String, Object?> row) => PeriodEntity(
        id: row['id'] as int?,
        startDate: _dateTimeConverter.decode(row['startDate'] as int),
        endDate: _dateTimeNullableConverter.decode(row['endDate'] as int?),
        cycleLength: row['cycleLength'] as int,
        flowIntensity: row['flowIntensity'] as String,
        notes: row['notes'] as String?,
        isConfirmed: (row['isConfirmed'] as int) != 0,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
        updatedAt: _dateTimeConverter.decode(row['updatedAt'] as int),
      ),
      arguments: [_dateTimeConverter.encode(sinceDate)],
    );
  }

  @override
  Future<List<PeriodEntity>> getModifiedPeriodsSince(DateTime sinceDate) async {
    return _queryAdapter.queryList(
      'SELECT * FROM periods WHERE updatedAt >= ?1 ORDER BY startDate ASC',
      mapper: (Map<String, Object?> row) => PeriodEntity(
        id: row['id'] as int?,
        startDate: _dateTimeConverter.decode(row['startDate'] as int),
        endDate: _dateTimeNullableConverter.decode(row['endDate'] as int?),
        cycleLength: row['cycleLength'] as int,
        flowIntensity: row['flowIntensity'] as String,
        notes: row['notes'] as String?,
        isConfirmed: (row['isConfirmed'] as int) != 0,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
        updatedAt: _dateTimeConverter.decode(row['updatedAt'] as int),
      ),
      arguments: [_dateTimeConverter.encode(sinceDate)],
    );
  }

  @override
  Future<int?> getFlowIntensityCount(String intensity) async {
    return _queryAdapter.query(
      'SELECT COUNT(*) FROM periods WHERE flowIntensity = ?1',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [intensity],
    );
  }

  @override
  Future<int?> getCycleLengthCount(int length) async {
    return _queryAdapter.query(
      'SELECT COUNT(*) FROM periods WHERE cycleLength = ?1 AND isConfirmed = 1',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [length],
    );
  }

  @override
  Future<int?> getShortCyclesCount(DateTime sinceDate) async {
    return _queryAdapter.query(
      'SELECT COUNT(*) FROM periods         WHERE isConfirmed = 1 AND startDate >= ?1 AND cycleLength < 21',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [_dateTimeConverter.encode(sinceDate)],
    );
  }

  @override
  Future<int?> getLongCyclesCount(DateTime sinceDate) async {
    return _queryAdapter.query(
      'SELECT COUNT(*) FROM periods         WHERE isConfirmed = 1 AND startDate >= ?1 AND cycleLength > 35',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [_dateTimeConverter.encode(sinceDate)],
    );
  }

  @override
  Future<int?> getNormalCyclesCount(DateTime sinceDate) async {
    return _queryAdapter.query(
      'SELECT COUNT(*) FROM periods         WHERE isConfirmed = 1 AND startDate >= ?1 AND cycleLength >= 21 AND cycleLength <= 35',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [_dateTimeConverter.encode(sinceDate)],
    );
  }

  @override
  Future<int> insertPeriod(PeriodEntity period) {
    return _periodEntityInsertionAdapter.insertAndReturnId(
      period,
      OnConflictStrategy.abort,
    );
  }

  @override
  Future<List<int>> insertPeriods(List<PeriodEntity> periods) {
    return _periodEntityInsertionAdapter.insertListAndReturnIds(
      periods,
      OnConflictStrategy.abort,
    );
  }

  @override
  Future<void> updatePeriod(PeriodEntity period) async {
    await _periodEntityUpdateAdapter.update(period, OnConflictStrategy.abort);
  }

  @override
  Future<void> deletePeriod(PeriodEntity period) async {
    await _periodEntityDeletionAdapter.delete(period);
  }
}

class _$SymptomDao extends SymptomDao {
  _$SymptomDao(this.database, this.changeListener)
    : _queryAdapter = QueryAdapter(database),
      _symptomEntityInsertionAdapter = InsertionAdapter(
        database,
        'symptoms',
        (SymptomEntity item) => <String, Object?>{
          'id': item.id,
          'date': _dateTimeConverter.encode(item.date),
          'category': item.category,
          'name': item.name,
          'intensity': item.intensity,
          'description': item.description,
          'createdAt': _dateTimeConverter.encode(item.createdAt),
        },
      ),
      _symptomEntityUpdateAdapter = UpdateAdapter(
        database,
        'symptoms',
        ['id'],
        (SymptomEntity item) => <String, Object?>{
          'id': item.id,
          'date': _dateTimeConverter.encode(item.date),
          'category': item.category,
          'name': item.name,
          'intensity': item.intensity,
          'description': item.description,
          'createdAt': _dateTimeConverter.encode(item.createdAt),
        },
      ),
      _symptomEntityDeletionAdapter = DeletionAdapter(
        database,
        'symptoms',
        ['id'],
        (SymptomEntity item) => <String, Object?>{
          'id': item.id,
          'date': _dateTimeConverter.encode(item.date),
          'category': item.category,
          'name': item.name,
          'intensity': item.intensity,
          'description': item.description,
          'createdAt': _dateTimeConverter.encode(item.createdAt),
        },
      );

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SymptomEntity> _symptomEntityInsertionAdapter;

  final UpdateAdapter<SymptomEntity> _symptomEntityUpdateAdapter;

  final DeletionAdapter<SymptomEntity> _symptomEntityDeletionAdapter;

  @override
  Future<List<SymptomEntity>> getAllSymptoms() async {
    return _queryAdapter.queryList(
      'SELECT * FROM symptoms ORDER BY date DESC, createdAt DESC',
      mapper: (Map<String, Object?> row) => SymptomEntity(
        id: row['id'] as int?,
        date: _dateTimeConverter.decode(row['date'] as int),
        category: row['category'] as String,
        name: row['name'] as String,
        intensity: row['intensity'] as int,
        description: row['description'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
      ),
    );
  }

  @override
  Future<SymptomEntity?> getSymptomById(int id) async {
    return _queryAdapter.query(
      'SELECT * FROM symptoms WHERE id = ?1',
      mapper: (Map<String, Object?> row) => SymptomEntity(
        id: row['id'] as int?,
        date: _dateTimeConverter.decode(row['date'] as int),
        category: row['category'] as String,
        name: row['name'] as String,
        intensity: row['intensity'] as int,
        description: row['description'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
      ),
      arguments: [id],
    );
  }

  @override
  Future<List<SymptomEntity>> getSymptomsByDate(DateTime date) async {
    return _queryAdapter.queryList(
      'SELECT * FROM symptoms WHERE date = ?1 ORDER BY createdAt DESC',
      mapper: (Map<String, Object?> row) => SymptomEntity(
        id: row['id'] as int?,
        date: _dateTimeConverter.decode(row['date'] as int),
        category: row['category'] as String,
        name: row['name'] as String,
        intensity: row['intensity'] as int,
        description: row['description'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
      ),
      arguments: [_dateTimeConverter.encode(date)],
    );
  }

  @override
  Future<void> deleteSymptomById(int id) async {
    await _queryAdapter.queryNoReturn(
      'DELETE FROM symptoms WHERE id = ?1',
      arguments: [id],
    );
  }

  @override
  Future<List<SymptomEntity>> getSymptomsInRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    return _queryAdapter.queryList(
      'SELECT * FROM symptoms WHERE date >= ?1 AND date <= ?2 ORDER BY date DESC, createdAt DESC',
      mapper: (Map<String, Object?> row) => SymptomEntity(
        id: row['id'] as int?,
        date: _dateTimeConverter.decode(row['date'] as int),
        category: row['category'] as String,
        name: row['name'] as String,
        intensity: row['intensity'] as int,
        description: row['description'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
      ),
      arguments: [
        _dateTimeConverter.encode(startDate),
        _dateTimeConverter.encode(endDate),
      ],
    );
  }

  @override
  Future<List<SymptomEntity>> getSymptomsInRangeByCategory(
    DateTime startDate,
    DateTime endDate,
    String category,
  ) async {
    return _queryAdapter.queryList(
      'SELECT * FROM symptoms WHERE date >= ?1 AND date <= ?2 AND category = ?3 ORDER BY date DESC',
      mapper: (Map<String, Object?> row) => SymptomEntity(
        id: row['id'] as int?,
        date: _dateTimeConverter.decode(row['date'] as int),
        category: row['category'] as String,
        name: row['name'] as String,
        intensity: row['intensity'] as int,
        description: row['description'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
      ),
      arguments: [
        _dateTimeConverter.encode(startDate),
        _dateTimeConverter.encode(endDate),
        category,
      ],
    );
  }

  @override
  Future<List<SymptomEntity>> getSymptomsInRangeByIntensity(
    DateTime startDate,
    DateTime endDate,
    int minIntensity,
  ) async {
    return _queryAdapter.queryList(
      'SELECT * FROM symptoms WHERE date >= ?1 AND date <= ?2 AND intensity >= ?3 ORDER BY date DESC',
      mapper: (Map<String, Object?> row) => SymptomEntity(
        id: row['id'] as int?,
        date: _dateTimeConverter.decode(row['date'] as int),
        category: row['category'] as String,
        name: row['name'] as String,
        intensity: row['intensity'] as int,
        description: row['description'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
      ),
      arguments: [
        _dateTimeConverter.encode(startDate),
        _dateTimeConverter.encode(endDate),
        minIntensity,
      ],
    );
  }

  @override
  Future<List<String>> getAllCategories() async {
    return _queryAdapter.queryList(
      'SELECT DISTINCT category FROM symptoms ORDER BY category',
      mapper: (Map<String, Object?> row) => row.values.first as String,
    );
  }

  @override
  Future<List<SymptomEntity>> getSymptomsByCategory(String category) async {
    return _queryAdapter.queryList(
      'SELECT * FROM symptoms WHERE category = ?1 ORDER BY date DESC',
      mapper: (Map<String, Object?> row) => SymptomEntity(
        id: row['id'] as int?,
        date: _dateTimeConverter.decode(row['date'] as int),
        category: row['category'] as String,
        name: row['name'] as String,
        intensity: row['intensity'] as int,
        description: row['description'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
      ),
      arguments: [category],
    );
  }

  @override
  Future<List<SymptomEntity>> getSymptomsByCategorySince(
    String category,
    DateTime startDate,
  ) async {
    return _queryAdapter.queryList(
      'SELECT * FROM symptoms WHERE category = ?1 AND date >= ?2 ORDER BY date DESC',
      mapper: (Map<String, Object?> row) => SymptomEntity(
        id: row['id'] as int?,
        date: _dateTimeConverter.decode(row['date'] as int),
        category: row['category'] as String,
        name: row['name'] as String,
        intensity: row['intensity'] as int,
        description: row['description'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
      ),
      arguments: [category, _dateTimeConverter.encode(startDate)],
    );
  }

  @override
  Future<int?> getSymptomCountByCategory(String category) async {
    return _queryAdapter.query(
      'SELECT COUNT(*) FROM symptoms WHERE category = ?1',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [category],
    );
  }

  @override
  Future<List<String>> getSymptomNamesByCategory(String category) async {
    return _queryAdapter.queryList(
      'SELECT DISTINCT name FROM symptoms WHERE category = ?1 ORDER BY name',
      mapper: (Map<String, Object?> row) => row.values.first as String,
      arguments: [category],
    );
  }

  @override
  Future<List<SymptomEntity>> getSymptomsByName(String name) async {
    return _queryAdapter.queryList(
      'SELECT * FROM symptoms WHERE name = ?1 ORDER BY date DESC',
      mapper: (Map<String, Object?> row) => SymptomEntity(
        id: row['id'] as int?,
        date: _dateTimeConverter.decode(row['date'] as int),
        category: row['category'] as String,
        name: row['name'] as String,
        intensity: row['intensity'] as int,
        description: row['description'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
      ),
      arguments: [name],
    );
  }

  @override
  Future<List<SymptomEntity>> getSymptomsByNameSince(
    String name,
    DateTime startDate,
  ) async {
    return _queryAdapter.queryList(
      'SELECT * FROM symptoms WHERE name = ?1 AND date >= ?2 ORDER BY date DESC',
      mapper: (Map<String, Object?> row) => SymptomEntity(
        id: row['id'] as int?,
        date: _dateTimeConverter.decode(row['date'] as int),
        category: row['category'] as String,
        name: row['name'] as String,
        intensity: row['intensity'] as int,
        description: row['description'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
      ),
      arguments: [name, _dateTimeConverter.encode(startDate)],
    );
  }

  @override
  Future<double?> getAverageSymptomIntensity() async {
    return _queryAdapter.query(
      'SELECT AVG(intensity) FROM symptoms',
      mapper: (Map<String, Object?> row) => row.values.first as double,
    );
  }

  @override
  Future<double?> getAverageIntensityByCategory(String category) async {
    return _queryAdapter.query(
      'SELECT AVG(intensity) FROM symptoms WHERE category = ?1',
      mapper: (Map<String, Object?> row) => row.values.first as double,
      arguments: [category],
    );
  }

  @override
  Future<double?> getAverageIntensityByName(String name) async {
    return _queryAdapter.query(
      'SELECT AVG(intensity) FROM symptoms WHERE name = ?1',
      mapper: (Map<String, Object?> row) => row.values.first as double,
      arguments: [name],
    );
  }

  @override
  Future<double?> getAverageIntensityInRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    return _queryAdapter.query(
      'SELECT AVG(intensity) FROM symptoms WHERE date >= ?1 AND date <= ?2',
      mapper: (Map<String, Object?> row) => row.values.first as double,
      arguments: [
        _dateTimeConverter.encode(startDate),
        _dateTimeConverter.encode(endDate),
      ],
    );
  }

  @override
  Future<String?> getMostFrequentSymptom() async {
    return _queryAdapter.query(
      'SELECT name FROM symptoms GROUP BY name ORDER BY COUNT(*) DESC LIMIT 1',
      mapper: (Map<String, Object?> row) => row.values.first as String,
    );
  }

  @override
  Future<String?> getMostFrequentCategory() async {
    return _queryAdapter.query(
      'SELECT category FROM symptoms GROUP BY category ORDER BY COUNT(*) DESC LIMIT 1',
      mapper: (Map<String, Object?> row) => row.values.first as String,
    );
  }

  @override
  Future<int?> getSymptomFrequencyByName(String name) async {
    return _queryAdapter.query(
      'SELECT COUNT(*) FROM symptoms WHERE name = ?1',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [name],
    );
  }

  @override
  Future<int?> getCategoryFrequency(String category) async {
    return _queryAdapter.query(
      'SELECT COUNT(*) FROM symptoms WHERE category = ?1',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [category],
    );
  }

  @override
  Future<List<SymptomEntity>> getRecentSymptoms(int limit) async {
    return _queryAdapter.queryList(
      'SELECT * FROM symptoms ORDER BY date DESC, createdAt DESC LIMIT ?1',
      mapper: (Map<String, Object?> row) => SymptomEntity(
        id: row['id'] as int?,
        date: _dateTimeConverter.decode(row['date'] as int),
        category: row['category'] as String,
        name: row['name'] as String,
        intensity: row['intensity'] as int,
        description: row['description'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
      ),
      arguments: [limit],
    );
  }

  @override
  Future<SymptomEntity?> getLastSymptom() async {
    return _queryAdapter.query(
      'SELECT * FROM symptoms ORDER BY createdAt DESC LIMIT 1',
      mapper: (Map<String, Object?> row) => SymptomEntity(
        id: row['id'] as int?,
        date: _dateTimeConverter.decode(row['date'] as int),
        category: row['category'] as String,
        name: row['name'] as String,
        intensity: row['intensity'] as int,
        description: row['description'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
      ),
    );
  }

  @override
  Future<List<SymptomEntity>> getSymptomsSince(DateTime date, int limit) async {
    return _queryAdapter.queryList(
      'SELECT * FROM symptoms WHERE date >= ?1 ORDER BY date DESC, createdAt DESC LIMIT ?2',
      mapper: (Map<String, Object?> row) => SymptomEntity(
        id: row['id'] as int?,
        date: _dateTimeConverter.decode(row['date'] as int),
        category: row['category'] as String,
        name: row['name'] as String,
        intensity: row['intensity'] as int,
        description: row['description'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
      ),
      arguments: [_dateTimeConverter.encode(date), limit],
    );
  }

  @override
  Future<int?> getSymptomsCount() async {
    return _queryAdapter.query(
      'SELECT COUNT(*) FROM symptoms',
      mapper: (Map<String, Object?> row) => row.values.first as int,
    );
  }

  @override
  Future<int?> getSymptomsCountInRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    return _queryAdapter.query(
      'SELECT COUNT(*) FROM symptoms WHERE date >= ?1 AND date <= ?2',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [
        _dateTimeConverter.encode(startDate),
        _dateTimeConverter.encode(endDate),
      ],
    );
  }

  @override
  Future<int?> getUniqueSymptomNamesCount() async {
    return _queryAdapter.query(
      'SELECT COUNT(DISTINCT name) FROM symptoms',
      mapper: (Map<String, Object?> row) => row.values.first as int,
    );
  }

  @override
  Future<int?> getUniqueCategoriesCount() async {
    return _queryAdapter.query(
      'SELECT COUNT(DISTINCT category) FROM symptoms',
      mapper: (Map<String, Object?> row) => row.values.first as int,
    );
  }

  @override
  Future<int?> getDaysWithSymptomsCount() async {
    return _queryAdapter.query(
      'SELECT COUNT(DISTINCT date) FROM symptoms',
      mapper: (Map<String, Object?> row) => row.values.first as int,
    );
  }

  @override
  Future<List<SymptomEntity>> getSevereSymptoms() async {
    return _queryAdapter.queryList(
      'SELECT * FROM symptoms WHERE intensity >= 4 ORDER BY date DESC',
      mapper: (Map<String, Object?> row) => SymptomEntity(
        id: row['id'] as int?,
        date: _dateTimeConverter.decode(row['date'] as int),
        category: row['category'] as String,
        name: row['name'] as String,
        intensity: row['intensity'] as int,
        description: row['description'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
      ),
    );
  }

  @override
  Future<List<SymptomEntity>> getSevereSymptomsInRange(
    int threshold,
    DateTime startDate,
  ) async {
    return _queryAdapter.queryList(
      'SELECT * FROM symptoms WHERE intensity >= ?1 AND date >= ?2 ORDER BY date DESC',
      mapper: (Map<String, Object?> row) => SymptomEntity(
        id: row['id'] as int?,
        date: _dateTimeConverter.decode(row['date'] as int),
        category: row['category'] as String,
        name: row['name'] as String,
        intensity: row['intensity'] as int,
        description: row['description'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
      ),
      arguments: [threshold, _dateTimeConverter.encode(startDate)],
    );
  }

  @override
  Future<int?> getMaxIntensityByName(String name) async {
    return _queryAdapter.query(
      'SELECT MAX(intensity) FROM symptoms WHERE name = ?1',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [name],
    );
  }

  @override
  Future<double?> getAvgIntensityByName(String name) async {
    return _queryAdapter.query(
      'SELECT AVG(intensity) FROM symptoms WHERE name = ?1',
      mapper: (Map<String, Object?> row) => row.values.first as double,
      arguments: [name],
    );
  }

  @override
  Future<int?> getFrequencyByName(String name) async {
    return _queryAdapter.query(
      'SELECT COUNT(*) FROM symptoms WHERE name = ?1',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [name],
    );
  }

  @override
  Future<List<SymptomEntity>> getSymptomsWithDescription() async {
    return _queryAdapter.queryList(
      'SELECT * FROM symptoms WHERE description IS NOT NULL AND description != \"\"',
      mapper: (Map<String, Object?> row) => SymptomEntity(
        id: row['id'] as int?,
        date: _dateTimeConverter.decode(row['date'] as int),
        category: row['category'] as String,
        name: row['name'] as String,
        intensity: row['intensity'] as int,
        description: row['description'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
      ),
    );
  }

  @override
  Future<List<SymptomEntity>> searchSymptomsByDescription(
    String searchTerm,
  ) async {
    return _queryAdapter.queryList(
      'SELECT * FROM symptoms WHERE description LIKE ?1 ORDER BY date DESC',
      mapper: (Map<String, Object?> row) => SymptomEntity(
        id: row['id'] as int?,
        date: _dateTimeConverter.decode(row['date'] as int),
        category: row['category'] as String,
        name: row['name'] as String,
        intensity: row['intensity'] as int,
        description: row['description'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
      ),
      arguments: [searchTerm],
    );
  }

  @override
  Future<List<String>> getAllDescriptions() async {
    return _queryAdapter.queryList(
      'SELECT DISTINCT description FROM symptoms WHERE description IS NOT NULL AND description != \"\" ORDER BY description',
      mapper: (Map<String, Object?> row) => row.values.first as String,
    );
  }

  @override
  Future<List<String>> getSymptomNamesForDate(DateTime date) async {
    return _queryAdapter.queryList(
      'SELECT DISTINCT name FROM symptoms WHERE date = ?1',
      mapper: (Map<String, Object?> row) => row.values.first as String,
      arguments: [_dateTimeConverter.encode(date)],
    );
  }

  @override
  Future<int?> getSymptomCountForDateAndName(DateTime date, String name) async {
    return _queryAdapter.query(
      'SELECT COUNT(*) FROM symptoms WHERE date = ?1 AND name = ?2',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [_dateTimeConverter.encode(date), name],
    );
  }

  @override
  Future<int?> getSymptomCountForDate(DateTime date) async {
    return _queryAdapter.query(
      'SELECT COUNT(*) FROM symptoms WHERE date = ?1',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [_dateTimeConverter.encode(date)],
    );
  }

  @override
  Future<bool?> hasSymptomForDate(DateTime date) async {
    return _queryAdapter.query(
      'SELECT EXISTS(SELECT 1 FROM symptoms WHERE date = ?1 LIMIT 1)',
      mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
      arguments: [_dateTimeConverter.encode(date)],
    );
  }

  @override
  Future<bool?> hasSpecificSymptomForDate(String name, DateTime date) async {
    return _queryAdapter.query(
      'SELECT EXISTS(SELECT 1 FROM symptoms WHERE name = ?1 AND date = ?2 LIMIT 1)',
      mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
      arguments: [name, _dateTimeConverter.encode(date)],
    );
  }

  @override
  Future<void> deleteSymptomsBeforeDate(DateTime beforeDate) async {
    await _queryAdapter.queryNoReturn(
      'DELETE FROM symptoms WHERE date < ?1',
      arguments: [_dateTimeConverter.encode(beforeDate)],
    );
  }

  @override
  Future<void> deleteSymptomsByCategory(String category) async {
    await _queryAdapter.queryNoReturn(
      'DELETE FROM symptoms WHERE category = ?1',
      arguments: [category],
    );
  }

  @override
  Future<void> deleteAllSymptoms() async {
    await _queryAdapter.queryNoReturn('DELETE FROM symptoms');
  }

  @override
  Future<List<SymptomEntity>> getSymptomsForBackup(DateTime sinceDate) async {
    return _queryAdapter.queryList(
      'SELECT * FROM symptoms WHERE createdAt >= ?1 ORDER BY date ASC',
      mapper: (Map<String, Object?> row) => SymptomEntity(
        id: row['id'] as int?,
        date: _dateTimeConverter.decode(row['date'] as int),
        category: row['category'] as String,
        name: row['name'] as String,
        intensity: row['intensity'] as int,
        description: row['description'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
      ),
      arguments: [_dateTimeConverter.encode(sinceDate)],
    );
  }

  @override
  Future<List<SymptomEntity>> getModifiedSymptomsSince(
    DateTime sinceDate,
  ) async {
    return _queryAdapter.queryList(
      'SELECT * FROM symptoms WHERE updatedAt >= ?1 ORDER BY date ASC',
      mapper: (Map<String, Object?> row) => SymptomEntity(
        id: row['id'] as int?,
        date: _dateTimeConverter.decode(row['date'] as int),
        category: row['category'] as String,
        name: row['name'] as String,
        intensity: row['intensity'] as int,
        description: row['description'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
      ),
      arguments: [_dateTimeConverter.encode(sinceDate)],
    );
  }

  @override
  Future<int?> getUniqueSymptomCountForDate(DateTime date) async {
    return _queryAdapter.query(
      'SELECT COUNT(DISTINCT name) FROM symptoms WHERE date = ?1',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [_dateTimeConverter.encode(date)],
    );
  }

  @override
  Future<double?> getAvgIntensityForDate(DateTime date) async {
    return _queryAdapter.query(
      'SELECT AVG(intensity) FROM symptoms WHERE date = ?1',
      mapper: (Map<String, Object?> row) => row.values.first as double,
      arguments: [_dateTimeConverter.encode(date)],
    );
  }

  @override
  Future<int?> getMaxIntensityForDate(DateTime date) async {
    return _queryAdapter.query(
      'SELECT MAX(intensity) FROM symptoms WHERE date = ?1',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [_dateTimeConverter.encode(date)],
    );
  }

  @override
  Future<double?> getAvgIntensityForSymptom(
    DateTime startDate,
    DateTime endDate,
    String category,
    String name,
  ) async {
    return _queryAdapter.query(
      'SELECT AVG(intensity) FROM symptoms         WHERE date >= ?1 AND date <= ?2 AND category = ?3 AND name = ?4',
      mapper: (Map<String, Object?> row) => row.values.first as double,
      arguments: [
        _dateTimeConverter.encode(startDate),
        _dateTimeConverter.encode(endDate),
        category,
        name,
      ],
    );
  }

  @override
  Future<int?> getMinIntensityForSymptom(
    DateTime startDate,
    DateTime endDate,
    String category,
    String name,
  ) async {
    return _queryAdapter.query(
      'SELECT MIN(intensity) FROM symptoms         WHERE date >= ?1 AND date <= ?2 AND category = ?3 AND name = ?4',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [
        _dateTimeConverter.encode(startDate),
        _dateTimeConverter.encode(endDate),
        category,
        name,
      ],
    );
  }

  @override
  Future<int?> getMaxIntensityForSymptom(
    DateTime startDate,
    DateTime endDate,
    String category,
    String name,
  ) async {
    return _queryAdapter.query(
      'SELECT MAX(intensity) FROM symptoms         WHERE date >= ?1 AND date <= ?2 AND category = ?3 AND name = ?4',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [
        _dateTimeConverter.encode(startDate),
        _dateTimeConverter.encode(endDate),
        category,
        name,
      ],
    );
  }

  @override
  Future<int?> getFrequencyForSymptom(
    DateTime startDate,
    DateTime endDate,
    String category,
    String name,
  ) async {
    return _queryAdapter.query(
      'SELECT COUNT(*) FROM symptoms         WHERE date >= ?1 AND date <= ?2 AND category = ?3 AND name = ?4',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [
        _dateTimeConverter.encode(startDate),
        _dateTimeConverter.encode(endDate),
        category,
        name,
      ],
    );
  }

  @override
  Future<int?> getDayCountForSymptom(
    DateTime startDate,
    DateTime endDate,
    String category,
    String name,
  ) async {
    return _queryAdapter.query(
      'SELECT COUNT(DISTINCT date) FROM symptoms         WHERE date >= ?1 AND date <= ?2 AND category = ?3 AND name = ?4',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [
        _dateTimeConverter.encode(startDate),
        _dateTimeConverter.encode(endDate),
        category,
        name,
      ],
    );
  }

  @override
  Future<int?> getUniqueSymptomsByCategory(
    DateTime startDate,
    DateTime endDate,
    String category,
  ) async {
    return _queryAdapter.query(
      'SELECT COUNT(DISTINCT name) FROM symptoms         WHERE date >= ?1 AND date <= ?2 AND category = ?3',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [
        _dateTimeConverter.encode(startDate),
        _dateTimeConverter.encode(endDate),
        category,
      ],
    );
  }

  @override
  Future<int?> getTotalOccurrencesByCategory(
    DateTime startDate,
    DateTime endDate,
    String category,
  ) async {
    return _queryAdapter.query(
      'SELECT COUNT(*) FROM symptoms         WHERE date >= ?1 AND date <= ?2 AND category = ?3',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [
        _dateTimeConverter.encode(startDate),
        _dateTimeConverter.encode(endDate),
        category,
      ],
    );
  }

  @override
  Future<double?> getAvgIntensityByCategory(
    DateTime startDate,
    DateTime endDate,
    String category,
  ) async {
    return _queryAdapter.query(
      'SELECT AVG(intensity) FROM symptoms         WHERE date >= ?1 AND date <= ?2 AND category = ?3',
      mapper: (Map<String, Object?> row) => row.values.first as double,
      arguments: [
        _dateTimeConverter.encode(startDate),
        _dateTimeConverter.encode(endDate),
        category,
      ],
    );
  }

  @override
  Future<int> insertSymptom(SymptomEntity symptom) {
    return _symptomEntityInsertionAdapter.insertAndReturnId(
      symptom,
      OnConflictStrategy.abort,
    );
  }

  @override
  Future<List<int>> insertSymptoms(List<SymptomEntity> symptoms) {
    return _symptomEntityInsertionAdapter.insertListAndReturnIds(
      symptoms,
      OnConflictStrategy.abort,
    );
  }

  @override
  Future<void> updateSymptom(SymptomEntity symptom) async {
    await _symptomEntityUpdateAdapter.update(symptom, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteSymptom(SymptomEntity symptom) async {
    await _symptomEntityDeletionAdapter.delete(symptom);
  }
}

class _$MoodDao extends MoodDao {
  _$MoodDao(this.database, this.changeListener)
    : _queryAdapter = QueryAdapter(database),
      _moodEntityInsertionAdapter = InsertionAdapter(
        database,
        'moods',
        (MoodEntity item) => <String, Object?>{
          'id': item.id,
          'date': _dateTimeConverter.encode(item.date),
          'mood': item.mood,
          'intensity': item.intensity,
          'emotions': item.emotions,
          'notes': item.notes,
          'createdAt': _dateTimeConverter.encode(item.createdAt),
        },
      ),
      _moodEntityUpdateAdapter = UpdateAdapter(
        database,
        'moods',
        ['id'],
        (MoodEntity item) => <String, Object?>{
          'id': item.id,
          'date': _dateTimeConverter.encode(item.date),
          'mood': item.mood,
          'intensity': item.intensity,
          'emotions': item.emotions,
          'notes': item.notes,
          'createdAt': _dateTimeConverter.encode(item.createdAt),
        },
      ),
      _moodEntityDeletionAdapter = DeletionAdapter(
        database,
        'moods',
        ['id'],
        (MoodEntity item) => <String, Object?>{
          'id': item.id,
          'date': _dateTimeConverter.encode(item.date),
          'mood': item.mood,
          'intensity': item.intensity,
          'emotions': item.emotions,
          'notes': item.notes,
          'createdAt': _dateTimeConverter.encode(item.createdAt),
        },
      );

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MoodEntity> _moodEntityInsertionAdapter;

  final UpdateAdapter<MoodEntity> _moodEntityUpdateAdapter;

  final DeletionAdapter<MoodEntity> _moodEntityDeletionAdapter;

  @override
  Future<List<MoodEntity>> getAllMoods() async {
    return _queryAdapter.queryList(
      'SELECT * FROM moods ORDER BY date DESC',
      mapper: (Map<String, Object?> row) => MoodEntity(
        id: row['id'] as int?,
        date: _dateTimeConverter.decode(row['date'] as int),
        mood: row['mood'] as String,
        intensity: row['intensity'] as int,
        emotions: row['emotions'] as String,
        notes: row['notes'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
      ),
    );
  }

  @override
  Future<MoodEntity?> getMoodById(int id) async {
    return _queryAdapter.query(
      'SELECT * FROM moods WHERE id = ?1',
      mapper: (Map<String, Object?> row) => MoodEntity(
        id: row['id'] as int?,
        date: _dateTimeConverter.decode(row['date'] as int),
        mood: row['mood'] as String,
        intensity: row['intensity'] as int,
        emotions: row['emotions'] as String,
        notes: row['notes'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
      ),
      arguments: [id],
    );
  }

  @override
  Future<MoodEntity?> getMoodByDate(DateTime date) async {
    return _queryAdapter.query(
      'SELECT * FROM moods WHERE date = ?1 ORDER BY createdAt DESC LIMIT 1',
      mapper: (Map<String, Object?> row) => MoodEntity(
        id: row['id'] as int?,
        date: _dateTimeConverter.decode(row['date'] as int),
        mood: row['mood'] as String,
        intensity: row['intensity'] as int,
        emotions: row['emotions'] as String,
        notes: row['notes'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
      ),
      arguments: [_dateTimeConverter.encode(date)],
    );
  }

  @override
  Future<void> deleteMoodById(int id) async {
    await _queryAdapter.queryNoReturn(
      'DELETE FROM moods WHERE id = ?1',
      arguments: [id],
    );
  }

  @override
  Future<List<MoodEntity>> getMoodsInRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    return _queryAdapter.queryList(
      'SELECT * FROM moods WHERE date >= ?1 AND date <= ?2 ORDER BY date DESC',
      mapper: (Map<String, Object?> row) => MoodEntity(
        id: row['id'] as int?,
        date: _dateTimeConverter.decode(row['date'] as int),
        mood: row['mood'] as String,
        intensity: row['intensity'] as int,
        emotions: row['emotions'] as String,
        notes: row['notes'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
      ),
      arguments: [
        _dateTimeConverter.encode(startDate),
        _dateTimeConverter.encode(endDate),
      ],
    );
  }

  @override
  Future<List<MoodEntity>> getMoodsInRangeByType(
    DateTime startDate,
    DateTime endDate,
    String moodType,
  ) async {
    return _queryAdapter.queryList(
      'SELECT * FROM moods WHERE date >= ?1 AND date <= ?2 AND mood = ?3 ORDER BY date DESC',
      mapper: (Map<String, Object?> row) => MoodEntity(
        id: row['id'] as int?,
        date: _dateTimeConverter.decode(row['date'] as int),
        mood: row['mood'] as String,
        intensity: row['intensity'] as int,
        emotions: row['emotions'] as String,
        notes: row['notes'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
      ),
      arguments: [
        _dateTimeConverter.encode(startDate),
        _dateTimeConverter.encode(endDate),
        moodType,
      ],
    );
  }

  @override
  Future<List<MoodEntity>> getMoodsInRangeByIntensity(
    DateTime startDate,
    DateTime endDate,
    int minIntensity,
  ) async {
    return _queryAdapter.queryList(
      'SELECT * FROM moods WHERE date >= ?1 AND date <= ?2 AND intensity >= ?3 ORDER BY date DESC',
      mapper: (Map<String, Object?> row) => MoodEntity(
        id: row['id'] as int?,
        date: _dateTimeConverter.decode(row['date'] as int),
        mood: row['mood'] as String,
        intensity: row['intensity'] as int,
        emotions: row['emotions'] as String,
        notes: row['notes'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
      ),
      arguments: [
        _dateTimeConverter.encode(startDate),
        _dateTimeConverter.encode(endDate),
        minIntensity,
      ],
    );
  }

  @override
  Future<List<MoodEntity>> getRecentMoods(int limit) async {
    return _queryAdapter.queryList(
      'SELECT * FROM moods ORDER BY date DESC LIMIT ?1',
      mapper: (Map<String, Object?> row) => MoodEntity(
        id: row['id'] as int?,
        date: _dateTimeConverter.decode(row['date'] as int),
        mood: row['mood'] as String,
        intensity: row['intensity'] as int,
        emotions: row['emotions'] as String,
        notes: row['notes'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
      ),
      arguments: [limit],
    );
  }

  @override
  Future<MoodEntity?> getLastMood() async {
    return _queryAdapter.query(
      'SELECT * FROM moods ORDER BY createdAt DESC LIMIT 1',
      mapper: (Map<String, Object?> row) => MoodEntity(
        id: row['id'] as int?,
        date: _dateTimeConverter.decode(row['date'] as int),
        mood: row['mood'] as String,
        intensity: row['intensity'] as int,
        emotions: row['emotions'] as String,
        notes: row['notes'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
      ),
    );
  }

  @override
  Future<List<MoodEntity>> getMoodsSince(DateTime date, int limit) async {
    return _queryAdapter.queryList(
      'SELECT * FROM moods WHERE date >= ?1 ORDER BY date DESC LIMIT ?2',
      mapper: (Map<String, Object?> row) => MoodEntity(
        id: row['id'] as int?,
        date: _dateTimeConverter.decode(row['date'] as int),
        mood: row['mood'] as String,
        intensity: row['intensity'] as int,
        emotions: row['emotions'] as String,
        notes: row['notes'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
      ),
      arguments: [_dateTimeConverter.encode(date), limit],
    );
  }

  @override
  Future<int?> getMoodsCount() async {
    return _queryAdapter.query(
      'SELECT COUNT(*) FROM moods',
      mapper: (Map<String, Object?> row) => row.values.first as int,
    );
  }

  @override
  Future<int?> getMoodsCountInRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    return _queryAdapter.query(
      'SELECT COUNT(*) FROM moods WHERE date >= ?1 AND date <= ?2',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [
        _dateTimeConverter.encode(startDate),
        _dateTimeConverter.encode(endDate),
      ],
    );
  }

  @override
  Future<double?> getAverageMoodIntensity() async {
    return _queryAdapter.query(
      'SELECT AVG(intensity) FROM moods',
      mapper: (Map<String, Object?> row) => row.values.first as double,
    );
  }

  @override
  Future<double?> getAverageMoodIntensityInRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    return _queryAdapter.query(
      'SELECT AVG(intensity) FROM moods WHERE date >= ?1 AND date <= ?2',
      mapper: (Map<String, Object?> row) => row.values.first as double,
      arguments: [
        _dateTimeConverter.encode(startDate),
        _dateTimeConverter.encode(endDate),
      ],
    );
  }

  @override
  Future<double?> getAverageIntensityByMoodType(String moodType) async {
    return _queryAdapter.query(
      'SELECT AVG(intensity) FROM moods WHERE mood = ?1',
      mapper: (Map<String, Object?> row) => row.values.first as double,
      arguments: [moodType],
    );
  }

  @override
  Future<String?> getMostFrequentMood() async {
    return _queryAdapter.query(
      'SELECT mood FROM moods GROUP BY mood ORDER BY COUNT(*) DESC LIMIT 1',
      mapper: (Map<String, Object?> row) => row.values.first as String,
    );
  }

  @override
  Future<String?> getMostFrequentMoodInRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    return _queryAdapter.query(
      'SELECT mood FROM moods WHERE date >= ?1 AND date <= ?2 GROUP BY mood ORDER BY COUNT(*) DESC LIMIT 1',
      mapper: (Map<String, Object?> row) => row.values.first as String,
      arguments: [
        _dateTimeConverter.encode(startDate),
        _dateTimeConverter.encode(endDate),
      ],
    );
  }

  @override
  Future<int?> getMoodFrequencyByType(String moodType) async {
    return _queryAdapter.query(
      'SELECT COUNT(*) FROM moods WHERE mood = ?1',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [moodType],
    );
  }

  @override
  Future<int?> getMoodFrequencyByTypeInRange(
    DateTime startDate,
    DateTime endDate,
    String moodType,
  ) async {
    return _queryAdapter.query(
      'SELECT COUNT(*) FROM moods WHERE date >= ?1 AND date <= ?2 AND mood = ?3',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [
        _dateTimeConverter.encode(startDate),
        _dateTimeConverter.encode(endDate),
        moodType,
      ],
    );
  }

  @override
  Future<int?> getIntensityCount(int intensity) async {
    return _queryAdapter.query(
      'SELECT COUNT(*) FROM moods WHERE intensity = ?1',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [intensity],
    );
  }

  @override
  Future<List<MoodEntity>> getMoodsByEmotion(String emotion) async {
    return _queryAdapter.queryList(
      'SELECT * FROM moods WHERE emotions LIKE ?1 ORDER BY date DESC',
      mapper: (Map<String, Object?> row) => MoodEntity(
        id: row['id'] as int?,
        date: _dateTimeConverter.decode(row['date'] as int),
        mood: row['mood'] as String,
        intensity: row['intensity'] as int,
        emotions: row['emotions'] as String,
        notes: row['notes'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
      ),
      arguments: [emotion],
    );
  }

  @override
  Future<int?> getEmotionFrequency(String emotion) async {
    return _queryAdapter.query(
      'SELECT COUNT(*) FROM moods WHERE emotions LIKE ?1',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [emotion],
    );
  }

  @override
  Future<double?> getAvgIntensityInPeriod(
    DateTime startDate,
    DateTime endDate,
  ) async {
    return _queryAdapter.query(
      'SELECT AVG(intensity) FROM moods         WHERE date >= ?1 AND date <= ?2',
      mapper: (Map<String, Object?> row) => row.values.first as double,
      arguments: [
        _dateTimeConverter.encode(startDate),
        _dateTimeConverter.encode(endDate),
      ],
    );
  }

  @override
  Future<int?> getMoodCountInPeriod(
    DateTime startDate,
    DateTime endDate,
  ) async {
    return _queryAdapter.query(
      'SELECT COUNT(*) FROM moods         WHERE date >= ?1 AND date <= ?2',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [
        _dateTimeConverter.encode(startDate),
        _dateTimeConverter.encode(endDate),
      ],
    );
  }

  @override
  Future<List<MoodEntity>> getMoodsWithNotes() async {
    return _queryAdapter.queryList(
      'SELECT * FROM moods WHERE notes IS NOT NULL AND notes != \"\"',
      mapper: (Map<String, Object?> row) => MoodEntity(
        id: row['id'] as int?,
        date: _dateTimeConverter.decode(row['date'] as int),
        mood: row['mood'] as String,
        intensity: row['intensity'] as int,
        emotions: row['emotions'] as String,
        notes: row['notes'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
      ),
    );
  }

  @override
  Future<List<MoodEntity>> searchMoodsByNotes(String searchTerm) async {
    return _queryAdapter.queryList(
      'SELECT * FROM moods WHERE notes LIKE ?1 ORDER BY date DESC',
      mapper: (Map<String, Object?> row) => MoodEntity(
        id: row['id'] as int?,
        date: _dateTimeConverter.decode(row['date'] as int),
        mood: row['mood'] as String,
        intensity: row['intensity'] as int,
        emotions: row['emotions'] as String,
        notes: row['notes'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
      ),
      arguments: [searchTerm],
    );
  }

  @override
  Future<int?> getMoodsWithNotesCount() async {
    return _queryAdapter.query(
      'SELECT COUNT(*) FROM moods WHERE notes IS NOT NULL AND notes != \"\"',
      mapper: (Map<String, Object?> row) => row.values.first as int,
    );
  }

  @override
  Future<void> deleteMoodsBeforeDate(DateTime beforeDate) async {
    await _queryAdapter.queryNoReturn(
      'DELETE FROM moods WHERE date < ?1',
      arguments: [_dateTimeConverter.encode(beforeDate)],
    );
  }

  @override
  Future<void> deleteAllMoods() async {
    await _queryAdapter.queryNoReturn('DELETE FROM moods');
  }

  @override
  Future<List<MoodEntity>> getMoodsForBackup(DateTime sinceDate) async {
    return _queryAdapter.queryList(
      'SELECT * FROM moods WHERE createdAt >= ?1 ORDER BY date ASC',
      mapper: (Map<String, Object?> row) => MoodEntity(
        id: row['id'] as int?,
        date: _dateTimeConverter.decode(row['date'] as int),
        mood: row['mood'] as String,
        intensity: row['intensity'] as int,
        emotions: row['emotions'] as String,
        notes: row['notes'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
      ),
      arguments: [_dateTimeConverter.encode(sinceDate)],
    );
  }

  @override
  Future<List<MoodEntity>> getModifiedMoodsSince(DateTime sinceDate) async {
    return _queryAdapter.queryList(
      'SELECT * FROM moods WHERE updatedAt >= ?1 ORDER BY date ASC',
      mapper: (Map<String, Object?> row) => MoodEntity(
        id: row['id'] as int?,
        date: _dateTimeConverter.decode(row['date'] as int),
        mood: row['mood'] as String,
        intensity: row['intensity'] as int,
        emotions: row['emotions'] as String,
        notes: row['notes'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
      ),
      arguments: [_dateTimeConverter.encode(sinceDate)],
    );
  }

  @override
  Future<int?> getMoodCountForDate(DateTime date) async {
    return _queryAdapter.query(
      'SELECT COUNT(*) FROM moods WHERE date = ?1',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [_dateTimeConverter.encode(date)],
    );
  }

  @override
  Future<bool?> hasMoodForDate(DateTime date) async {
    return _queryAdapter.query(
      'SELECT EXISTS(SELECT 1 FROM moods WHERE date = ?1 LIMIT 1)',
      mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
      arguments: [_dateTimeConverter.encode(date)],
    );
  }

  @override
  Future<int?> getIntensityForDate(DateTime date) async {
    return _queryAdapter.query(
      'SELECT intensity FROM moods WHERE date = ?1 ORDER BY createdAt DESC LIMIT 1',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [_dateTimeConverter.encode(date)],
    );
  }

  @override
  Future<String?> getMoodTypeForDate(DateTime date) async {
    return _queryAdapter.query(
      'SELECT mood FROM moods WHERE date = ?1 ORDER BY createdAt DESC LIMIT 1',
      mapper: (Map<String, Object?> row) => row.values.first as String,
      arguments: [_dateTimeConverter.encode(date)],
    );
  }

  @override
  Future<double?> getAvgIntensityByMoodTypeInRange(
    DateTime startDate,
    DateTime endDate,
    String moodType,
  ) async {
    return _queryAdapter.query(
      'SELECT AVG(intensity) FROM moods         WHERE date >= ?1 AND date <= ?2 AND mood = ?3',
      mapper: (Map<String, Object?> row) => row.values.first as double,
      arguments: [
        _dateTimeConverter.encode(startDate),
        _dateTimeConverter.encode(endDate),
        moodType,
      ],
    );
  }

  @override
  Future<int?> getMinIntensityByMoodTypeInRange(
    DateTime startDate,
    DateTime endDate,
    String moodType,
  ) async {
    return _queryAdapter.query(
      'SELECT MIN(intensity) FROM moods         WHERE date >= ?1 AND date <= ?2 AND mood = ?3',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [
        _dateTimeConverter.encode(startDate),
        _dateTimeConverter.encode(endDate),
        moodType,
      ],
    );
  }

  @override
  Future<int?> getMaxIntensityByMoodTypeInRange(
    DateTime startDate,
    DateTime endDate,
    String moodType,
  ) async {
    return _queryAdapter.query(
      'SELECT MAX(intensity) FROM moods         WHERE date >= ?1 AND date <= ?2 AND mood = ?3',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [
        _dateTimeConverter.encode(startDate),
        _dateTimeConverter.encode(endDate),
        moodType,
      ],
    );
  }

  @override
  Future<int?> getFrequencyByMoodTypeInRange(
    DateTime startDate,
    DateTime endDate,
    String moodType,
  ) async {
    return _queryAdapter.query(
      'SELECT COUNT(*) FROM moods         WHERE date >= ?1 AND date <= ?2 AND mood = ?3',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [
        _dateTimeConverter.encode(startDate),
        _dateTimeConverter.encode(endDate),
        moodType,
      ],
    );
  }

  @override
  Future<double?> getAvgIntensitySinceCycleStart(
    DateTime cycleStartDate,
  ) async {
    return _queryAdapter.query(
      'SELECT AVG(intensity) FROM moods         WHERE date >= ?1',
      mapper: (Map<String, Object?> row) => row.values.first as double,
      arguments: [_dateTimeConverter.encode(cycleStartDate)],
    );
  }

  @override
  Future<int?> getMoodCountSinceCycleStart(DateTime cycleStartDate) async {
    return _queryAdapter.query(
      'SELECT COUNT(*) FROM moods         WHERE date >= ?1',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [_dateTimeConverter.encode(cycleStartDate)],
    );
  }

  @override
  Future<int?> getDaysWithMoodsSince(DateTime startDate) async {
    return _queryAdapter.query(
      'SELECT COUNT(DISTINCT date) FROM moods         WHERE date >= ?1',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [_dateTimeConverter.encode(startDate)],
    );
  }

  @override
  Future<int?> getHighestIntensityEver() async {
    return _queryAdapter.query(
      'SELECT MAX(intensity) FROM moods',
      mapper: (Map<String, Object?> row) => row.values.first as int,
    );
  }

  @override
  Future<int?> getLowestIntensityEver() async {
    return _queryAdapter.query(
      'SELECT MIN(intensity) FROM moods',
      mapper: (Map<String, Object?> row) => row.values.first as int,
    );
  }

  @override
  Future<int?> getUniqueMoodTypesCount() async {
    return _queryAdapter.query(
      'SELECT COUNT(DISTINCT mood) FROM moods',
      mapper: (Map<String, Object?> row) => row.values.first as int,
    );
  }

  @override
  Future<int> insertMood(MoodEntity mood) {
    return _moodEntityInsertionAdapter.insertAndReturnId(
      mood,
      OnConflictStrategy.abort,
    );
  }

  @override
  Future<List<int>> insertMoods(List<MoodEntity> moods) {
    return _moodEntityInsertionAdapter.insertListAndReturnIds(
      moods,
      OnConflictStrategy.abort,
    );
  }

  @override
  Future<void> updateMood(MoodEntity mood) async {
    await _moodEntityUpdateAdapter.update(mood, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteMood(MoodEntity mood) async {
    await _moodEntityDeletionAdapter.delete(mood);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(this.database, this.changeListener)
    : _queryAdapter = QueryAdapter(database),
      _userEntityInsertionAdapter = InsertionAdapter(
        database,
        'users',
        (UserEntity item) => <String, Object?>{
          'id': item.id,
          'email': item.email,
          'name': item.name,
          'dateOfBirth': _dateTimeNullableConverter.encode(item.dateOfBirth),
          'averageCycleLength': item.averageCycleLength,
          'averagePeriodLength': item.averagePeriodLength,
          'lastPeriodDate': _dateTimeNullableConverter.encode(
            item.lastPeriodDate,
          ),
          'isOnboardingCompleted': item.isOnboardingCompleted ? 1 : 0,
          'profileImageUrl': item.profileImageUrl,
          'createdAt': _dateTimeConverter.encode(item.createdAt),
          'updatedAt': _dateTimeConverter.encode(item.updatedAt),
        },
      ),
      _userEntityUpdateAdapter = UpdateAdapter(
        database,
        'users',
        ['id'],
        (UserEntity item) => <String, Object?>{
          'id': item.id,
          'email': item.email,
          'name': item.name,
          'dateOfBirth': _dateTimeNullableConverter.encode(item.dateOfBirth),
          'averageCycleLength': item.averageCycleLength,
          'averagePeriodLength': item.averagePeriodLength,
          'lastPeriodDate': _dateTimeNullableConverter.encode(
            item.lastPeriodDate,
          ),
          'isOnboardingCompleted': item.isOnboardingCompleted ? 1 : 0,
          'profileImageUrl': item.profileImageUrl,
          'createdAt': _dateTimeConverter.encode(item.createdAt),
          'updatedAt': _dateTimeConverter.encode(item.updatedAt),
        },
      ),
      _userEntityDeletionAdapter = DeletionAdapter(
        database,
        'users',
        ['id'],
        (UserEntity item) => <String, Object?>{
          'id': item.id,
          'email': item.email,
          'name': item.name,
          'dateOfBirth': _dateTimeNullableConverter.encode(item.dateOfBirth),
          'averageCycleLength': item.averageCycleLength,
          'averagePeriodLength': item.averagePeriodLength,
          'lastPeriodDate': _dateTimeNullableConverter.encode(
            item.lastPeriodDate,
          ),
          'isOnboardingCompleted': item.isOnboardingCompleted ? 1 : 0,
          'profileImageUrl': item.profileImageUrl,
          'createdAt': _dateTimeConverter.encode(item.createdAt),
          'updatedAt': _dateTimeConverter.encode(item.updatedAt),
        },
      );

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UserEntity> _userEntityInsertionAdapter;

  final UpdateAdapter<UserEntity> _userEntityUpdateAdapter;

  final DeletionAdapter<UserEntity> _userEntityDeletionAdapter;

  @override
  Future<List<UserEntity>> getAllUsers() async {
    return _queryAdapter.queryList(
      'SELECT * FROM users ORDER BY createdAt DESC',
      mapper: (Map<String, Object?> row) => UserEntity(
        id: row['id'] as String,
        email: row['email'] as String,
        name: row['name'] as String?,
        dateOfBirth: _dateTimeNullableConverter.decode(
          row['dateOfBirth'] as int?,
        ),
        averageCycleLength: row['averageCycleLength'] as int,
        averagePeriodLength: row['averagePeriodLength'] as int,
        lastPeriodDate: _dateTimeNullableConverter.decode(
          row['lastPeriodDate'] as int?,
        ),
        isOnboardingCompleted: (row['isOnboardingCompleted'] as int) != 0,
        profileImageUrl: row['profileImageUrl'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
        updatedAt: _dateTimeConverter.decode(row['updatedAt'] as int),
      ),
    );
  }

  @override
  Future<UserEntity?> getUserById(String id) async {
    return _queryAdapter.query(
      'SELECT * FROM users WHERE id = ?1',
      mapper: (Map<String, Object?> row) => UserEntity(
        id: row['id'] as String,
        email: row['email'] as String,
        name: row['name'] as String?,
        dateOfBirth: _dateTimeNullableConverter.decode(
          row['dateOfBirth'] as int?,
        ),
        averageCycleLength: row['averageCycleLength'] as int,
        averagePeriodLength: row['averagePeriodLength'] as int,
        lastPeriodDate: _dateTimeNullableConverter.decode(
          row['lastPeriodDate'] as int?,
        ),
        isOnboardingCompleted: (row['isOnboardingCompleted'] as int) != 0,
        profileImageUrl: row['profileImageUrl'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
        updatedAt: _dateTimeConverter.decode(row['updatedAt'] as int),
      ),
      arguments: [id],
    );
  }

  @override
  Future<UserEntity?> getUserByEmail(String email) async {
    return _queryAdapter.query(
      'SELECT * FROM users WHERE email = ?1',
      mapper: (Map<String, Object?> row) => UserEntity(
        id: row['id'] as String,
        email: row['email'] as String,
        name: row['name'] as String?,
        dateOfBirth: _dateTimeNullableConverter.decode(
          row['dateOfBirth'] as int?,
        ),
        averageCycleLength: row['averageCycleLength'] as int,
        averagePeriodLength: row['averagePeriodLength'] as int,
        lastPeriodDate: _dateTimeNullableConverter.decode(
          row['lastPeriodDate'] as int?,
        ),
        isOnboardingCompleted: (row['isOnboardingCompleted'] as int) != 0,
        profileImageUrl: row['profileImageUrl'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
        updatedAt: _dateTimeConverter.decode(row['updatedAt'] as int),
      ),
      arguments: [email],
    );
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    return _queryAdapter.query(
      'SELECT * FROM users LIMIT 1',
      mapper: (Map<String, Object?> row) => UserEntity(
        id: row['id'] as String,
        email: row['email'] as String,
        name: row['name'] as String?,
        dateOfBirth: _dateTimeNullableConverter.decode(
          row['dateOfBirth'] as int?,
        ),
        averageCycleLength: row['averageCycleLength'] as int,
        averagePeriodLength: row['averagePeriodLength'] as int,
        lastPeriodDate: _dateTimeNullableConverter.decode(
          row['lastPeriodDate'] as int?,
        ),
        isOnboardingCompleted: (row['isOnboardingCompleted'] as int) != 0,
        profileImageUrl: row['profileImageUrl'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
        updatedAt: _dateTimeConverter.decode(row['updatedAt'] as int),
      ),
    );
  }

  @override
  Future<void> deleteUserById(String id) async {
    await _queryAdapter.queryNoReturn(
      'DELETE FROM users WHERE id = ?1',
      arguments: [id],
    );
  }

  @override
  Future<void> updateUserName(
    String id,
    String name,
    DateTime updatedAt,
  ) async {
    await _queryAdapter.queryNoReturn(
      'UPDATE users SET name = ?2, updatedAt = ?3 WHERE id = ?1',
      arguments: [id, name, _dateTimeConverter.encode(updatedAt)],
    );
  }

  @override
  Future<void> updateUserEmail(
    String id,
    String email,
    DateTime updatedAt,
  ) async {
    await _queryAdapter.queryNoReturn(
      'UPDATE users SET email = ?2, updatedAt = ?3 WHERE id = ?1',
      arguments: [id, email, _dateTimeConverter.encode(updatedAt)],
    );
  }

  @override
  Future<void> updateUserDateOfBirth(
    String id,
    DateTime dateOfBirth,
    DateTime updatedAt,
  ) async {
    await _queryAdapter.queryNoReturn(
      'UPDATE users SET dateOfBirth = ?2, updatedAt = ?3 WHERE id = ?1',
      arguments: [
        id,
        _dateTimeConverter.encode(dateOfBirth),
        _dateTimeConverter.encode(updatedAt),
      ],
    );
  }

  @override
  Future<void> updateUserProfileImage(
    String id,
    String profileImageUrl,
    DateTime updatedAt,
  ) async {
    await _queryAdapter.queryNoReturn(
      'UPDATE users SET profileImageUrl = ?2, updatedAt = ?3 WHERE id = ?1',
      arguments: [id, profileImageUrl, _dateTimeConverter.encode(updatedAt)],
    );
  }

  @override
  Future<void> updateAverageCycleLength(
    String id,
    int cycleLength,
    DateTime updatedAt,
  ) async {
    await _queryAdapter.queryNoReturn(
      'UPDATE users SET averageCycleLength = ?2, updatedAt = ?3 WHERE id = ?1',
      arguments: [id, cycleLength, _dateTimeConverter.encode(updatedAt)],
    );
  }

  @override
  Future<void> updateAveragePeriodLength(
    String id,
    int periodLength,
    DateTime updatedAt,
  ) async {
    await _queryAdapter.queryNoReturn(
      'UPDATE users SET averagePeriodLength = ?2, updatedAt = ?3 WHERE id = ?1',
      arguments: [id, periodLength, _dateTimeConverter.encode(updatedAt)],
    );
  }

  @override
  Future<void> updateLastPeriodDate(
    String id,
    DateTime lastPeriodDate,
    DateTime updatedAt,
  ) async {
    await _queryAdapter.queryNoReturn(
      'UPDATE users SET lastPeriodDate = ?2, updatedAt = ?3 WHERE id = ?1',
      arguments: [
        id,
        _dateTimeConverter.encode(lastPeriodDate),
        _dateTimeConverter.encode(updatedAt),
      ],
    );
  }

  @override
  Future<void> updateCycleSettings(
    String id,
    int cycleLength,
    int periodLength,
    DateTime updatedAt,
  ) async {
    await _queryAdapter.queryNoReturn(
      'UPDATE users SET averageCycleLength = ?2, averagePeriodLength = ?3, updatedAt = ?4 WHERE id = ?1',
      arguments: [
        id,
        cycleLength,
        periodLength,
        _dateTimeConverter.encode(updatedAt),
      ],
    );
  }

  @override
  Future<void> updateOnboardingStatus(
    String id,
    bool isCompleted,
    DateTime updatedAt,
  ) async {
    await _queryAdapter.queryNoReturn(
      'UPDATE users SET isOnboardingCompleted = ?2, updatedAt = ?3 WHERE id = ?1',
      arguments: [
        id,
        isCompleted ? 1 : 0,
        _dateTimeConverter.encode(updatedAt),
      ],
    );
  }

  @override
  Future<bool?> isOnboardingCompleted(String id) async {
    return _queryAdapter.query(
      'SELECT isOnboardingCompleted FROM users WHERE id = ?1',
      mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
      arguments: [id],
    );
  }

  @override
  Future<bool?> isCurrentUserOnboardingCompleted() async {
    return _queryAdapter.query(
      'SELECT isOnboardingCompleted FROM users LIMIT 1',
      mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
    );
  }

  @override
  Future<int?> getUsersCount() async {
    return _queryAdapter.query(
      'SELECT COUNT(*) FROM users',
      mapper: (Map<String, Object?> row) => row.values.first as int,
    );
  }

  @override
  Future<DateTime?> getUserCreatedDate(String id) async {
    return _queryAdapter.query(
      'SELECT createdAt FROM users WHERE id = ?1',
      mapper: (Map<String, Object?> row) =>
          _dateTimeNullableConverter.decode(row.values.first as int?)!,
      arguments: [id],
    );
  }

  @override
  Future<DateTime?> getUserLastUpdated(String id) async {
    return _queryAdapter.query(
      'SELECT updatedAt FROM users WHERE id = ?1',
      mapper: (Map<String, Object?> row) =>
          _dateTimeNullableConverter.decode(row.values.first as int?)!,
      arguments: [id],
    );
  }

  @override
  Future<int?> getUserAverageCycleLength(String id) async {
    return _queryAdapter.query(
      'SELECT averageCycleLength FROM users WHERE id = ?1',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [id],
    );
  }

  @override
  Future<int?> getUserAveragePeriodLength(String id) async {
    return _queryAdapter.query(
      'SELECT averagePeriodLength FROM users WHERE id = ?1',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [id],
    );
  }

  @override
  Future<DateTime?> getUserLastPeriodDate(String id) async {
    return _queryAdapter.query(
      'SELECT lastPeriodDate FROM users WHERE id = ?1',
      mapper: (Map<String, Object?> row) =>
          _dateTimeNullableConverter.decode(row.values.first as int?)!,
      arguments: [id],
    );
  }

  @override
  Future<DateTime?> getUserDateOfBirth(String id) async {
    return _queryAdapter.query(
      'SELECT dateOfBirth FROM users WHERE id = ?1',
      mapper: (Map<String, Object?> row) =>
          _dateTimeNullableConverter.decode(row.values.first as int?)!,
      arguments: [id],
    );
  }

  @override
  Future<int?> getUserAge(String id) async {
    return _queryAdapter.query(
      'SELECT CAST((julianday(\"now\") - julianday(dateOfBirth)) / 365.25 AS INTEGER) as age FROM users WHERE id = ?1',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [id],
    );
  }

  @override
  Future<String?> getUserName(String id) async {
    return _queryAdapter.query(
      'SELECT name FROM users WHERE id = ?1',
      mapper: (Map<String, Object?> row) => row.values.first as String,
      arguments: [id],
    );
  }

  @override
  Future<String?> getUserProfileImageUrl(String id) async {
    return _queryAdapter.query(
      'SELECT profileImageUrl FROM users WHERE id = ?1',
      mapper: (Map<String, Object?> row) => row.values.first as String,
      arguments: [id],
    );
  }

  @override
  Future<String?> getUserEmail(String id) async {
    return _queryAdapter.query(
      'SELECT email FROM users WHERE id = ?1',
      mapper: (Map<String, Object?> row) => row.values.first as String,
      arguments: [id],
    );
  }

  @override
  Future<bool?> hasUserName(String id) async {
    return _queryAdapter.query(
      'SELECT (name IS NOT NULL) FROM users WHERE id = ?1',
      mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
      arguments: [id],
    );
  }

  @override
  Future<bool?> hasUserDateOfBirth(String id) async {
    return _queryAdapter.query(
      'SELECT (dateOfBirth IS NOT NULL) FROM users WHERE id = ?1',
      mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
      arguments: [id],
    );
  }

  @override
  Future<bool?> hasUserProfileImage(String id) async {
    return _queryAdapter.query(
      'SELECT (profileImageUrl IS NOT NULL) FROM users WHERE id = ?1',
      mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
      arguments: [id],
    );
  }

  @override
  Future<bool?> hasUserCycleLength(String id) async {
    return _queryAdapter.query(
      'SELECT (averageCycleLength > 0) FROM users WHERE id = ?1',
      mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
      arguments: [id],
    );
  }

  @override
  Future<bool?> hasUserPeriodLength(String id) async {
    return _queryAdapter.query(
      'SELECT (averagePeriodLength > 0) FROM users WHERE id = ?1',
      mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
      arguments: [id],
    );
  }

  @override
  Future<bool?> hasUserLastPeriodDate(String id) async {
    return _queryAdapter.query(
      'SELECT (lastPeriodDate IS NOT NULL) FROM users WHERE id = ?1',
      mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
      arguments: [id],
    );
  }

  @override
  Future<double?> getDaysSinceLastUpdate(String id) async {
    return _queryAdapter.query(
      'SELECT (julianday(\"now\") - julianday(updatedAt)) as daysSinceLastUpdate FROM users WHERE id = ?1',
      mapper: (Map<String, Object?> row) => row.values.first as double,
      arguments: [id],
    );
  }

  @override
  Future<double?> getDaysSinceRegistration(String id) async {
    return _queryAdapter.query(
      'SELECT (julianday(\"now\") - julianday(createdAt)) as daysSinceRegistration FROM users WHERE id = ?1',
      mapper: (Map<String, Object?> row) => row.values.first as double,
      arguments: [id],
    );
  }

  @override
  Future<bool?> isEmailTaken(String email) async {
    return _queryAdapter.query(
      'SELECT EXISTS(SELECT 1 FROM users WHERE email = ?1 LIMIT 1)',
      mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
      arguments: [email],
    );
  }

  @override
  Future<bool?> userExists(String id) async {
    return _queryAdapter.query(
      'SELECT EXISTS(SELECT 1 FROM users WHERE id = ?1 LIMIT 1)',
      mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
      arguments: [id],
    );
  }

  @override
  Future<String?> getUserIdByEmail(String email) async {
    return _queryAdapter.query(
      'SELECT id FROM users WHERE email = ?1',
      mapper: (Map<String, Object?> row) => row.values.first as String,
      arguments: [email],
    );
  }

  @override
  Future<List<UserEntity>> getCompletedUsers() async {
    return _queryAdapter.queryList(
      'SELECT * FROM users WHERE isOnboardingCompleted = 1',
      mapper: (Map<String, Object?> row) => UserEntity(
        id: row['id'] as String,
        email: row['email'] as String,
        name: row['name'] as String?,
        dateOfBirth: _dateTimeNullableConverter.decode(
          row['dateOfBirth'] as int?,
        ),
        averageCycleLength: row['averageCycleLength'] as int,
        averagePeriodLength: row['averagePeriodLength'] as int,
        lastPeriodDate: _dateTimeNullableConverter.decode(
          row['lastPeriodDate'] as int?,
        ),
        isOnboardingCompleted: (row['isOnboardingCompleted'] as int) != 0,
        profileImageUrl: row['profileImageUrl'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
        updatedAt: _dateTimeConverter.decode(row['updatedAt'] as int),
      ),
    );
  }

  @override
  Future<List<UserEntity>> getIncompleteUsers() async {
    return _queryAdapter.queryList(
      'SELECT * FROM users WHERE isOnboardingCompleted = 0',
      mapper: (Map<String, Object?> row) => UserEntity(
        id: row['id'] as String,
        email: row['email'] as String,
        name: row['name'] as String?,
        dateOfBirth: _dateTimeNullableConverter.decode(
          row['dateOfBirth'] as int?,
        ),
        averageCycleLength: row['averageCycleLength'] as int,
        averagePeriodLength: row['averagePeriodLength'] as int,
        lastPeriodDate: _dateTimeNullableConverter.decode(
          row['lastPeriodDate'] as int?,
        ),
        isOnboardingCompleted: (row['isOnboardingCompleted'] as int) != 0,
        profileImageUrl: row['profileImageUrl'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
        updatedAt: _dateTimeConverter.decode(row['updatedAt'] as int),
      ),
    );
  }

  @override
  Future<List<UserEntity>> getUsersWithProfileImages() async {
    return _queryAdapter.queryList(
      'SELECT * FROM users WHERE profileImageUrl IS NOT NULL',
      mapper: (Map<String, Object?> row) => UserEntity(
        id: row['id'] as String,
        email: row['email'] as String,
        name: row['name'] as String?,
        dateOfBirth: _dateTimeNullableConverter.decode(
          row['dateOfBirth'] as int?,
        ),
        averageCycleLength: row['averageCycleLength'] as int,
        averagePeriodLength: row['averagePeriodLength'] as int,
        lastPeriodDate: _dateTimeNullableConverter.decode(
          row['lastPeriodDate'] as int?,
        ),
        isOnboardingCompleted: (row['isOnboardingCompleted'] as int) != 0,
        profileImageUrl: row['profileImageUrl'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
        updatedAt: _dateTimeConverter.decode(row['updatedAt'] as int),
      ),
    );
  }

  @override
  Future<List<UserEntity>> getUsersWithoutProfileImages() async {
    return _queryAdapter.queryList(
      'SELECT * FROM users WHERE profileImageUrl IS NULL',
      mapper: (Map<String, Object?> row) => UserEntity(
        id: row['id'] as String,
        email: row['email'] as String,
        name: row['name'] as String?,
        dateOfBirth: _dateTimeNullableConverter.decode(
          row['dateOfBirth'] as int?,
        ),
        averageCycleLength: row['averageCycleLength'] as int,
        averagePeriodLength: row['averagePeriodLength'] as int,
        lastPeriodDate: _dateTimeNullableConverter.decode(
          row['lastPeriodDate'] as int?,
        ),
        isOnboardingCompleted: (row['isOnboardingCompleted'] as int) != 0,
        profileImageUrl: row['profileImageUrl'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
        updatedAt: _dateTimeConverter.decode(row['updatedAt'] as int),
      ),
    );
  }

  @override
  Future<double?> getAvgCycleLength() async {
    return _queryAdapter.query(
      'SELECT AVG(averageCycleLength) FROM users WHERE averageCycleLength > 0',
      mapper: (Map<String, Object?> row) => row.values.first as double,
    );
  }

  @override
  Future<int?> getMinCycleLength() async {
    return _queryAdapter.query(
      'SELECT MIN(averageCycleLength) FROM users WHERE averageCycleLength > 0',
      mapper: (Map<String, Object?> row) => row.values.first as int,
    );
  }

  @override
  Future<int?> getMaxCycleLength() async {
    return _queryAdapter.query(
      'SELECT MAX(averageCycleLength) FROM users WHERE averageCycleLength > 0',
      mapper: (Map<String, Object?> row) => row.values.first as int,
    );
  }

  @override
  Future<double?> getAvgPeriodLength() async {
    return _queryAdapter.query(
      'SELECT AVG(averagePeriodLength) FROM users WHERE averagePeriodLength > 0',
      mapper: (Map<String, Object?> row) => row.values.first as double,
    );
  }

  @override
  Future<int?> getMinPeriodLength() async {
    return _queryAdapter.query(
      'SELECT MIN(averagePeriodLength) FROM users WHERE averagePeriodLength > 0',
      mapper: (Map<String, Object?> row) => row.values.first as int,
    );
  }

  @override
  Future<int?> getMaxPeriodLength() async {
    return _queryAdapter.query(
      'SELECT MAX(averagePeriodLength) FROM users WHERE averagePeriodLength > 0',
      mapper: (Map<String, Object?> row) => row.values.first as int,
    );
  }

  @override
  Future<int?> getUsersWithCycleLength(int cycleLength) async {
    return _queryAdapter.query(
      'SELECT COUNT(*) FROM users WHERE averageCycleLength = ?1',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [cycleLength],
    );
  }

  @override
  Future<int?> getUsersUnder20() async {
    return _queryAdapter.query(
      'SELECT COUNT(*) FROM users         WHERE dateOfBirth IS NOT NULL         AND (julianday(\"now\") - julianday(dateOfBirth)) / 365.25 < 20',
      mapper: (Map<String, Object?> row) => row.values.first as int,
    );
  }

  @override
  Future<int?> getUsers20to29() async {
    return _queryAdapter.query(
      'SELECT COUNT(*) FROM users         WHERE dateOfBirth IS NOT NULL         AND (julianday(\"now\") - julianday(dateOfBirth)) / 365.25 >= 20         AND (julianday(\"now\") - julianday(dateOfBirth)) / 365.25 < 30',
      mapper: (Map<String, Object?> row) => row.values.first as int,
    );
  }

  @override
  Future<int?> getUsers30to39() async {
    return _queryAdapter.query(
      'SELECT COUNT(*) FROM users         WHERE dateOfBirth IS NOT NULL         AND (julianday(\"now\") - julianday(dateOfBirth)) / 365.25 >= 30         AND (julianday(\"now\") - julianday(dateOfBirth)) / 365.25 < 40',
      mapper: (Map<String, Object?> row) => row.values.first as int,
    );
  }

  @override
  Future<int?> getUsers40to49() async {
    return _queryAdapter.query(
      'SELECT COUNT(*) FROM users         WHERE dateOfBirth IS NOT NULL         AND (julianday(\"now\") - julianday(dateOfBirth)) / 365.25 >= 40         AND (julianday(\"now\") - julianday(dateOfBirth)) / 365.25 < 50',
      mapper: (Map<String, Object?> row) => row.values.first as int,
    );
  }

  @override
  Future<int?> getUsersOver50() async {
    return _queryAdapter.query(
      'SELECT COUNT(*) FROM users         WHERE dateOfBirth IS NOT NULL         AND (julianday(\"now\") - julianday(dateOfBirth)) / 365.25 >= 50',
      mapper: (Map<String, Object?> row) => row.values.first as int,
    );
  }

  @override
  Future<List<UserEntity>> getUsersForBackup(DateTime sinceDate) async {
    return _queryAdapter.queryList(
      'SELECT * FROM users WHERE createdAt >= ?1 ORDER BY createdAt ASC',
      mapper: (Map<String, Object?> row) => UserEntity(
        id: row['id'] as String,
        email: row['email'] as String,
        name: row['name'] as String?,
        dateOfBirth: _dateTimeNullableConverter.decode(
          row['dateOfBirth'] as int?,
        ),
        averageCycleLength: row['averageCycleLength'] as int,
        averagePeriodLength: row['averagePeriodLength'] as int,
        lastPeriodDate: _dateTimeNullableConverter.decode(
          row['lastPeriodDate'] as int?,
        ),
        isOnboardingCompleted: (row['isOnboardingCompleted'] as int) != 0,
        profileImageUrl: row['profileImageUrl'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
        updatedAt: _dateTimeConverter.decode(row['updatedAt'] as int),
      ),
      arguments: [_dateTimeConverter.encode(sinceDate)],
    );
  }

  @override
  Future<List<UserEntity>> getModifiedUsersSince(DateTime sinceDate) async {
    return _queryAdapter.queryList(
      'SELECT * FROM users WHERE updatedAt >= ?1 ORDER BY updatedAt ASC',
      mapper: (Map<String, Object?> row) => UserEntity(
        id: row['id'] as String,
        email: row['email'] as String,
        name: row['name'] as String?,
        dateOfBirth: _dateTimeNullableConverter.decode(
          row['dateOfBirth'] as int?,
        ),
        averageCycleLength: row['averageCycleLength'] as int,
        averagePeriodLength: row['averagePeriodLength'] as int,
        lastPeriodDate: _dateTimeNullableConverter.decode(
          row['lastPeriodDate'] as int?,
        ),
        isOnboardingCompleted: (row['isOnboardingCompleted'] as int) != 0,
        profileImageUrl: row['profileImageUrl'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
        updatedAt: _dateTimeConverter.decode(row['updatedAt'] as int),
      ),
      arguments: [_dateTimeConverter.encode(sinceDate)],
    );
  }

  @override
  Future<void> deleteIncompleteUsersBeforeDate(DateTime beforeDate) async {
    await _queryAdapter.queryNoReturn(
      'DELETE FROM users WHERE createdAt < ?1 AND isOnboardingCompleted = 0',
      arguments: [_dateTimeConverter.encode(beforeDate)],
    );
  }

  @override
  Future<void> deleteAllUsers() async {
    await _queryAdapter.queryNoReturn('DELETE FROM users');
  }

  @override
  Future<List<UserEntity>> searchUsersByName(String searchTerm) async {
    return _queryAdapter.queryList(
      'SELECT * FROM users WHERE name LIKE ?1 ORDER BY name',
      mapper: (Map<String, Object?> row) => UserEntity(
        id: row['id'] as String,
        email: row['email'] as String,
        name: row['name'] as String?,
        dateOfBirth: _dateTimeNullableConverter.decode(
          row['dateOfBirth'] as int?,
        ),
        averageCycleLength: row['averageCycleLength'] as int,
        averagePeriodLength: row['averagePeriodLength'] as int,
        lastPeriodDate: _dateTimeNullableConverter.decode(
          row['lastPeriodDate'] as int?,
        ),
        isOnboardingCompleted: (row['isOnboardingCompleted'] as int) != 0,
        profileImageUrl: row['profileImageUrl'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
        updatedAt: _dateTimeConverter.decode(row['updatedAt'] as int),
      ),
      arguments: [searchTerm],
    );
  }

  @override
  Future<List<UserEntity>> searchUsersByEmail(String searchTerm) async {
    return _queryAdapter.queryList(
      'SELECT * FROM users WHERE email LIKE ?1 ORDER BY email',
      mapper: (Map<String, Object?> row) => UserEntity(
        id: row['id'] as String,
        email: row['email'] as String,
        name: row['name'] as String?,
        dateOfBirth: _dateTimeNullableConverter.decode(
          row['dateOfBirth'] as int?,
        ),
        averageCycleLength: row['averageCycleLength'] as int,
        averagePeriodLength: row['averagePeriodLength'] as int,
        lastPeriodDate: _dateTimeNullableConverter.decode(
          row['lastPeriodDate'] as int?,
        ),
        isOnboardingCompleted: (row['isOnboardingCompleted'] as int) != 0,
        profileImageUrl: row['profileImageUrl'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
        updatedAt: _dateTimeConverter.decode(row['updatedAt'] as int),
      ),
      arguments: [searchTerm],
    );
  }

  @override
  Future<void> markAllUsersOnboardingCompleted(DateTime updatedAt) async {
    await _queryAdapter.queryNoReturn(
      'UPDATE users SET isOnboardingCompleted = 1, updatedAt = ?1',
      arguments: [_dateTimeConverter.encode(updatedAt)],
    );
  }

  @override
  Future<void> clearAllProfileImages(DateTime updatedAt) async {
    await _queryAdapter.queryNoReturn(
      'UPDATE users SET profileImageUrl = NULL, updatedAt = ?1',
      arguments: [_dateTimeConverter.encode(updatedAt)],
    );
  }

  @override
  Future<int?> getUsersWithIrregularCyclesCount() async {
    return _queryAdapter.query(
      'SELECT COUNT(*) FROM users WHERE averageCycleLength < 21 OR averageCycleLength > 35',
      mapper: (Map<String, Object?> row) => row.values.first as int,
    );
  }

  @override
  Future<int?> getUsersWithUnusualPeriodLengthCount() async {
    return _queryAdapter.query(
      'SELECT COUNT(*) FROM users WHERE averagePeriodLength < 3 OR averagePeriodLength > 7',
      mapper: (Map<String, Object?> row) => row.values.first as int,
    );
  }

  @override
  Future<int?> getUsersWithOldLastPeriodDate(int days) async {
    return _queryAdapter.query(
      'SELECT COUNT(*) FROM users WHERE lastPeriodDate IS NOT NULL AND (julianday(\"now\") - julianday(lastPeriodDate)) > ?1',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [days],
    );
  }

  @override
  Future<int?> getCompletedUsersCount() async {
    return _queryAdapter.query(
      'SELECT COUNT(*) FROM users WHERE isOnboardingCompleted = 1',
      mapper: (Map<String, Object?> row) => row.values.first as int,
    );
  }

  @override
  Future<int?> getIncompleteUsersCount() async {
    return _queryAdapter.query(
      'SELECT COUNT(*) FROM users WHERE isOnboardingCompleted = 0',
      mapper: (Map<String, Object?> row) => row.values.first as int,
    );
  }

  @override
  Future<double?> getAvgDaysSinceRegistrationForCompleted() async {
    return _queryAdapter.query(
      'SELECT AVG(julianday(\"now\") - julianday(createdAt)) FROM users WHERE isOnboardingCompleted = 1',
      mapper: (Map<String, Object?> row) => row.values.first as double,
    );
  }

  @override
  Future<double?> getAvgDaysSinceRegistrationForIncomplete() async {
    return _queryAdapter.query(
      'SELECT AVG(julianday(\"now\") - julianday(createdAt)) FROM users WHERE isOnboardingCompleted = 0',
      mapper: (Map<String, Object?> row) => row.values.first as double,
    );
  }

  @override
  Future<List<UserEntity>> getInactiveUsers(int inactiveDays) async {
    return _queryAdapter.queryList(
      'SELECT * FROM users WHERE (julianday(\"now\") - julianday(updatedAt)) > ?1 ORDER BY updatedAt ASC',
      mapper: (Map<String, Object?> row) => UserEntity(
        id: row['id'] as String,
        email: row['email'] as String,
        name: row['name'] as String?,
        dateOfBirth: _dateTimeNullableConverter.decode(
          row['dateOfBirth'] as int?,
        ),
        averageCycleLength: row['averageCycleLength'] as int,
        averagePeriodLength: row['averagePeriodLength'] as int,
        lastPeriodDate: _dateTimeNullableConverter.decode(
          row['lastPeriodDate'] as int?,
        ),
        isOnboardingCompleted: (row['isOnboardingCompleted'] as int) != 0,
        profileImageUrl: row['profileImageUrl'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
        updatedAt: _dateTimeConverter.decode(row['updatedAt'] as int),
      ),
      arguments: [inactiveDays],
    );
  }

  @override
  Future<List<UserEntity>> getRecentUsers(int recentDays) async {
    return _queryAdapter.queryList(
      'SELECT * FROM users WHERE (julianday(\"now\") - julianday(createdAt)) <= ?1 ORDER BY createdAt DESC',
      mapper: (Map<String, Object?> row) => UserEntity(
        id: row['id'] as String,
        email: row['email'] as String,
        name: row['name'] as String?,
        dateOfBirth: _dateTimeNullableConverter.decode(
          row['dateOfBirth'] as int?,
        ),
        averageCycleLength: row['averageCycleLength'] as int,
        averagePeriodLength: row['averagePeriodLength'] as int,
        lastPeriodDate: _dateTimeNullableConverter.decode(
          row['lastPeriodDate'] as int?,
        ),
        isOnboardingCompleted: (row['isOnboardingCompleted'] as int) != 0,
        profileImageUrl: row['profileImageUrl'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
        updatedAt: _dateTimeConverter.decode(row['updatedAt'] as int),
      ),
      arguments: [recentDays],
    );
  }

  @override
  Future<int?> getInactiveUsersCount(int inactiveDays) async {
    return _queryAdapter.query(
      'SELECT COUNT(*) FROM users WHERE (julianday(\"now\") - julianday(updatedAt)) > ?1',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [inactiveDays],
    );
  }

  @override
  Future<int?> getRecentUsersCount(int recentDays) async {
    return _queryAdapter.query(
      'SELECT COUNT(*) FROM users WHERE (julianday(\"now\") - julianday(createdAt)) <= ?1',
      mapper: (Map<String, Object?> row) => row.values.first as int,
      arguments: [recentDays],
    );
  }

  @override
  Future<void> insertUser(UserEntity user) async {
    await _userEntityInsertionAdapter.insert(user, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertUsers(List<UserEntity> users) async {
    await _userEntityInsertionAdapter.insertList(
      users,
      OnConflictStrategy.abort,
    );
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    await _userEntityUpdateAdapter.update(user, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteUser(UserEntity user) async {
    await _userEntityDeletionAdapter.delete(user);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
final _dateTimeNullableConverter = DateTimeNullableConverter();
