

import 'package:alrussy_store/model/images_product.dart';

class Product{

  int? id;
  String? name;
  String? store;
  double? price;
  int? catId;
  List<ImagesProduct> images=[];

  Product({this.id, this.name, this.store, this.price, this.catId});



  Product.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    store = json['store'];
    catId = json['catId'];
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, store: $store, price: $price, catId: $catId, images: $images}';
  }

  void addImage(ImagesProduct imagesProduct){
    images.add(imagesProduct);
  }


}