import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'dart:async';
import '../models/item_model.dart';
import 'repository.dart';

class NewsDbProvider implements Source, Cache {
  late Database db;

  NewsDbProvider() {
    init();
  }

  // TODO - fetch and store Top IDs
  Future<List<int>> fetchTopIds() {
    return Future.value([]);
  }

  // a constructor cannot be async so we are using an init method
  void init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "items.db");

    // This will open the existing database or create if not exist
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        newDb.execute("""
          CREATE TABLE Items
            (
              id INTEGER PRIMARY KEY,
              type TEXT,
              by TEXT,
              time INTEGER,
              parent INTEGER,
              kids BLOB,
              dead INTEGER,
              deleted INTEGER,
              url TEXT,
              score INTEGER,
              title TEXT,
              text TEXT,
              descendants INTEGER
            )
        """);
      },
    );
  }

  Future<ItemModel?> fetchItem(int id, [dynamic columns = null]) async {
    final maps = await db.query(
      "Items",
      columns: columns,
      where: "id = ?",
      whereArgs: [id],
    );

    if (maps.length > 0) {
      return ItemModel.fromDb(maps.first);
    }

    return null;
  }

  Future<int> addItem(ItemModel item) {
    return db.insert(
      "Items",
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }
}

// Since using multiple DB instances are not accepted, we are exporting an
// instance, and we are going to use this instance instead.
final newsDbProvider = NewsDbProvider();
