import 'package:aicamera/app/core/app_size_config.dart';
import 'package:aicamera/app/core/controller/app_controller.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      AppSize(),
    );
    Get.put(AppController(), permanent: true);
  }
}
