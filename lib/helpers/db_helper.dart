import 'package:sqflite/sqflite.dart' as sqlite;
import 'package:path/path.dart' as path;
import 'package:sqflite/utils/utils.dart';

class DBHelper {
  static void _createDb(sqlite.Database db, int newVersion) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS users(id INTEGER PRIMARY KEY,
                                     name TEXT,
                                     username TEXT,
                                     email TEXT,
                                     street TEXT,
                                     suite TEXT,
                                     city TEXT,
                                     zipcode TEXT,
                                     phone TEXT,
                                     website TEXT,
                                     companyName TEXT,
                                     catchPhrase TEXT,
                                     bs TEXT)
''');
    await db.execute('''
    CREATE TABLE IF NOT EXISTS user_posts(id INTEGER PRIMARY KEY,
                                          userId INTEGER,
                                          title TEXT,
                                          body TEXT)
''');
    await db.execute('''
    CREATE TABLE IF NOT EXISTS user_albums(id INTEGER PRIMARY KEY,
                                           userId INTEGER,
                                           title TEXT)
''');
    await db.execute('''
    CREATE TABLE IF NOT EXISTS album_photos(id INTEGER PRIMARY KEY,
                                            albumId INTEGER,
                                            title TEXT,
                                            url TEXT,
                                            thumbnailUrl TEXT)
''');
    await db.execute('''
    CREATE TABLE IF NOT EXISTS post_comments(id INTEGER PRIMARY KEY,
                                             postId INTEGER,
                                             name TEXT,
                                             email TEXT,
                                             body TEXT)
''');
  }

  static Future<sqlite.Database> _openDB() async {
    final dbPath = await sqlite.getDatabasesPath();
    return sqlite.openDatabase(
      path.join(dbPath, 'app.db'),
      onCreate: (db, version) => _createDb(db, version),
      version: 1,
    );
  }

  static Future<bool> _tableExists(sqlite.Database db, String table) async {
    final sqliteDB = await DBHelper._openDB();
    var count = firstIntValue(await sqliteDB.query('sqlite_master',
        columns: ['COUNT(*)'],
        where: 'type = ? AND name = ?',
        whereArgs: ['table', table]));
    return count! > 0;
  }

  static Future<void> insertData(String table, Map<String, Object> data) async {
    final sqliteDB = await DBHelper._openDB();
    // Using batch for heavy operations more than 1000 queries
    final batch = sqliteDB.batch();
    batch.insert(
      table,
      data,
      conflictAlgorithm: sqlite.ConflictAlgorithm.replace,
    );
    await batch.commit();
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final sqliteDB = await DBHelper._openDB();
    final data = sqliteDB.query(table);
    return data;
  }

  static Future<List<Map<String, dynamic>>> getDataById(
      String table, String idType, int id) async {
    final sqliteDB = await DBHelper._openDB();
    final bool tableExists = await _tableExists(sqliteDB, table);
    if (tableExists) {
      return sqliteDB.query(table, where: '$idType = $id');
    }
    return [];
  }
}
