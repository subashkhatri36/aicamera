import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSize extends GetxController {
  static AppSize instance = Get.find();
  RxBool islandscape = false.obs;
  RxBool table = false.obs;
  double height = 0.0;
  double width = 0.0;

  void sizeinit(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    islandscape.value = width > 375 ? true : false;
  }
}
