import 'package:get/get.dart';
import 'package:flutter/material.dart';

double BODY_PADDING = 20;

height() => Get.height;

width() => Get.width;

tinyVerticalSpace()=>const SizedBox(height: 10);
tiny5VerticalSpace()=>const SizedBox(height: 5);
smallVerticalSpace()=>const SizedBox(height: 20);
mediumVerticalSpace()=>const SizedBox(height: 30);
verticalSpace(factor)=> SizedBox(height: height()*factor);

tiny5HorizontalSpace()=>const SizedBox(width: 5);
tinyHorizontalSpace()=>const SizedBox(width: 10);
smallHorizontalSpace()=>const SizedBox(width: 20);
mediumHorizontalSpace()=>const SizedBox(width: 30);
horizontalSpace(factor)=> SizedBox(width: width()*factor);