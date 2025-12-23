// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

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

  RecentProductDao? _recentProductDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `RecentProduct` (`templateId` TEXT, `name` TEXT, `image` TEXT, `priceUnit` TEXT, `priceReduce` TEXT, `productId` INTEGER, `productCount` INTEGER, `ribbonMessage` TEXT, `position` TEXT, `textColor` TEXT, `bgColor` TEXT, PRIMARY KEY (`templateId`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  RecentProductDao get recentProductDao {
    return _recentProductDaoInstance ??=
        _$RecentProductDao(database, changeListener);
  }
}

class _$RecentProductDao extends RecentProductDao {
  _$RecentProductDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _recentProductInsertionAdapter = InsertionAdapter(
            database,
            'RecentProduct',
            (RecentProduct item) => <String, Object?>{
                  'templateId': item.templateId,
                  'name': item.name,
                  'image': item.image,
                  'priceUnit': item.priceUnit,
                  'priceReduce': item.priceReduce,
                  'productId': item.productId,
                  'productCount': item.productCount,
                  'ribbonMessage': item.ribbonMessage,
                  'position': item.position,
                  'textColor': item.textColor,
                  'bgColor': item.bgColor
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<RecentProduct> _recentProductInsertionAdapter;

  @override
  Future<List<RecentProduct>> getProducts() async {
    return _queryAdapter.queryList('SELECT * FROM RecentProduct LIMIT 10',
        mapper: (Map<String, Object?> row) => RecentProduct(
            templateId: row['templateId'] as String?,
            image: row['image'] as String?,
            name: row['name'] as String?,
            priceUnit: row['priceUnit'] as String?,
            priceReduce: row['priceReduce'] as String?,
            productId: row['productId'] as int?,
            productCount: row['productCount'] as int?,
            ribbonMessage: row['ribbonMessage'] as String?,
            position: row['position'] as String?,
            textColor: row['textColor'] as String?,
            bgColor: row['bgColor'] as String?));
  }

  @override
  Future<void> insertRecentProduct(RecentProduct product) async {
    await _recentProductInsertionAdapter.insert(
        product, OnConflictStrategy.replace);
  }
}
