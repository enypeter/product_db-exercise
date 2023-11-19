import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payble_flutter_test/amount_formatter.dart';
import 'package:payble_flutter_test/consts.dart';
import 'package:payble_flutter_test/controllers/product_controller.dart';
import 'package:payble_flutter_test/main.dart';
import 'package:payble_flutter_test/models/product_model.dart';
import 'package:payble_flutter_test/theme.dart';
import 'package:payble_flutter_test/views/add_new_product_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payble_flutter_test/views/widget/buttons.dart';
import 'package:payble_flutter_test/views/widget/snackbar.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddNewProductScreen()),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: 5.0, horizontal: BODY_PADDING),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'All Product',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      padding: const EdgeInsets.all(12),
                      child: const Icon(
                        Icons.search,
                        size: 20,
                      )),
                  tiny5HorizontalSpace(),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      padding: const EdgeInsets.all(12),
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                        size: 20,
                      )),
                ],
              ),
            ),
            tinyVerticalSpace(),
            Expanded(
              child: GetX<ProductController>(
                builder: (productController) {
                  if (productController.products.isEmpty) {
                    return Center(
                      child: GestureDetector(
                        onTap: () => Get.to(() => AddNewProductScreen()),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.add_circle, size: 45),
                            tinyVerticalSpace(),
                            const Text(
                                "You do not have any product\nClick to add product",
                                textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return ListView.separated(
                      separatorBuilder: (context, index) =>
                          smallVerticalSpace(),
                      padding: EdgeInsets.symmetric(horizontal: BODY_PADDING),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        Product product = productController.products[index];
                        return Dismissible(
                          background: Container(
                            decoration: BoxDecoration(
                              color: Colors.red[100],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.delete_outline,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                  tiny5VerticalSpace(),
                                  const Text(
                                    "Delete",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                          direction: DismissDirection.startToEnd,
                          confirmDismiss: (direction) {
                            return Get.bottomSheet(
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
                                            const Icon(Icons.warning,
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
                                                    title: "Delete",
                                                    color: Colors.redAccent,
                                                    onTap: () {
                                                      Get.back();

                                                      productController
                                                          .deleteProduct(
                                                              product);
                                                      CustomSnack().showSnackBar(
                                                          "Deleted!",
                                                          "${product.name} has been deleted",
                                                          SnackType.error);
                                                    }),
                                                smallVerticalSpace(),
                                                TransparentButton(
                                                  title: "Cancel",
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
                                        top: Radius.circular(20))));
                          },
                          key: UniqueKey(),
                          child: InkWell(
                            splashColor: AppColors.backgroundColor,
                            onLongPress: () {
                              Get.to(
                                AddNewProductScreen(),
                                arguments: product,
                              );
                            },
                            onTap: () {
                              Get.bottomSheet(
                                  SizedBox(
                                    height: height() * 0.7,
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
                                                color: Colors.grey
                                                    .withOpacity(0.3),
                                              )),
                                        ),
                                        Expanded(
                                          child: ListView(
                                            padding: EdgeInsets.only(
                                                top: 30,
                                                right: BODY_PADDING,
                                                left: BODY_PADDING),
                                            children: [
                                              Container(
                                                height: 200.h,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: Colors.grey
                                                          .withOpacity(0.3),
                                                      width: 0.4),
                                                  color: Colors.white,
                                                  image: product.image ==
                                                              null ||
                                                          product.image == ''
                                                      ? const DecorationImage(
                                                          image: AssetImage(
                                                              "assets/images/product_placeholder.png"),
                                                          fit: BoxFit.contain)
                                                      : DecorationImage(
                                                          image: FileImage(File(
                                                              product.image!)),
                                                          fit: BoxFit.contain),
                                                ),
                                              ),
                                              smallVerticalSpace(),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      product.name,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 25.sp),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text.rich(
                                                        TextSpan(children: [
                                                          const TextSpan(
                                                              text:
                                                                  "Quantity: "),
                                                          TextSpan(
                                                              text:
                                                                  "${product.quantity} Pieces",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      20.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                        ]),
                                                        textAlign:
                                                            TextAlign.end),
                                                  ),
                                                ],
                                              ),
                                              const Divider(),
                                              tiny5VerticalSpace(),
                                              Text(
                                                product.description.toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16.sp),
                                              ),
                                              tiny5VerticalSpace(),
                                              const Divider(),
                                              tinyVerticalSpace(),
                                              Row(
                                                children: [
                                                  Expanded(
                                                      child: Text(
                                                    'Selling Price',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 18.sp),
                                                  )),
                                                  Expanded(
                                                      child: Text(
                                                    formatAmount(
                                                        product.sellingPrice),
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 20.sp),
                                                  )),
                                                ],
                                              ),
                                              tinyVerticalSpace(),
                                              Row(
                                                children: [
                                                  Expanded(
                                                      child: Text(
                                                    'Cost Price',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 18.sp),
                                                  )),
                                                  Expanded(
                                                      child: Text(
                                                    formatAmount(
                                                        product.costPrice),
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 20.sp),
                                                  )),
                                                ],
                                              ),
                                              mediumVerticalSpace(),
                                              Row(
                                                children: [
                                                  TransparentButton(
                                                    title: "Delete",
                                                    color: Colors.redAccent,
                                                    onTap: () {
                                                      Get.back();

                                                      productController
                                                          .deleteProduct(
                                                              product);
                                                      CustomSnack().showSnackBar(
                                                          "Deleted!",
                                                          "${product.name} has been deleted",
                                                          SnackType.error);
                                                    },
                                                  ),
                                                  tinyHorizontalSpace(),
                                                  Expanded(
                                                      child: DefaultButton(
                                                    title: "Edit",
                                                    onTap: () {
                                                      Get.back();
                                                      Get.to(
                                                        AddNewProductScreen(),
                                                        arguments: product,
                                                      );
                                                    },
                                                  )),
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
                                          top: Radius.circular(20))));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.horizontal(
                                      right: Radius.circular(100.r),
                                      left: const Radius.circular(10)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        offset: const Offset(2, 2),
                                        blurRadius: 2,
                                        spreadRadius: 2)
                                  ],
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.3),
                                      width: 0.4)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            product.name,
                                            style: TextStyle(
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          tiny5VerticalSpace(),
                                          Text(
                                            product.description ?? '',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 13.sp,
                                                color: Colors.grey),
                                          ),
                                          tinyVerticalSpace(),
                                          Text(
                                            "Qty: ${product.quantity} pcs",
                                            style: TextStyle(
                                                color: AppColors.primaryColor,
                                                fontSize: 14.sp),
                                          ),
                                          tinyVerticalSpace(),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                formatAmount(
                                                    product.sellingPrice),
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontSize: 20.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              tiny5VerticalSpace(),
                                              Text(
                                                '(${formatAmount(product.costPrice)})',
                                                style:
                                                    TextStyle(fontSize: 14.sp),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  tiny5HorizontalSpace(),
                                  Container(
                                    width: width() * 0.3,
                                    height: 160.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.grey.withOpacity(0.3),
                                          width: 0.4),
                                      color: Colors.white,
                                      image: product.image == null ||
                                              product.image == ''
                                          ? const DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/product_placeholder.png"),
                                              fit: BoxFit.contain)
                                          : DecorationImage(
                                              image: FileImage(
                                                  File(product.image!)),
                                              fit: BoxFit.contain),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: productController.products.length,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
