import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:payble_flutter_test/controllers/product_controller.dart';
import 'package:payble_flutter_test/custom_widgets/buttons.dart';
import 'package:payble_flutter_test/custom_widgets/snackbar.dart';
import 'package:payble_flutter_test/helpers/consts.dart';
import 'package:payble_flutter_test/helpers/theme.dart';
import 'package:payble_flutter_test/models/product_model.dart';

class DeleteModal extends StatelessWidget {
  const DeleteModal(
      {super.key, required this.product, required this.productController});

  final Product product;
  final ProductController productController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                  color: Colors.grey.withOpacity(0.3),
                )),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(
                  top: 30, right: BODY_PADDING + 10, left: BODY_PADDING + 10),
              children: [
                const Icon(Icons.warning,
                    color: AppColors.wanningColor, size: 80),
                smallVerticalSpace(),
                Text(
                  'Confirm',
                  textAlign: TextAlign.center,
                  style:
                  TextStyle(fontWeight: FontWeight.w700, fontSize: 30.sp),
                ),
                tiny5VerticalSpace(),
                Text('Are you sure you want to add this product?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 18.sp)),
                mediumVerticalSpace(),
                Column(
                  children: [
                    DefaultButton(
                        title: "Delete",
                        color: Colors.redAccent,
                        onTap: () {
                          Get.back();

                          productController.deleteProduct(product);
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
    );
  }
}
