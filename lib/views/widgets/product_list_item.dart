import 'dart:io';

import 'package:flutter/material.dart';
import 'package:payble_flutter_test/controllers/product_controller.dart';
import 'package:payble_flutter_test/helpers/amount_formatter.dart';
import 'package:payble_flutter_test/helpers/consts.dart';
import 'package:payble_flutter_test/helpers/theme.dart';
import 'package:payble_flutter_test/models/product_model.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payble_flutter_test/views/add_new_product_page.dart';
import 'package:payble_flutter_test/views/widgets/delete_modal.dart';
import 'package:payble_flutter_test/views/widgets/product_detail_modal.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.product,
    required this.productController,
  });

  final Product product;
  final ProductController productController;

  @override
  Widget build(BuildContext context) {
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
            DeleteModal(
                productController: productController,
                product: product),
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
                () => AddNewProductScreen(),
            arguments: product,
          );
        },
        onTap: () {
          Get.bottomSheet(
              ProductDetail(
                  product: product,
                  productController: productController),
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
  }
}
