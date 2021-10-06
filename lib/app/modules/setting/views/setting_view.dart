import 'dart:io';

import 'package:aicamera/app/constant/constants.dart';
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
              () =>
                  hcontroller.islogo.value && hcontroller.logoImageFile != null
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
                            child: Image.file(
                                File(hcontroller.logoImageFile!.path),
                                height: 100,
                                width: 100,
                                fit: BoxFit.fill),
                          ),
                        ))
                      : controller.setting.logoImage.isNotEmpty
                          ? ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50)),
                              child: Image.file(
                                  File(
                                    controller.setting.logoImage,
                                  ),
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.fill),
                            )
                          : InkWell(
                              onTap: () {
                                hcontroller.getLogoImage();
                              },
                              child: CircleAvatar(
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
            ),
            const SizedBox(
              height: Constant.defaultmargin,
            ),
            Obx(() => hcontroller.logopositionchange.value
                ? const LogoAlighmentDisplay()
                : const LogoAlighmentDisplay()),
            const SizedBox(
              height: Constant.defaultmargin,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  label: 'Remove Logo',
                  onPressed: () {
                    hcontroller.logoImageFile = null;
                    hcontroller.islogo.value = false;
                    controller.setting.logoImage = '';
                    controller.setting.logoPosition = "Top Left";
                    controller.update();
                  },
                  textColor: Colors.white,
                ),
                CustomButton(
                  label: 'Change Logo',
                  onPressed: () {
                    hcontroller.getLogoImage();
                    if (hcontroller.logoImageFile!.path.isNotEmpty) {
                      controller.setting.logoImage =
                          hcontroller.logoImageFile!.path;
                    }
                    if (controller.setting.logoPosition.isEmpty) {
                      controller.setting.logoPosition = 'Top Left';
                    }
                    controller.updateSetting();
                  },
                  textColor: Colors.white,
                ),
                CustomButton(
                  label: 'Align Logo',
                  onPressed: () async {
                    bool value = await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              title: const Text('Please Select Logo Alignment'),
                              actions: [
                                Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.all(
                                      Constant.defaultmargin / 2),
                                  child: InkWell(
                                    onTap: () {
                                      hcontroller.logoDir =
                                          LogoDirection.topleft;
                                      controller.setting.logoPosition =
                                          'Top Left';
                                      controller.updateSetting();
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
                                      hcontroller.logoDir =
                                          LogoDirection.topright;
                                      controller.setting.logoPosition =
                                          'Top Right';
                                      controller.updateSetting();
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
                                      hcontroller.logoDir =
                                          LogoDirection.bottomleft;
                                      controller.setting.logoPosition =
                                          'Bottom Left';
                                      controller.updateSetting();
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
                                      hcontroller.logoDir =
                                          LogoDirection.bottomright;
                                      controller.setting.logoPosition =
                                          'Bottom Right';
                                      controller.updateSetting();
                                      Navigator.of(context).pop(true);
                                    },
                                    child: const Text('Bottom Right'),
                                  ),
                                ),
                              ]);
                        });

                    if (value) {
                      hcontroller.logopositionchange.value = true;
                      hcontroller.logopositionchange.value = false;
                    }
                  },
                  textColor: Colors.white,
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
    return hcontroller.logoDir == LogoDirection.bottomright
        ? Text(
            'Logo Alignment : Bottom Right',
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(fontWeight: FontWeight.bold),
          )
        : hcontroller.logoDir == LogoDirection.bottomleft
            ? Text(
                'Logo Alignment : Bottom Left',
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(fontWeight: FontWeight.bold),
              )
            : hcontroller.logoDir == LogoDirection.topleft
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