import 'package:alrussy_store/controller/home_controller.dart';
import 'package:alrussy_store/data/data-local.dart';
import 'package:alrussy_store/view/widget_global/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return GetBuilder<HomeController>(
        builder: (controller) => CustomScaffold(
              icon: Icons.add,
              title: 'home-page-title-appBar'.tr,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    categoryList(context),
                    SizedBox(
                      height: 15,
                    ),
                    buttonChangeShowProduct(),
                    SizedBox(
                      height: 20,
                    ),
                    controller.productsData.isNotEmpty
                        ? controller.show == 1
                            ? productListHorizontalWidget()
                            : productListVerticalWidget()
                        : Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                'لا توجد منتجات مضافة \n قم بالضغط على زر اضافة + لاضافة منتجاتك..',
                                textAlign: TextAlign.center,
                                style: Get.theme.textTheme.titleMedium!
                                    .apply(color: Colors.grey.shade500),
                              ),
                            ),
                          ),
                    controller.show == 1
                        ? Expanded(child: SizedBox())
                        : SizedBox.shrink()
                  ]),
              onPressed: () => controller.goToAddproductPage(),
            ));
  }
}

categoryList(context) {
  return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) => Container(
            height: 160,
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10, bottom: 8, top: 10),
                  child: Text('home-page-title-listCategory'.tr,
                      style: TextStyle(
                        fontFamily: 'Cairo-Medium',
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.start),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) => InkWell(
                          onTap: ()async{
                            controller
                                .getDataBycategory(categories[index]['id']);
                            controller
                                .selectedCategory(categories[index]['id']);
                          },
                          child: customCardWidget(
                              context,
                              controller.local == 'ar'
                                  ? categories[index]['name-ar']
                                  : categories[index]['name-en'],
                              categories[index]['image'],
                              categories[index]['id']),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ));
}

customCardWidget(context, name, image, id) {
  var width = Get.width / 4 - 10;
  return GetBuilder<HomeController>(
      builder: (controller) => Container(
            height: 114,
            width: width,
            padding: EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: width - 15,
                  height: 66,
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Color(0xff3EB86F),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: id > 0
                      ? Image.asset(image, fit: BoxFit.fill)
                      : Icon(
                          Icons.dashboard,
                          color: Colors.white,
                        ),
                ),
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                border: id == controller.selected
                    ? Border.all(color: Color(0xff3EB86F), width: 2)
                    : Border.all(color: Color(0xffECECEC)),
                borderRadius: BorderRadius.circular(10)),
          ));
}

productListVerticalWidget() {
  return GetBuilder<HomeController>(
      builder: (controller) => Expanded(
            child: ListView.separated(
              itemCount: controller.productsData.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 114,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child:
                              controller.productsData[index].images.isNotEmpty
                                  ? Image.file(
                                      controller.getImageFile(controller
                                          .productsData[index].images[0].path!),
                                      height: 114,
                                      width: 115,
                                    )
                                  : SizedBox.shrink()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.productsData[index].name!,
                                style: TextStyle(
                                    fontSize: 18, fontFamily: 'Cairo-Medium'),
                              ),
                              Text.rich(TextSpan(
                                  text:
                                      '${controller.productsData[index].price}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xff3EB86F),
                                      fontFamily: 'Cairo-Medium'),
                                  children: [
                                    TextSpan(
                                        text: ' دولار',
                                        style: TextStyle(
                                            fontFamily: 'Cairo-Medium',
                                            color: Color(0xff3E3E68),
                                            fontSize: 12))
                                  ])),
                              Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: Color(0xffEEEEEE),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                      controller.productsData[index].store!,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xffA1A1A1),
                                          fontFamily: 'Cairo-Medium'))),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 20,
                );
              },
            ),
          ));
}

productListHorizontalWidget() {
  var width = Get.width / 4 - 10;
  return GetBuilder<HomeController>(
      builder: (controller) => Expanded(
          child: ListView.separated(
              itemCount: controller.productsData.length,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 20,
                );
              },
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                    width: 120,
                    padding: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              clipBehavior: Clip.antiAlias,
                              height: 120,
                              margin: EdgeInsets.only(left: 5, right: 5),
                              decoration: BoxDecoration(
                                color: Color(0xff3EB86F),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: controller
                                      .productsData[index].images.isNotEmpty
                                  ? Image.file(
                                      controller.getImageFile(controller
                                          .productsData[index].images[0].path!),
                                      height: 150,
                                      width: 120,
                                      fit: BoxFit.fill,
                                    )
                                  : SizedBox.shrink()),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 10),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    controller.productsData[index].name!,
                                    style: TextStyle(
                                        fontSize: 12, fontFamily: 'Cairo-Bold'),
                                  ),
                                  Text.rich(TextSpan(
                                      text:
                                          '${controller.productsData[index].price}',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff3EB86F),
                                          fontFamily: 'Cairo-Bold'),
                                      children: [
                                        TextSpan(
                                            text: ' دولار',
                                            style: TextStyle(
                                                fontFamily: 'Cairo-Medium',
                                                color: Color(0xff3E3E68),
                                                fontSize: 12))
                                      ])),
                                  Text(controller.productsData[index].store!,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xffA1A1A1),
                                          fontFamily: 'Cairo-Bold'))
                                ]),
                          ),
                        ]));
              })));
}

buttonChangeShowProduct() {
  final width = Get.width;
  return GetBuilder<HomeController>(
      builder: (controller) => InkWell(
            onTap: () => controller.changeShow(),
            child: Row(
              children: [
                Expanded(child: SizedBox()),
                Container(
                  height: 36,
                  width: 210,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(
                          Icons.dashboard,
                          color: Color(0xffFF4155),
                        ),
                      ),
                      Text(
                        'تغيير عرض المنتجات الي ${controller.textButton}',
                        style: TextStyle(
                            fontFamily: 'Cairo-Medium',
                            color: Color(0xffFF4155),
                            fontSize: 12),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ],
            ),
          ));
}
