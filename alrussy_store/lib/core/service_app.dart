



import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceApp extends GetxService{
  SharedPreferences? sharedPreferences;
Future<ServiceApp> init()async{
  sharedPreferences=await SharedPreferences.getInstance();
  return this;
}

}

