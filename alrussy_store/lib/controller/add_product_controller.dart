


import 'dart:ffi';
import 'dart:io';

import 'package:alrussy_store/model/product.dart';
import 'package:alrussy_store/service/product_service.dart';
import 'package:alrussy_store/view/home_page/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../db/products_db.dart';

class AddProductController extends GetxController{
  File? imageFile;

  GlobalKey<FormState> keyName=GlobalKey();
  GlobalKey<FormState> keyStore=GlobalKey();
  GlobalKey<FormState> keyPrice=GlobalKey();
  GlobalKey<FormState> keyCategory=GlobalKey();
  TextEditingController nameController=TextEditingController();
  TextEditingController priceController=TextEditingController();
  TextEditingController storeController=TextEditingController();
  FocusNode nameFocusNode=FocusNode();
  FocusNode priceFocusNode=FocusNode();
  FocusNode storeFocusNode=FocusNode();
  FocusNode categoryFocusNode=FocusNode();
  int show=0;

  int? selecteCategory;
  ProductService service =ProductService();
   List<String> paths=[];
   List<File> imageFiles=[];

  insertData()async{
    if(keyName.currentState!.validate())
      if(keyStore.currentState!.validate())
        if(keyPrice.currentState!.validate())
          if(keyCategory.currentState!.validate())
          {
    String name=nameController.text.trim();
    String store=storeController.text.trim();
    double price=priceController.text.trim().isNotEmpty?double.parse(priceController.text.trim()):0;
    int catId=selecteCategory!;

      var response = await service.insert(
          Product(name: name, store: store, price: price, catId: catId), paths);
      if (response > 0) {
        Get.snackbar(
            'تمت الاضافة بنجاح.....', 'لقد قمت باضافة المنتج $response بنجاح ',
            backgroundColor: Colors.white);
        Get.off(HomePage());
      }
      else if (response == -1) {
        Get.defaultDialog(
            title: "قيمة مكررة",
            middleText: 'لم تتم عملية الاضافة للمنتج وذلك لان اسم المنتج موجود مسيقا..!',
            onConfirm: () {
              nameFocusNode.requestFocus();
              Get.back();
            }
        );
      }
    }
    else categoryFocusNode.requestFocus();
      else priceFocusNode.requestFocus();
      else storeFocusNode.requestFocus();
      else nameFocusNode.requestFocus();
    update();
 }

  showGallery()async {
    var result = await ImagePicker.platform.getImageFromSource(source: ImageSource.gallery);
    if (result != null){
      paths.add(result.path);
      imageFiles.add(getImageFile(result.path));
    }
    else
      print('no select');
    update();
  }


onChangeDropDown(val){
    selecteCategory=val;
    print(val);
    update();
}
deleteImage(index){
    imageFiles.removeAt(index);
    update();
}

  File getImageFile(path){
    return File(path);
  }
  }
