import 'package:aicamera/app/core/app_size_config.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      AppSize(),
    );
  }
}
