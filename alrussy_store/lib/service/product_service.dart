


import 'package:alrussy_store/db/products_db.dart';
import 'package:alrussy_store/model/images_product.dart';
import 'package:alrussy_store/model/product.dart';

class ProductService{
  ProductsDb productDb =ProductsDb();

  Future<int> insert(Product product,List<String> images)async{
    var respcheck=await productDb.findAll(sql: '''SELECT * FROM product WHERE name ="${product.name}";''');
    if(respcheck.isEmpty) {
      var response = await productDb.insert(
          sql: '''INSERT INTO product(name, store,price,catId) VALUES("${product
              .name}" , "${product.store}" ,"${product.price}", "${product
              .catId}");''');
      if (images.isNotEmpty)
        for (String img in images) {
          var response2 = await productDb.insert(
              sql: '''INSERT INTO images(path,productId ) VALUES("$img" , "$response");''');
        }
      return response;
    }
    else{
      return -1;
    }
  }

  Future<int> delete(int id)async{
    var response=await productDb.delete(sql:'''DELETE FROM product WHERE id ="$id";''');
    var response2=await productDb.delete(sql:'''DELETE FROM images WHERE productId ="$id";''');
    return  response;
  }

  Future<List<Product>> findAll()async{
    List<Product> productsData=[];
    var response=await productDb.findAll(sql: '''SELECT * FROM product''');
    if(response.isNotEmpty){
      for(var prod in response){
       Product product=Product.fromJson(prod);
        var response2=await productDb.findAll(sql: '''SELECT * FROM images WHERE productId = ${product.id} ''');
        print(response2);
        if(response2.isNotEmpty)
          for(var img in response2) {
            product.addImage(ImagesProduct.fromJson(img));
          }
        productsData.add(product);
      }
    }
      return  productsData;


          }

  Future<List<Product>> findBcategoryId(int catId)async{
    List<Product> productsData=[];
    var response=await productDb.findAll(sql: '''SELECT * FROM product WHERE catId = ${catId}''');
    if(response.isNotEmpty){
      for(var prod in response){
        Product product=Product.fromJson(prod);
        var response2=await productDb.findAll(sql: '''SELECT * FROM images WHERE productId = ${product.id} ''');
        print(response2);
        if(response2.isNotEmpty)
          for(var img in response2) {
            product.addImage(ImagesProduct.fromJson(img));
          }
        productsData.add(product);
      }
    }
    return  productsData;


  }
}