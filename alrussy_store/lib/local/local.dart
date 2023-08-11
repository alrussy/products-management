import 'package:get/get.dart';

class MyLocal implements Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        "en": {
          'name_app': 'Alrussy ِStore App',
          "lang": 'language',
          'langChoose': 'English',
          "title_lang_setting": "Language Setting",
          'home_app_bar_title': 'Home',
          'home_text_hint_search': 'search here',
          'bnb_label_home': 'Home',
          'bnb_label_fav': 'Favorite',
          'bnb_label_set': 'setting',
          'login_text_field_label_uname': 'User Name',
          'login_text_field_label_upassword': 'Password',
          'login_text_welcome': 'Welcome Back',
          'login_checkbox_text_showPassword': 'Show Password',
          'login_checkbox_text_rememberMy': 'Remember My',
        'home-page-title-appBar': 'Products',
          'home-page-title-listCategory':'Categories',
              'home-page-text-changeShow':'change Show product',
  'add-product-page-title-appBar':'Add Product'


},
        "ar": {
          "name_app": 'تطبيق متجر الروسي',
          "lang": 'اللغة',
          "langChoose": 'العربية',
          "title_lang_setting": 'اعدادات اللغة ',
          'home_app_bar_title': 'الصفحة الرئيسية',
          'home_text_hint_search': 'ابحث هنا',
          'bnb_label_home': 'الرئيسية',
          'bnb_label_fav': 'المفضلة',
          'bnb_label_set': 'الاعدادات',
          'login_text_label_uname': 'اسم المستخدم',
          'login_text_label_upassword': 'كلمة المرور',
          'login_text_welcome': 'مرحبا',
          'login_checkbox_text_showPassword': 'اضهار كلمة السر',
          'login_checkbox_text_rememberMy': 'تذكرني',
  'home-page-title-appBar':'المنتجات',
          'home-page-title-listCategory':'التصنيفات',
          'home-page-text-changeShow':'تغيير عرض المنتجات الى افقي',
              'add-product-page-title-appBar':'اضافة المنتج'
        }
      };
}
