import 'package:alrussy_store/core/service_app.dart';
import 'package:alrussy_store/local/local.dart';
import 'package:alrussy_store/local/local_controller.dart';
import 'package:alrussy_store/res/colors_app.dart';
import 'package:alrussy_store/view/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await initService();
  runApp(const MyApp());
}
Future initService()async{
  await Get.putAsync(() => ServiceApp().init());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  LocalController controller= Get.put(LocalController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      locale: Get.deviceLocale,
      translations: MyLocal(),
      theme: ThemeData(
          textTheme: TextTheme(
            titleLarge: TextStyle(color: Colors.black,fontSize: 22,fontFamily: 'Cairo-Bold'),
            titleMedium: TextStyle(color: Colors.black,fontSize: 16,fontFamily: 'Cairo-Bold',fontWeight: FontWeight.w600),
              titleSmall: TextStyle(color: Colors.black,fontSize: 12,fontFamily:'Cairo-Medium'),

          ),
          appBarTheme: AppBarTheme(
            centerTitle: true,

            titleTextStyle: Theme.of(context).textTheme.titleLarge,
            iconTheme: Theme.of(context).iconTheme),

        primarySwatch: Colors.blue,


      ),
      home: const HomePage(),
    );
  }
}
