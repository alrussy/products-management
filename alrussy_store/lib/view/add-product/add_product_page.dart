import 'package:alrussy_store/controller/add_product_controller.dart';
import 'package:alrussy_store/view/widget_global/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/data-local.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AddProductController());
    return CustomScaffold(
      icon: Icons.arrow_back_ios_new,
      title: 'add-product-page-title-appBar'.tr,
      child: GetBuilder<AddProductController>(
          builder: (controller) => SingleChildScrollView(
                child: Column(
                  children: [
                    listImagesProduct(context),
                    controller.imageFile != null
                        ? Image.file(
                            controller.imageFile!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.fill,
                          )
                        : const SizedBox.shrink(),
                    customButton(
                        () async => await controller.showGallery(),
                        'اضغط لاضافة صورة',
                        Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .apply(color: Colors.white),
                        Icon(Icons.add_box_rounded)),
                    customTextField(
                        context,
                        'اسم المنتج',
                        controller.nameController,
                        controller.nameFocusNode,
                        TextInputType.name,
                        controller.keyName),
                    customTextField(
                        context,
                        'اسم المتجر',
                        controller.storeController,
                        controller.storeFocusNode,
                        TextInputType.name,
                        controller.keyStore),
                    customTextField(
                        context,
                        'السعر',
                        controller.priceController,
                        controller.priceFocusNode,
                        TextInputType.number,
                        controller.keyPrice),
                    customDropDown(),
                    const SizedBox(
                      height: 30,
                    ),
                    customButton(
                        () async => await controller.insertData(),
                        'اضافة المنتج',
                        Get.theme.textTheme.titleMedium!
                            .apply(color: Colors.white),
                        null),
                  ],
                ),
              )),
      onPressed: () => Get.back(),
    );
  }
}

listImagesProduct(context) {
  return GetBuilder<AddProductController>(
      builder: (controller) => Container(
            alignment: Alignment.centerRight,
            height: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'صور المنتج',
                  style: Get.theme.textTheme.titleMedium,
                ),
                Flexible(
                  child: controller.imageFiles.isEmpty
                      ? Container(
                          child: Icon(
                            Icons.image,
                            color: Colors.grey,
                            size: 40,
                          ),
                          margin: EdgeInsets.only(bottom: 10, top: 5),
                          width: 105,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.imageFiles.length,
                          itemBuilder: (context, index) => Stack(
                                children: [
                                  Container(
                                    clipBehavior: Clip.antiAlias,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 2.5),
                                    child: controller.imageFiles.isNotEmpty
                                        ? Image.file(
                                            controller.imageFiles[index],
                                            height: 160,
                                            width: 105,
                                            fit: BoxFit.fill,
                                          )
                                        : SizedBox.shrink(),
                                    width: 105,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  Positioned(
                                      left: -5,
                                      top: -5,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.cancel,
                                          color: Color(0xffFF4155),
                                          size: 20,
                                        ),
                                        onPressed: () =>
                                            controller.deleteImage(index),
                                      )),
                                ],
                              )),
                ),
              ],
            ),
          ));
}

customButton(fun, label, them, icon) {
  return Container(
    margin: EdgeInsets.only(bottom: 7),
    child: ElevatedButton(
      onPressed: fun,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) icon,
          SizedBox(
            width: 10,
          ),
          Text(
            label,
            style: them,
          ),
        ],
      ),
      style: ButtonStyle(
          backgroundColor:const MaterialStatePropertyAll(Color(0xff3EB86F)),
          elevation:const MaterialStatePropertyAll(0),
          shape: (MaterialStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(10))))),
    ),
    width: Get.width - 50,
    height: 50,
  );
}

customTextField(context, label, textController, focusNode, type, key) {
  return GetBuilder<AddProductController>(
    builder: (controller) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
      child: Form(
        key: key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            TextFormField(
              validator: (value) =>
                  value!.isEmpty ? 'هذا الحقل لا يمكن اين يكون فارغا' : null,
              keyboardType: type,
              controller: textController,
              focusNode: focusNode,
              style: Theme.of(context).textTheme.titleSmall,
              decoration: InputDecoration(
                  isDense: true,
                  contentPadding:const
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  hintText: label,
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 2,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:const BorderSide(color: Colors.green, width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  focusColor: Colors.red),
            )
          ],
        ),
      ),
    ),
  );
}

customDropDown() {
  return GetBuilder<AddProductController>(
      builder: (controller) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
            child: Form(
              key: controller.keyCategory,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'التصنيف',
                    style: Get.theme.textTheme.titleMedium,
                  ),
                  DropdownButtonFormField(
                    validator: (value) =>
                        value == null ? 'يجب اختيار تصنيف' : null,
                    focusNode: controller.categoryFocusNode,
                    style: Get.theme.textTheme.titleSmall,
                    hint: Text('اختر التصنيف',
                        style: Get.theme.textTheme.titleSmall!.apply(
                          color: Colors.indigo,
                        )),
                    icon: const Icon(
                      Icons.arrow_drop_down_circle_outlined,
                      color: Colors.indigo,
                    ),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey,
                              width: 2,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:const BorderSide(color: Colors.green, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      isDense: true,
                      contentPadding:
                         const  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                    items: categories
                        .sublist(1, 4)
                        .map((e) => DropdownMenuItem(
                              child:  Text('${e['name-ar']}'),
                              value: e['id'],
                            ))
                        .toList(),
                    onChanged: (val) => controller.onChangeDropDown(val),
                    value: controller.selecteCategory,
                  )
                ],
              ),
            ),
          ));
}
