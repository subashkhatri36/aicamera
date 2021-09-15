import 'package:get/get.dart';

import '../controllers/imagepreview_controller.dart';

class ImagepreviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImagepreviewController>(
      () => ImagepreviewController(),
    );
  }
}
