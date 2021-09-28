import 'dart:io';
import 'dart:typed_data';

import 'package:aicamera/app/constant/enum.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as ui;

class HomeController extends GetxController {
  static HomeController homecontroller = Get.find();

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
  XFile? logoImageFile;
  File? logowithImage;
  Rx<LogoDirection> logoDir = LogoDirection.topleft.obs;
  //image picker
  final ImagePicker picker = ImagePicker();

  RxBool islogo = false.obs;
  RxBool islogoattached = false.obs;

//zoom size
  double minAvailableZoom = 1.0;
  double maxAvailablezoom = 1.0;
  double currentScale = 1.0;
  double baseScale = 1.0;

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
    }
  }

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
    File originalImage = File(cameraimageFile!.path);
    File logoImage = File(logoImageFile!.path);
    ui.Image? originalImageFile =
        ui.decodeImage(originalImage.readAsBytesSync());
    ui.Image? logoImgFile = ui.decodeImage(logoImage.readAsBytesSync());

    // add watermark over originalImage
    // initialize width and height of watermark image
    ui.Image image = ui.Image(160, 50);
    ui.drawImage(image, logoImgFile!);

    // give position to watermark over image
    // originalImage.width - 160 - 25 (width of originalImage - width of watermarkImage - extra margin you want to give)
    // originalImage.height - 50 - 25 (height of originalImage - height of watermarkImage - extra margin you want to give)
    ui.copyInto(originalImageFile!, image,
        dstX: originalImageFile.width - 160 - 25,
        dstY: originalImageFile.height - 50 - 25);

    // for adding text over image
    // Draw some text using 24pt arial font
    // 100 is position from x-axis, 120 is position from y-axis
    //ui.drawString(originalImageFile, ui.arial_24, 100, 120, 'Think Different');

    // Store the watermarked image to a File
    List<int> wmImage = ui.encodePng(originalImageFile);
    logowithImage = File.fromRawPath(Uint8List.fromList(wmImage));
    islogoattached.value = true;

    // setState(() {
    //   _watermarkedImage = File.fromRawPath(Uint8List.fromList(wmImage));
    // });
  }

  void logError(String code, String? message) {
    if (message != null) {
      //  print('Error: $code\nError Message: $message');
    } else {
      //print('Error: $code');
    }
  }
}
