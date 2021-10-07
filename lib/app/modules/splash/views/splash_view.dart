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
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          FlutterLogo(
            size: 50,
            textColor: Colors.red,
          ),
          SizedBox(
            height: 20,
          ),
          CircularProgressIndicator(),
          SizedBox(
            height: 20,
          ),
          NormalText('Opening Camera'),
        ],
      )),
    );
  }
}
