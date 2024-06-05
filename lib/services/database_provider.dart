import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:vakil_app/constants/db_const.dart';
import 'package:vakil_app/model/user_model.dart';

class DatabaseProvider {
  Future<Database> initializedDB() async {
    String path = await getDatabasesPath();

    return openDatabase(
      join(path, db),
      version: 2,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE $userTableName("
          "_id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "role TEXT NOT NULL,"
          "token TEXT NOT NULL,"
          "first_name TEXT NOT NULL,"
          "last_name TEXT NOT NULL,"
          "email TEXT NOT NULL,"
          "gender TEXT NOT NULL,"
          "date_of_birth TEXT,"
          "nationality TEXT,"
          "city TEXT,"
          "address TEXT,"
          "pin_code TEXT,"
          "country TEXT,"
          "state TEXT,"
          "phone TEXT)",
        );
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        if (oldVersion < 2) {
          // Check if the phone column does not exist before attempting to add it
          List<Map<String, dynamic>> columns =
              await db.rawQuery("PRAGMA table_info($userTableName)");
          bool phoneColumnExists = columns.any(
              (column) => column['name'].toString().toLowerCase() == 'phone');

          if (!phoneColumnExists) {
            // Add the phone column
            await db
                .execute('ALTER TABLE $userTableName ADD COLUMN phone TEXT');
          }
        }
      },
    );
  }

  Future<int> insertUser(UserModel item) async {
    try {
      int result = 0;

      final Database db = await initializedDB();

      result = await db.insert(userTableName, item.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);

      return result;
    } catch (e) {
      return 0;
    }
  }

  Future<UserModel> retrieveUserFromTable() async {
    final Database db = await initializedDB();

    final List<Map<String, dynamic>> queryResult =
        await db.query(userTableName);

    if (queryResult.isNotEmpty) {
      // Return the UserModel corresponding to the first user found in the query result
      return UserModel.fromJson(queryResult.first);
    } else {
      // Return an empty UserModel if no user found in the database
      return UserModel();
    }
  }

  Future<void> deleteUserFromTable(int id) async {
    final db = await initializedDB();

    await db.delete(
      userTableName,
      where: "_id = ?",
      whereArgs: [id],
    );
  }

  Future<void> cleanUserTable() async {
    final db = await initializedDB();

    await db.delete(
      userTableName,
    );
  }
}
