import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

import '../user_model/user_model.dart';

class DatabaseHelper {
  static Database? _db;

  static const String dName = "store.db";
  static const String tableUser = "User";
  static const int version = 5;
  static const String _userId = "userId";
  static const String _username = "username";
  static const String _email = "email";
  static const String _password = "password";
  static const String _conformPassword = "confirmPassword";
  static const String _address = "address";



  Future<Database?> get db async{
    if(_db != null){
      return _db;
    }
    _db = await initDb();
    return _db;
  }
   Future<Database>initDb()async {
    io.Directory documentsDirectory = await  getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path,dName);
  var  db = await openDatabase(
      path, version: version,
      onCreate: _onCreate,
    );
    return db;
   }


  void _onCreate(Database db, int version)async{
    await db.execute("CREATE TABLE $tableUser ("
        " $_userId TEXT, "
        " $_username TEXT, "
        " $_email TEXT, "
        " $_password TEXT, "
        " $_conformPassword TEXT, "
        " $_address TEXT,"
        " PRIMARY KEY ($_userId)"
        ")");
  }


  Future<int> saveData(UserModel user) async {
    var dbClient = await db;
    var res = await dbClient!.insert(tableUser, user.toMap());
    return res;
  }

  Future<UserModel?> getLoginUser(String userId, String password) async {
    var dbClient = await db;
    var res = await dbClient!.rawQuery("SELECT * FROM $tableUser WHERE "
        "$_userId = '$userId' AND "
        "$_password = '$password'");

    if (res.isNotEmpty) {
      return UserModel.fromMap(res.first);
    }

    return null;
  }

  


}





