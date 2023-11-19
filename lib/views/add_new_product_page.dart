import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:payble_flutter_test/amount_formatter.dart';
import 'package:payble_flutter_test/consts.dart';
import 'package:payble_flutter_test/controllers/product_controller.dart';
import 'package:payble_flutter_test/main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payble_flutter_test/theme.dart';
import 'package:payble_flutter_test/validator.dart';
import 'package:payble_flutter_test/views/widget/buttons.dart';
import 'package:payble_flutter_test/views/widget/text_input_field.dart';

class AddNewProductScreen extends StatelessWidget {
  AddNewProductScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final productController = Get.put(ProductController());

  void onAddProductScreenPress() {
    productController.handleAddButton(4);
  }

  @override
  Widget build(BuildContext context) {
    if (Get.arguments != null) {
      var args = Get.arguments;
      print(args);
      productController.nameController.value.text = args.name;
      productController.descriptionController.value.text = args.description;
      productController.costPriceController.value.text =
          args.costPrice.toString();
      productController.sellingPriceController.value.text =
          args.sellingPrice.toString();
      productController.quantityController.value.text =
          args.quantity.toString();
      productController.imagePath.value = args.image;
    }
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: 5.0, horizontal: BODY_PADDING),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: const Padding(
                      padding: EdgeInsets.all(3.0),
                      child: Icon(Icons.arrow_back_ios_rounded, size: 20),
                    ),
                  ),
                  smallHorizontalSpace(),
                  Text(
                    'Add New Product',
                    style: TextStyle(fontSize: 18.sp),
                  )
                ],
              ),
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: BODY_PADDING)
                      .copyWith(top: 20),
                  children: [
                    TextInputForm(
                      hint: "Product name",
                      controller: productController.nameController.value,
                      validator: (value) => FieldValidator.validate(value),
                    ),
                    TextInputForm(
                        hint: "Quantity",
                        validator: (value) => FieldValidator.validate(value),
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: productController.quantityController.value),
                    TextInputForm(
                      hint: "Cost price",
                      keyboardType: TextInputType.phone,
                      prefixText: "₦",
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CustomTextInputFormatter()
                      ],
                      validator: (value) => FieldValidator.validate(value),
                      controller: productController.costPriceController.value,
                    ),
                    TextInputForm(
                      hint: "Selling price",
                      prefixText: "₦",
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CustomTextInputFormatter()
                      ],
                      validator: (value) => FieldValidator.validate(value),
                      controller:
                          productController.sellingPriceController.value,
                    ),
                    TextInputForm(
                      hint: "Product description",
                      maxLines: 5,
                      controller: productController.descriptionController.value,
                      validator: (value) => FieldValidator.validate(value),
                    ),
                    tinyVerticalSpace(),
                    Obx(
                      () => Center(
                        child: Stack(
                          children: [
                            Container(
                              height: height() * 0.2,
                              width: height() * 0.2,
                              decoration: productController.imagePath.value ==
                                      ""
                                  ? BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey, width: 0.8),
                                      borderRadius: BorderRadius.circular(5.0))
                                  : BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      image: DecorationImage(
                                          image: FileImage(File(
                                              productController
                                                  .imagePath.value)),
                                          fit: BoxFit.contain),
                                      border: Border.all(
                                          color: Colors.grey, width: 0.8)),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              child: Center(
                                child: InkWell(
                                  onTap: productController.getImage,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.add_photo_alternate),
                                      tinyVerticalSpace(),
                                      Text(
                                        productController.imagePath.value == ""
                                            ? "Select image"
                                            : 'Change image',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            if (productController.imagePath.value != "")
                              Positioned(
                                top: 0,
                                right: -10,
                                child: IconButton(
                                  onPressed: productController.removeImage,
                                  icon: Icon(
                                    Icons.cancel,
                                    size: 30,
                                    color: Colors.grey.withOpacity(0.7),
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                    verticalSpace(0.03),
                    DefaultButton(
                      onTap: () {
                        _formKey.currentState!.validate()
                            ? Get.bottomSheet(
                                SizedBox(
                                  height: height() * 0.5,
                                  child: Column(
                                    children: [
                                      tinyVerticalSpace(),
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: InkWell(
                                            onTap: () => Get.back(),
                                            child: Container(
                                              width: width() * 0.3,
                                              height: 5,
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                            )),
                                      ),
                                      Expanded(
                                        child: ListView(
                                          padding: EdgeInsets.only(
                                              top: 30,
                                              right: BODY_PADDING + 10,
                                              left: BODY_PADDING + 10),
                                          children: [
                                            const Icon(Icons.info,
                                                color: AppColors.wanningColor,
                                                size: 80),
                                            smallVerticalSpace(),
                                            Text(
                                              'Confirm',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 30.sp),
                                            ),
                                            tiny5VerticalSpace(),
                                            Text(
                                                'Are you sure you want to add this product?',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18.sp)),
                                            mediumVerticalSpace(),
                                            Column(
                                              children: [
                                                DefaultButton(
                                                    title: "Continue",
                                                    onTap: () {
                                                      Get.back();

                                                      onAddProductScreenPress();
                                                    }),
                                                smallVerticalSpace(),
                                                TransparentButton(
                                                  title: "Cancel",
                                                  color: Colors.redAccent,
                                                  onTap: Get.back,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                isScrollControlled: true,
                                backgroundColor: AppColors.backgroundColor,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20))))
                            : null;
                      },
                      title: "Add Product",
                    ),
                    mediumVerticalSpace(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
