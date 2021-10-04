import 'dart:io';
import 'dart:typed_data';

import 'package:aicamera/app/constant/enum.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ui' as ui;

class HomeController extends GetxController {
  static HomeController homecontroller = Get.find();

  //repaint boundary
  GlobalKey screenshotKey = GlobalKey();

  ///camera controller
  CameraController? controller;

  Future<void>? initializeControllerFuture;

  List<CameraDescription> cameras = [];

  bool isCameraInitialized = false;

  //working for flash
  late AnimationController flashModeControlRowAnimationController;
  late Animation<double> flashModeControlRowAnimation;

  ///image choose to switch camera preview with capture image
  RxBool imageClicked = false.obs;

//file to sore image
  XFile? cameraimageFile;

  ///this variable store logo image that will be generated form setting tab
  XFile? logoImageFile;

  ///this variable will store converted both logo and capture image
  File? logowithImage;

  //this will give your the direction of logo
  LogoDirection logoDir = LogoDirection.topleft;
  //this variable controll the ui where logo should be located
  RxBool logopositionchange = false.obs;
  Uint8List? pngBytes;
  //image picker
  final ImagePicker picker = ImagePicker();

//use to check if there is logo selected or not in ui
  RxBool islogo = false.obs;
  //this variable will identify if logo is attached along with image or not
  RxBool islogoattached = false.obs;
  //this varaible will remind if image is clicked or not
  RxBool isImageClicked = false.obs;

//zoom size defined
  double minAvailableZoom = 1.0;
  double maxAvailablezoom = 1.0;
  double currentScale = 1.0;
  double baseScale = 1.0;
//time defined
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  ///counting pointers(number of user fingers on screen)
  int pointers = 0;

  ///It will help to show the front camera is on or not
  RxBool isFrontCamera = false.obs;

  @override
  void onClose() {}
  //flash button pressed
  void onFlashModeButtonPressed() {
    if (flashModeControlRowAnimationController.value == 1) {
      flashModeControlRowAnimationController.reverse();
    } else {
      flashModeControlRowAnimationController.forward();
      // Future.delayed(const Duration(seconds: 200));
      // flashModeControlRowAnimationController.reverse();
    }
  }

//this method use to  capture and save with logo and assign all to its local variable
  savedImageIntoPath() async {
    //https://www.kindacode.com/article/how-to-programmatically-take-screenshots-in-flutter/
    RenderRepaintBoundary boundary = screenshotKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary;

    ui.Image image = (await boundary.toImage());
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    pngBytes = byteData!.buffer.asUint8List();
    isImageClicked.value = false;
  }

//it help to pick image from local device
  Future getLogoImage() async {
    try {
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      logoImageFile = pickedFile;
      islogo.value = true;
    } catch (e) {
      print('error');
    }
    // setState(() {
    //   _watermarkImage = File(pickedFile.path);
    // });
  }

  /// Returns a suitable camera icon for [direction].
  IconData getCameraLensIcon(CameraLensDirection direction) {
    switch (direction) {
      case CameraLensDirection.back:
        return Icons.camera_rear;
      case CameraLensDirection.front:
        return Icons.camera_front;
      case CameraLensDirection.external:
        return Icons.camera;
      default:
        throw ArgumentError('Unknown lens direction');
    }
  }

//it will help to set the flash mode
  Future<void> setFlashMode(FlashMode mode) async {
    if (controller == null) {
      return;
    }
    try {
      await controller!.setFlashMode(mode);
    } on CameraException catch (e) {
      print(e);
      // customSnackbar(
      //     message: 'Cannot Appicable', snackPosition: SnackPosition.TOP);
      //rethrow;
    }
  }

//merge with logo and display in screen
  Future<void> mergingImageWithLogo() async {
    islogoattached.value = true;
  }

  void logError(String code, String? message) {
    if (message != null) {
      //  print('Error: $code\nError Message: $message');
    } else {
      //print('Error: $code');
    }
  }
}
