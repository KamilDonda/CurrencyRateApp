// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CurrencyDao? _currencyDaoInstance;

  CurrencyDetailDao? _currencyDetailDaoInstance;

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
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Currency` (`code` TEXT NOT NULL, `name` TEXT NOT NULL, `countryCode` INTEGER NOT NULL, `value` REAL NOT NULL, `date` TEXT NOT NULL, PRIMARY KEY (`code`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `CurrencyDetailCombined` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `code` TEXT NOT NULL, `date` TEXT NOT NULL, `bid` REAL NOT NULL, `ask` REAL NOT NULL, `mid` REAL NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CurrencyDao get currencyDao {
    return _currencyDaoInstance ??= _$CurrencyDao(database, changeListener);
  }

  @override
  CurrencyDetailDao get currencyDetailDao {
    return _currencyDetailDaoInstance ??=
        _$CurrencyDetailDao(database, changeListener);
  }
}

class _$CurrencyDao extends CurrencyDao {
  _$CurrencyDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _currencyInsertionAdapter = InsertionAdapter(
            database,
            'Currency',
            (Currency item) => <String, Object?>{
                  'code': item.code,
                  'name': item.name,
                  'countryCode': item.countryCode.index,
                  'value': item.value,
                  'date': item.date
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Currency> _currencyInsertionAdapter;

  @override
  Future<List<Currency>> getCurrencies() async {
    return _queryAdapter.queryList('SELECT * FROM Currency',
        mapper: (Map<String, Object?> row) => Currency(
            name: row['name'] as String,
            countryCode: FlagsCode.values[row['countryCode'] as int],
            code: row['code'] as String,
            value: row['value'] as double,
            date: row['date'] as String));
  }

  @override
  Future<void> insertCurrency(List<Currency> currencies) async {
    await _currencyInsertionAdapter.insertList(
        currencies, OnConflictStrategy.replace);
  }
}

class _$CurrencyDetailDao extends CurrencyDetailDao {
  _$CurrencyDetailDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _currencyDetailCombinedInsertionAdapter = InsertionAdapter(
            database,
            'CurrencyDetailCombined',
            (CurrencyDetailCombined item) => <String, Object?>{
                  'id': item.id,
                  'code': item.code,
                  'date': item.date,
                  'bid': item.bid,
                  'ask': item.ask,
                  'mid': item.mid
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CurrencyDetailCombined>
      _currencyDetailCombinedInsertionAdapter;

  @override
  Future<List<CurrencyDetailCombined>> getLast30ValuesByCode(
      String code) async {
    return _queryAdapter.queryList(
        'SELECT * FROM CurrencyDetailCombined WHERE code = ?1',
        mapper: (Map<String, Object?> row) => CurrencyDetailCombined(
            id: row['id'] as int,
            code: row['code'] as String,
            date: row['date'] as String,
            bid: row['bid'] as double,
            ask: row['ask'] as double,
            mid: row['mid'] as double),
        arguments: [code]);
  }

  @override
  Future<void> insertCurrencyDetail(List<CurrencyDetailCombined> values) async {
    await _currencyDetailCombinedInsertionAdapter.insertList(
        values, OnConflictStrategy.replace);
  }
}
