import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:payble_flutter_test/controllers/product_controller.dart';
import 'package:payble_flutter_test/custom_widgets/buttons.dart';
import 'package:payble_flutter_test/custom_widgets/snackbar.dart';
import 'package:payble_flutter_test/helpers/amount_formatter.dart';
import 'package:payble_flutter_test/helpers/consts.dart';
import 'package:payble_flutter_test/models/product_model.dart';
import 'package:get/get.dart';
import 'package:payble_flutter_test/views/add_new_product_page.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail(
      {super.key, required this.product, required this.productController});

  final Product product;
  final ProductController productController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                  color: Colors.grey.withOpacity(0.3),
                )),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(
                  top: 30, right: BODY_PADDING, left: BODY_PADDING),
              children: [
                Container(
                  height: 200.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Colors.grey.withOpacity(0.3), width: 0.4),
                    color: Colors.white,
                    image: product.image == null || product.image == ''
                        ? const DecorationImage(
                        image: AssetImage(
                            "assets/images/product_placeholder.png"),
                        fit: BoxFit.contain)
                        : DecorationImage(
                        image: FileImage(File(product.image!)),
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
                            fontWeight: FontWeight.w700, fontSize: 25.sp),
                      ),
                    ),
                    Expanded(
                      child: Text.rich(
                          TextSpan(children: [
                            const TextSpan(text: "Quantity: "),
                            TextSpan(
                                text: "${product.quantity} Pieces",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600)),
                          ]),
                          textAlign: TextAlign.end),
                    ),
                  ],
                ),
                const Divider(),
                tiny5VerticalSpace(),
                Text(
                  product.description.toString(),
                  style:
                  TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
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
                              fontWeight: FontWeight.w500, fontSize: 18.sp),
                        )),
                    Expanded(
                        child: Text(
                          formatAmount(product.sellingPrice),
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20.sp),
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
                              fontWeight: FontWeight.w500, fontSize: 18.sp),
                        )),
                    Expanded(
                        child: Text(
                          formatAmount(product.costPrice),
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20.sp),
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

                        productController.deleteProduct(product);
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
    );
  }
}
