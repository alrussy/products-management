

import 'package:alrussy_store/core/service_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LocalController extends GetxController{
  late String lang=Get.locale!.languageCode;
  Locale? locale;
  ServiceApp serviceApp =Get.find();

  void changeLanguage(String lang){
    this.lang=lang;
    serviceApp.sharedPreferences!.setString('lang',lang);
    locale=Locale(lang);
   Get.updateLocale(locale!);
  }

  @override
  void onInit() {
    if(serviceApp.sharedPreferences!.getString('lang')==null){
      locale=Get.deviceLocale!;
    }
    else
    locale=Locale(serviceApp.sharedPreferences!.getString('lang')!);
    super.onInit();
  }

}