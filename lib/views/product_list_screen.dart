import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payble_flutter_test/helpers/consts.dart';
import 'package:payble_flutter_test/controllers/product_controller.dart';
import 'package:payble_flutter_test/models/product_model.dart';
import 'package:payble_flutter_test/helpers/theme.dart';
import 'package:payble_flutter_test/views/add_new_product_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payble_flutter_test/views/widgets/product_list_item.dart';

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
                        return ProductItem(
                            product: product,
                            productController: productController);
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
