/**

 * Webkul Software.

 * @package Mobikul App

 * @Category Mobikul

 * @author Webkul <support@webkul.com>

 * @Copyright (c) Webkul Software Private Limited (https://webkul.com)

 * @license https://store.webkul.com/license.html ASL Licence

 * @link https://store.webkul.com/license.html

 */


import 'dart:async';

import 'package:floor/floor.dart';
import 'package:flutter_project_structure/helper/LocalDb/floor/dao/recent_product_dao.dart';
import 'package:flutter_project_structure/helper/LocalDb/floor/entities/recent_product.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [RecentProduct])
abstract class AppDatabase extends FloorDatabase {
  RecentProductDao get recentProductDao;

  // AppDatabase._();

  static AppDatabase? _database;

  static Future<AppDatabase> getDatabase() async {
    _database ??= await $FloorAppDatabase
        .databaseBuilder("odoo_database.db")
        .build();
    return _database!;
  }
}
