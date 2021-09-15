import 'dart:async';

import 'package:aicamera/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onClose() {}
  loadPage() {
    //await readJson() ;
    var _duration = const Duration(seconds: 3);
    Timer(_duration, naviation);
  }

  void naviation() {
    Get.offAndToNamed(Routes.HOME);
  }
}
