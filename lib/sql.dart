import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'userDB.dart';

//SQfLite class definitions and manipulations
class SQLiteDbProvider{
  SQLiteDbProvider._();
  static final SQLiteDbProvider db = SQLiteDbProvider._();
  static Database _database;

  Future<Database> get database async{
    if(_database != null)
      return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "User.db");

    return await openDatabase(
        path,
        version:1,
        onOpen: (db){},
        onCreate: (Database db, int version) async{
          await db.execute("CREATE TABLE user("
              "id INTEGER PRIMARY KEY,"
              "name TEXT,"
              "surname TEXT,"
              "phone TEXT,"
              "bankAccNum TEXT,"
              "bankName TEXT,"
              "money INTEGER"
              ")");
        }
    );
  }

  //function to get all table information
  Future<List<userDB>> getTableData() async{
    final db = await database;
    List<Map> results = await db.query("user", columns: userDB.columns);

    List<userDB> user = new List();
    results.forEach((result){
      userDB data = userDB.fromMap(result);
      user.add(data);
    });

    return user;
  }

  //method to insert into database
  insert(userDB user) async{
    final db = await database;
    var maxIdResult = await db.rawQuery("SELECT MAX(id)+1 as last_inserted_id FROM user");
    var id = maxIdResult.first["last_inserted_id"];
    var result = await db.rawInsert("INSERT INTO user(id,name,surname,phone,bankAccNum,bankName,money)"
        "VALUES(?,?,?,?,?,?,?)", [id, user.name, user.surname, user.phone, user.bankAccNum, user.bankName, user.money]);

    return result;
  }

  //method to update information in the database
  update(userDB user) async{
    final db = await database;
    var result = await db.update(
        "user",
        user.toMap(),
        where: "id = ?",
        whereArgs: [user.id]
    );

    return result;
  }

  //method to delete information in the database
  deleteAll() async{
    final db = await database;
    db.delete("user", where: "id >= 1");
  }

  //method to delete information in the database using the phone number
  deleteByPhone(String phone)async{
    final db = await database;
    db.delete("user", where: "phone = ?", whereArgs: [phone]);
  }
}