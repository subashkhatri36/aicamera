import 'dart:io';

import 'package:aicamera/app/constant/constants.dart';
import 'package:aicamera/app/constant/controller.dart';
import 'package:aicamera/app/constant/enum.dart';
import 'package:aicamera/app/constant/themes.dart';
import 'package:aicamera/app/modules/home/controllers/home_controller.dart';
import 'package:aicamera/app/widget/button/button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hcontroller = Get.find<HomeController>();
    print("logo image " + appController.setting.logoImage);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(
              () => appController.islogo.value &&
                      (hcontroller.logoImageFile != null ||
                          appController.setting.logoImage.isNotEmpty)
                  ? Center(
                      child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                      ),
                      width: 100,
                      height: 100,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                        child: hcontroller.logoImageFile == null
                            ? Image.file(File(appController.setting.logoImage))
                            : Image.file(File(hcontroller.logoImageFile!.path),
                                height: 150, width: 150, fit: BoxFit.fill),
                      ),
                    ))
                  : appController.setting.logoImage.isNotEmpty
                      ? ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                          child: Image.file(
                              File(
                                appController.setting.logoImage,
                              ),
                              height: 150,
                              width: 150,
                              fit: BoxFit.fill),
                        )
                      : CircleAvatar(
                          radius: Constant.defaultmargin * 3,
                          //  size:constant.defaultfontsize
                          backgroundColor: Themes.grey,
                          child: Text(
                            'Logo',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.white),
                          )),
            ),
            const SizedBox(
              height: Constant.defaultmargin,
            ),
            Obx(() => appController.alignmentChange.value
                ? const LogoAlighmentDisplay()
                : const LogoAlighmentDisplay()),
            const SizedBox(
              height: Constant.defaultmargin,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .5,
                  child: CustomButton(
                    backgroundColor: Colors.red,
                    label: 'Remove Logo',
                    onPressed: () {
                      hcontroller.logoImageFile = null;
                      appController.islogo.value = false;
                      appController.setting.logoImage = '';
                      appController.setting.logoPosition = "Top Left";
                      appController.removeSettings();
                    },
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .5,
                  child: CustomButton(
                    backgroundColor: Colors.blue,
                    label: 'Change Logo',
                    onPressed: () async {
                      await hcontroller.getLogoImage();
                      if (hcontroller.logoImageFile != null) {
                        appController.setting.logoImage =
                            hcontroller.logoImageFile!.path;
                      }
                      if (appController.setting.logoPosition.isEmpty) {
                        appController.setting.logoPosition = 'Top Left';
                      }
                      appController.updateSetting();
                    },
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .5,
                  child: CustomButton(
                    backgroundColor: Colors.green,
                    label: 'Align Logo',
                    onPressed: () async {
                      bool value = await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                                title:
                                    const Text('Please Select Logo Alignment'),
                                actions: [
                                  Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.all(
                                        Constant.defaultmargin / 2),
                                    child: InkWell(
                                      onTap: () {
                                        appController.logoDir =
                                            LogoDirection.topleft;
                                        appController.setting.logoPosition =
                                            'Top Left';
                                        appController.updateSetting();
                                        Navigator.of(context).pop(true);
                                      },
                                      child: const Text('Top Left'),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.all(
                                        Constant.defaultmargin / 2),
                                    child: InkWell(
                                      onTap: () {
                                        appController.logoDir =
                                            LogoDirection.topright;
                                        appController.setting.logoPosition =
                                            'Top Right';
                                        appController.updateSetting();
                                        Navigator.of(context).pop(true);
                                      },
                                      child: const Text('Top Right'),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.all(
                                        Constant.defaultmargin / 2),
                                    child: InkWell(
                                      onTap: () {
                                        appController.logoDir =
                                            LogoDirection.bottomleft;
                                        appController.setting.logoPosition =
                                            'Bottom Left';
                                        appController.updateSetting();
                                        Navigator.of(context).pop(true);
                                      },
                                      child: const Text('Bottom Left'),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.all(
                                        Constant.defaultmargin / 2),
                                    child: InkWell(
                                      onTap: () {
                                        appController.logoDir =
                                            LogoDirection.bottomright;
                                        appController.setting.logoPosition =
                                            'Bottom Right';
                                        appController.updateSetting();
                                        Navigator.of(context).pop(true);
                                      },
                                      child: const Text('Bottom Right'),
                                    ),
                                  ),
                                ]);
                          });

                      if (value) {
                        appController.logopositionchange.value = true;
                        appController.logopositionchange.value = false;
                      }
                    },
                    textColor: Colors.white,
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}

class LogoAlighmentDisplay extends StatelessWidget {
  const LogoAlighmentDisplay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hcontroller = Get.find<HomeController>();
    return appController.logoDir == LogoDirection.bottomright
        ? Text(
            'Logo Alignment : Bottom Right',
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(fontWeight: FontWeight.bold),
          )
        : appController.logoDir == LogoDirection.bottomleft
            ? Text(
                'Logo Alignment : Bottom Left',
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(fontWeight: FontWeight.bold),
              )
            : appController.logoDir == LogoDirection.topleft
                ? Text(
                    'Logo Alignment : Top Left',
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(fontWeight: FontWeight.bold),
                  )
                : Text(
                    'Logo Alignment : Top Right',
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(fontWeight: FontWeight.bold),
                  );
  }
}
/*
                   


 */