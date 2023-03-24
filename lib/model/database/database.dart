import 'dart:async';

import 'package:currency_rate_app/model/dao/currency_dao.dart';
import 'package:currency_rate_app/model/dao/currency_detail_dao.dart';
import 'package:currency_rate_app/model/entities/currency.dart';
import 'package:currency_rate_app/model/entities/currency_detail/currency_detail_combined.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [Currency, CurrencyDetailCombined])
abstract class AppDatabase extends FloorDatabase {
  CurrencyDao get currencyDao;

  CurrencyDetailDao get currencyDetailDao;
}

class DatabaseProvider {
  static final DatabaseProvider _instance = DatabaseProvider._internal();

  factory DatabaseProvider() => _instance;

  DatabaseProvider._internal();

  static AppDatabase? _database;

  Future<AppDatabase> get database async {
    if (_database != null) return _database!;

    _database =
        await $FloorAppDatabase.databaseBuilder('flutter_database.db').build();

    return _database!;
  }
}
