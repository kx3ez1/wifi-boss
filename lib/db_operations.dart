import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:wifi_boss/user_data.dart';


class DbOperations{
  static Database? _db;



  Future<Database?> get db async{
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'user.db');


    await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute('CREATE TABLE login (id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, password TEXT)');
        }).then((value) {
      print('@@table created');
    });

    print(path);
    _db = await openDatabase(path);            //for delete execute
    if(_db != null){
      print('@@ Database Already exists');
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }
  initDatabase() async{
    print('@@ Database created..');
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'user.db');

    // await deleteDatabase(path).then(                                    //for deleting database
    //     (value){
    //       print('@@databse deleted');
    //     }
    // );
    await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute('CREATE TABLE login (id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, password TEXT)');
        }).then((value){
          print('@@table created');
    });
  }

  Future<CredentialsNoId> insert(CredentialsNoId cModel) async{
    var dbClient = await db;
    //checking for existing data to be unique username
    final List<Map<String, Object?>>? queryResult2 = await dbClient!.rawQuery('select * from login where username = "${cModel.username}"');
    if(queryResult2!.isNotEmpty){
      await dbClient.update('login', cModel.toJson(),where: 'username = "${cModel.username}"').then((value) => print(value));
    }
    else {
      await dbClient.insert('login', cModel.toJson()).then((value) {
        print('@@data inserted successfully');
      });
    }
    //await dbClient?.update('login', cModel.toJson(),where: 'username = "${cModel.username}"').then((value) => print(value));
    return cModel;
  }
  Future<List<Credentials>> checkData(CredentialsNoId cModel) async{
    var dbClient = await db;
    final List<Map<String, Object?>>? queryResult1 = await dbClient!.rawQuery('select * from login where username = "${cModel.username}"');
    print('data length queryResult ${queryResult1!.length}');
    return List.from(queryResult1).map<Credentials>((item) => Credentials.fromJson(item)).toList();
  }
  Future<CredentialsNoId> delete(CredentialsNoId cModel) async{
    var dbClient = await db;
    await dbClient?.delete('login', where: 'username= "${cModel.username}"').then((value){
      print(value);
      print('@@data deleted successfully');
    });
    return cModel;
  }
  Future<List<Credentials>> getDataList() async{
    var dbClient = await db;
      final List<Map<String, Object?>> queryResult = await dbClient!.query('login');
      return List.from(queryResult).map<Credentials>((item) => Credentials.fromJson(item)).toList();
  }
}