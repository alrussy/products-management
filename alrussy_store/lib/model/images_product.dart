


class ImagesProduct{

  int? id;
  String? path;
  int? productId;

  ImagesProduct({this.id, this.path,this.productId});

  ImagesProduct.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    path= json['path'];
    productId= json['productId'];
  }

  @override
  String toString() {
    return 'ImagesProduct{id: $id, path: $path, productId: $productId}';
  }
}