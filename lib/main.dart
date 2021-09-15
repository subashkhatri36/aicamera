import 'package:aicamera/app/constant/string.dart';
import 'package:aicamera/app/constant/themes.dart';
import 'package:aicamera/inital_binding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    GetMaterialApp(
      title: AppString.appName,
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      defaultTransition: Transition.native,
      initialBinding: InitialBinding(),
      builder: EasyLoading.init(),
    ),
  );
}
