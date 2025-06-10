// lib/core/database/app_database.dart
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'daos/period_dao.dart';
import 'daos/symptom_dao.dart';
import 'daos/mood_dao.dart';
import 'daos/user_dao.dart';
import 'entities/period_entity.dart';
import 'entities/symptom_entity.dart';
import 'entities/mood_entity.dart';
import 'entities/user_entity.dart';
import 'converters/date_time_converter.dart';

part 'app_database.g.dart';

@TypeConverters([DateTimeConverter, DateTimeNullableConverter])
@Database(
  version: 1,
  entities: [PeriodEntity, SymptomEntity, MoodEntity, UserEntity],
)
abstract class AppDatabase extends FloorDatabase {
  PeriodDao get periodDao;
  SymptomDao get symptomDao;
  MoodDao get moodDao;
  UserDao get userDao;

  static AppDatabase? _instance;

  static Future<AppDatabase> getInstance() async {
    _instance ??= await $FloorAppDatabase
        .databaseBuilder('app_database.db')
        .addMigrations([])
        .build();
    return _instance!;
  }

  Future<void> initialize() async {
    _instance = await getInstance();
  }
}
