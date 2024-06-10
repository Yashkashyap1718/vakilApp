import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:vakil_app/constants/db_const.dart';
import 'package:vakil_app/model/user_model.dart';

class DatabaseProvider {
  Future<Database> initializedDB() async {
    // sqfliteFfiInit();
    // databaseFactory = databaseFactoryFfi;
    String path = await getDatabasesPath();

    return await openDatabase(
      join(path, 'acclaimguard.db'),
      version: 2,
      onCreate: (db, version) {
        return db.execute(
          '''
    CREATE TABLE $userTableName (
      _id INTEGER PRIMARY KEY AUTOINCREMENT,
      role TEXT NOT NULL,
      token TEXT NOT NULL,
      first_name TEXT NOT NULL,
      last_name TEXT NOT NULL,
      email TEXT NOT NULL,
      gender TEXT NOT NULL,
      date_of_birth TEXT,
      nationality TEXT,
      city TEXT,
      address TEXT,
      pin_code TEXT,
      country TEXT,
      state TEXT,
      phone TEXT,
    )
    ''',
        );
      },
    );
  }

  Future<bool> insertUser(UserModel user) async {
    try {
      final db = await initializedDB();
      await db.insert(userTableName, user.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);

      return true;
    } catch (e) {
      print('---------------error during user insert--------$e');
      return false;
    }
  }

  // delete db
  Future<void> deleteUser(int id) async {
    final db = await initializedDB();
    await db.delete(
      userTableName,
      where: '_id = ?',
      whereArgs: [id],
    );
  }

  // clean db
  Future<void> clearUserTable() async {
    final db = await initializedDB();
    await db.delete(userTableName);
  }

  // retrieve data from database

  Future<UserModel> retrieveUserFromTable() async {
    final Database db = await initializedDB();
    final List<Map<String, Object?>> queryResult =
        await db.query(userTableName);

    if (queryResult.isNotEmpty) {
      return queryResult.map((e) => UserModel.fromJson(e)).first;
    } else {
      return UserModel();
    }
  }
}
