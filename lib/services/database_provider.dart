import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

import '../model/user_model.dart';

class DatabaseProvider {
  late Database _database;

  Future<void> open() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'user_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, email TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> addUser(UserModel user) async {
    await _database.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<UserModel> getUsers() async {
    final List<Map<String, dynamic>> maps = await _database.query('users');

    if (maps.isNotEmpty) {
      return maps.map((e) => UserModel.fromJson(e)).first;
    } else {
      return UserModel();
    }
  }

  Future<void> updateUser(UserModel user) async {
    await _database.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<void> deleteUser(int id) async {
    await _database.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAllUsers() async {
    await _database.delete('users');
  }
}
