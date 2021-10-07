import 'dart:convert';

import 'package:aicamera/app/constant/enum.dart';
import 'package:aicamera/app/constant/string.dart';
import 'package:aicamera/app/core/service/storage_service/shared_preference.dart';
import 'package:aicamera/app/data/model/setting_model.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  Settings setting = Settings(logoImage: '', logoPosition: '');
  RxBool alignmentChange = false.obs;
  //use to check if there is logo selected or not in ui
  RxBool islogo = false.obs;

  //this will give your the direction of logo
  LogoDirection logoDir = LogoDirection.topleft;
  //this variable controll the ui where logo should be located
  RxBool logopositionchange = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadingDatabase();
  }

  loadingDatabase() async {
    var data = await shareprefrence.read(AppString.setting);

    if (data.isNotEmpty) {
      var val = json.decode(data);

      Settings se = Settings.fromJson(val);
      setting =
          Settings(logoImage: se.logoImage, logoPosition: se.logoPosition);
      if (setting.logoImage.isNotEmpty) {
        islogo.value = true;
        logoDir = updateAlignment(setting.logoPosition);
        logopositionchange.value = true;
      }
    } else {
      islogo.value = false;
      setting.logoPosition = 'Top left';
      logoDir = updateAlignment(setting.logoPosition);
      setting.logoImage = "";
      updateSetting();
    }
  }

  updateSetting() async {
    islogo.value = false;
    await shareprefrence.save(AppString.setting, setting.toJson());
    alignmentChange.toggle();
    islogo.value = true;
  }

  updateAlignment(String location) {
    switch (location) {
      case "Top Left":
        return LogoDirection.topleft;
      case "Top Right":
        return LogoDirection.topright;
      case "Bottom Left":
        return LogoDirection.bottomleft;
      default:
        return LogoDirection.bottomright;
    }
  }

  removeSettings() async {
    setting = Settings(logoImage: '', logoPosition: '');
    shareprefrence.remove(AppString.setting);
  }
}
