import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:payble_flutter_test/controllers/product_controller.dart';
import 'package:payble_flutter_test/helpers/theme.dart';
import 'package:payble_flutter_test/views/product_list_screen.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (context, _) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: Platform.isIOS
            ? () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus &&
                    currentFocus.focusedChild != null) {
                  FocusManager.instance.primaryFocus?.unfocus();
                }
              }
            : null,
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Payble Flutter Engr',
          onInit: () {
            Get.put(ProductController());
          },
          theme: ThemeData(
            fontFamily: "Inter",
            primaryColor: AppColors.primaryColor,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
            useMaterial3: true,
          ),
          home: const ProductList(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor, body: const Text("data"));
  }
}

