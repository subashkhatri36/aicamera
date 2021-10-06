import 'package:aicamera/app/constant/string.dart';
import 'package:aicamera/app/core/service/storage_service/shared_preference.dart';
import 'package:aicamera/app/data/model/setting_model.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  String apptitle = 'Settings';
  Settings setting = Settings(logoImage: '', logoPosition: '');
  @override
  void onInit() {
    super.onInit();
    loadingDatabase();
  }

  loadingDatabase() async {
    var data = await shareprefrence.read(AppString.setting);
    if (data.isNotEmpty) {
      setting = Settings.fromJson(data);
    } else {
      setting.logoPosition = 'Top left';
      setting.logoImage = "";
      updateSetting();
    }
  }

  updateSetting() async {
    await shareprefrence.save(AppString.setting, setting.toJson());
  }

  removeSettings() async {
    setting = Settings(logoImage: '', logoPosition: '');
    shareprefrence.remove(AppString.setting);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
