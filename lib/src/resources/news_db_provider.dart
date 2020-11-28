import 'dart:async';

// ignore: import_of_legacy_library_into_null_safe
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/item_model.dart';
import 'repository.dart';

class NewsDbProvider implements Source, Cache {
  NewsDbProvider() {
    init();
  }

  Database db;

  void init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = '${documentsDirectory.path}items1.db';
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (newDb, version) {
        newDb.execute('''
          CREATE TABLE Items
          (
            id INTEGER PRIMARY KEY,
            type INTEGER,
            by TEXT,
            time INTEGER,
            text TEXT,
            parent INTEGER,
            kids BLOB,
            dead  INTEGER,
            deleted INTEGER,
            url TEXT,
            score INTEGER,
            title TEXT,
            descendants INTEGER
          )
        ''');
      },
    );
  }

  Future<ItemModel> fetchItem(int id) async {
    final maps = await db.query(
      'Items',
      columns: null,
      where: 'id = ?',
      whereArgs: [id],
    );
    return maps.length > 0 ? ItemModel.fromDb(maps.first) : null;
  }

  void addItem(ItemModel item) => db.insert('Items', item.toMap());

  Future<List<int>> fetchTopIds() => null;

  Future<int> clear() {
    return db.delete('Items');
  }
}

final newsDbProvider = NewsDbProvider();
