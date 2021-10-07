import 'package:aicamera/app/modules/setting/bindings/setting_binding.dart';
import 'package:aicamera/app/modules/setting/views/setting_view.dart';
import 'package:get/get.dart';

import 'package:aicamera/app/modules/home/bindings/home_binding.dart';
import 'package:aicamera/app/modules/home/views/home_view.dart';
import 'package:aicamera/app/modules/splash/bindings/splash_binding.dart';
import 'package:aicamera/app/modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.setting,
      page: () => const SettingView(),
      binding: SettingBinding(),
    ),
  ];
}
