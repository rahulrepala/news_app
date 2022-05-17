import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ArticlesDatabase{

  setDatabase() async{
    String databasePath = await getDatabasesPath();
    String path = join(databasePath,"articles_db");
    Database database = await openDatabase(path,version: 1,onCreate: (Database db,int version)async{
      await db.execute("CREATE TABLE Articles (id INTEGER PRIMARY KEY, author TEXT, title TEXT, description TEXT, url TEXT, urlToImage TEXT, publishedAt TEXT, content TEXT)");
    });
    return database;
  }

}