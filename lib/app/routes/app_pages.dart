import 'package:get/get.dart';

import 'package:aicamera/app/modules/home/bindings/home_binding.dart';
import 'package:aicamera/app/modules/home/views/home_view.dart';
import 'package:aicamera/app/modules/imagepreview/bindings/imagepreview_binding.dart';
import 'package:aicamera/app/modules/imagepreview/views/imagepreview_view.dart';
import 'package:aicamera/app/modules/splash/bindings/splash_binding.dart';
import 'package:aicamera/app/modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
  ];
}
