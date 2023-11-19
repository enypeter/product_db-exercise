import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:payble_flutter_test/db/product_db.dart';
import 'package:payble_flutter_test/models/product_model.dart';
import 'package:payble_flutter_test/views/widget/snackbar.dart';

class ProductController extends GetxController {
  var picker = ImagePicker().obs;
  var products = <Product>[].obs;
  var nameController = TextEditingController().obs;
  var descriptionController = TextEditingController().obs;
  var costPriceController = TextEditingController().obs;
  var sellingPriceController = TextEditingController().obs;
  var quantityController = TextEditingController().obs;
  final showSearchField = false.obs;

  var imagePath = "".obs;

  void getImage() async {
    final pickedFile =
        await picker.value.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
    }
  }

  void removeImage() async {
    imagePath.value = '';
  }

  @override
  void onInit() {
    products.value = [];
    fetchProducts();
    super.onInit();
  }

  fetchProducts() async {
    ProductDatabaseHelper.db
        .getProductList()
        .then((productList) => {products.value = productList});
  }

  void addProduct(Product product) {
    ProductDatabaseHelper.db.insertProduct(product).then((value) {
      print('======> $value');
      products.add(product);
    });
  }

  void deleteProduct(Product product) {
    ProductDatabaseHelper.db
        .deleteProduct(product.id)
        .then((_) => products.remove(product));
  }

  void updateList(Product product) async {
    var result = await fetchProducts();
    if (result != null) {
      final index = products.indexOf(product);
      print(index);
      products[index] = product;
    }
  }

  void updateProduct(Product product) {
    ProductDatabaseHelper.db
        .updateProduct(product)
        .then((value) => updateList(product));
  }

  void handleAddButton(id) {
    if (id != null) {
      var product = Product(
        id: id,
        name: nameController.value.text,
        description: descriptionController.value.text,
        costPrice:
            double.parse(costPriceController.value.text.replaceAll(',', '')),
        sellingPrice:
            double.parse(sellingPriceController.value.text.replaceAll(',', '')),
        image: imagePath.value,
        quantity: quantityController.value.text,
      );
      addProduct(product);
      Get.back();
      CustomSnack().showSnackBar("Successful!",
          "${product.name} added successfully", SnackType.success);
      nameController.value.clear();
      descriptionController.value.clear();
      costPriceController.value.clear();
      sellingPriceController.value.clear();
      quantityController.value.clear();
      imagePath.value = '';
    }
  }

  void toggleShowSearch() {
    showSearchField.value = !showSearchField.value;
  }

  @override
  void onClose() {
    ProductDatabaseHelper.db.close();
    super.onClose();
  }
}
