import 'package:get/get.dart';
import 'package:payble_flutter_test/helpers/theme.dart';

enum SnackType { success, notice, error }

class CustomSnack {

    showSnackBar(title, message, snackType) => Get.snackbar(title, message,
      leftBarIndicatorColor: _getSnackColor(snackType),snackPosition: SnackPosition.BOTTOM);

_getSnackColor(SnackType snackType) {
    print(snackType);
    switch (snackType) {
      case SnackType.success:
       return AppColors.successColor;
      case SnackType.notice:
        return AppColors.backgroundColor;
      case SnackType.error:
        return  AppColors.errorColor;
    }
  }
}
