


import 'dart:io';

import 'package:alrussy_store/data/data-local.dart';
import 'package:alrussy_store/model/images_product.dart';
import 'package:alrussy_store/model/product.dart';
import 'package:alrussy_store/service/product_service.dart';
import 'package:alrussy_store/view/add-product/add_product_page.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  var local=Get.deviceLocale!.languageCode;
  List<Product> productsData=[];
  List<Product> productsBycat=[];
  ProductService productService=ProductService();
  String textButton='افقي';
  int show=0;
  int selected=0;

  getAllData()async{
    var response=await productService.findAll();
    if(response.isNotEmpty){
      productsData.clear();
      productsData=response;
      }
    update();

  }
  deleteAllData(id)async{
    var response=await productService.delete(id);
    update();

  }

  getDataBycategory(catId)async {
    productsData.clear();
    if (catId != 0) {
      var response = await productService.findBcategoryId(catId);
      if (response.isNotEmpty) {
        productsData = response;
      }
    }
      else {
        await getAllData();
      }
      update();
  }


  goToAddproductPage()async{
   var result= await Get.to(AddProductPage());
      await getAllData();
      selected=0;
        update();
  }
  File getImageFile(path){
    return File(path);
  }
  changeShow(){
    if(show==0){
      textButton='عمودي';
      show=1;}
    else{
    textButton='افقي';
      show=0;}
    print(show);
    update();
  }
  selectedCategory(id){

    selected=id;
    update();
  }
@override
  void onInit()async {
    // TODO: implement onInit
    super.onInit();
    await getAllData();
  }

}