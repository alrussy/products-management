
import 'package:alrussy_store/db/products_db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbService {
  static Database? _database;

  Future<Database?> get database async{
    if(_database!=null){
      return _database;
    }
    else{
    _database = await _initialDb();
    return _database;
    }
  }

  Future<String> get fullPath async{
    const name='taskapp.db';
    final path= await getDatabasesPath();
    return join(path,name);
  }

 Future<Database> _initialDb()async {
    final path=await fullPath;
    var database=await openDatabase(path,version:4,onCreate: create,onUpgrade:onUpgrade ,singleInstance:true);
    return database;
 }

 Future<void> create(Database database,int version)async => await ProductsDb().createTable(database);
  Future<void> onUpgrade(Database database,int oldVersion,newVersion)async => await ProductsDb().createTable(database);

}