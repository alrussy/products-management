

import 'package:alrussy_store/db/db_service.dart';
import 'package:sqflite/sqflite.dart';

class ProductsDb{
  final tableName='product';

  Future<void> createTable(Database database)async{
      await database.execute("""
   CREATE TABLE IF NOT EXISTS "product"(
   "id" INTEGER NOT NULL ,
   "name" TEXT,
   "store" TEXT,
   "price" REAL,
   "catId" INTEGER,
   PRIMARY KEY("id" AUTOINCREMENT)
   );
   """);
      await database.execute("""
      CREATE TABLE IF NOT EXISTS "images"(
          "id" INTEGER NOT NULL ,
          "path" TEXT,
          "productId" INTEGER,
          PRIMARY KEY("id" AUTOINCREMENT)
    );
    """);
      print('OnCreate Database name product====' );
    }
  Future<int> insert({required sql})async{
    //deleteDatabase()
    final database=await DbService().database;
    return await database!.rawInsert(sql);
  }
  Future<List<Map>> findAll({required sql})async{
    final database=await DbService().database;
    return await database!.rawQuery(sql);
  }

  Future<int> update({required sql,values})async{
    final database=await DbService().database;
    return await database!.rawUpdate(sql, values);
  }
  Future<int> delete({required sql})async{
    final database=await DbService().database;
    return await database!.rawDelete(sql);
  }
}