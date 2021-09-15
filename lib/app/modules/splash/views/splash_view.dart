import 'package:aicamera/app/constant/controller.dart';
import 'package:aicamera/app/widget/text/normal_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    appsize.sizeinit(context);
    controller.loadPage();
    print(appsize.height);
    return Scaffold(
      body: Center(
          child: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const FlutterLogo(
            size: 30,
            textColor: Colors.red,
          ),
          const NormalText('Opening Camera'),
        ],
      )),
    );
  }
}
