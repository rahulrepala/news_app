import 'package:news_app/database/articles_database.dart';
import 'package:sqflite/sqflite.dart';

class Repository{

  ArticlesDatabase _articlesDatabase = ArticlesDatabase();
  static Database? _database;

  //init database
  Future<Database?> get database async{
    if(_database != null) return _database;
    _database = await _articlesDatabase.setDatabase();
    return _database;
  }

  //insert something to database
  Future<int> insertData(String table,Map<String,dynamic> data) async{
    Database? db = await database;
    try{
      return await db!.insert(table, data);
    }catch(e){
      return 0;
    }
  }

  //get all data from database
  Future<List<Map<String,dynamic>>> getAllData(table) async{
    Database? db = await database;
    try{
      return db!.query(table);
    }catch(e){
      return [];
    }
  }

  //delete data
  Future<int> deleteArticleData(String table,String publishedAt) async{
    Database? db = await database;
    try{
       await db!.delete(table,where: "publishedAt = ?", whereArgs: [publishedAt]);
      // await db!.delete(table,where: "pill_id = ?", whereArgs: [id]);
       return 1;
    }catch(e){
      return 0;
    }
  }


  Future<bool> articleExists(String table,String published) async {
    Database? db = await database;

   List<Map> maps = await db!.query(table,
        columns: [
          'publishedAt',
        ],
        where: 'publishedAt = ?',
        whereArgs: [published]);
    if (maps.length > 0) {
      return true;
    }
    return false;
}



}