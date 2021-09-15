import 'dart:io';

import 'package:aicamera/app/constant/constants.dart';
import 'package:aicamera/app/constant/themes.dart';
import 'package:aicamera/app/modules/home/controllers/home_controller.dart';
import 'package:aicamera/app/modules/imagepreview/views/imagepreview_view.dart';
import 'package:aicamera/app/routes/app_pages.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  final hcontroller = Get.find<HomeController>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    ambiguate(WidgetsBinding.instance)?.addObserver(this);
    setCameras();
    super.initState();
  }

  ///It will set the camera of the windows
  Future<void> setCameras() async {
    hcontroller.cameras = await availableCameras();
    onNewCameraSelected(hcontroller.cameras[0]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: hcontroller.controller == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(child: cameraPreviewWidget()),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Constant.defaultPadding * 3.5,
                      vertical: Constant.defaultPadding * 1.2),
                  color: Colors.black,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(
                            ImagepreviewView(hcontroller.imageFile),
                          );
                        },
                        child: hcontroller.imageFile == null
                            ? const CircleAvatar(
                                backgroundColor: Themes.grey,
                                radius: Constant.defaultRadius * 1.4,
                              )
                            : CircleAvatar(
                                backgroundImage: FileImage(
                                    File(hcontroller.imageFile!.path)),
                                radius: Constant.defaultRadius * 1.4,
                              ),
                      ),
                      GestureDetector(
                        onTap: hcontroller.controller!.value.isInitialized
                            ? onTakePictureButtonPressed
                            : null,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * .09,
                          width: MediaQuery.of(context).size.width * .18,
                          child: CircleAvatar(
                            backgroundColor: Themes.white.withOpacity(.8),
                            radius: Constant.defaultRadius,
                            child: const CircleAvatar(
                              radius: Constant.defaultRadius * 1.7,
                              backgroundColor: Themes.white,
                            ),
                          ),
                        ),
                      ),
                      Obx(() {
                        return hcontroller.isFrontCamera.isTrue
                            ? CircleAvatar(
                                radius: Constant.defaultRadius * 1.4,
                                backgroundColor: Themes.white.withOpacity(.4),
                                child: IconButton(
                                    color: Themes.white,
                                    icon: const Icon(
                                      Icons.flip_camera_ios_rounded,
                                      size: Constant.defaultRadius * 1.4,
                                    ),
                                    onPressed: () {
                                      toggleCamera(0);
                                      hcontroller.isFrontCamera.value = false;
                                    }),
                              )
                            : CircleAvatar(
                                radius: Constant.defaultRadius * 1.4,
                                backgroundColor: Themes.white.withOpacity(.4),
                                child: IconButton(
                                    color: Themes.white,
                                    icon: const Icon(
                                      Icons.flip_camera_ios_rounded,
                                      size: Constant.defaultRadius * 1.4,
                                    ),
                                    onPressed: () {
                                      toggleCamera(1);
                                      hcontroller.isFrontCamera.value = true;
                                    }),
                              );
                      }),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  ///It is used to toggle the camera from front to back and back to front
  ///it takes integer index parameter which by default 0
  ///it return void
  void toggleCamera([int index = 0]) async {
    hcontroller.controller = CameraController(
      hcontroller.cameras[index],
      ResolutionPreset.medium,
    );

    // If the controller is updated then update the UI.
    hcontroller.controller!.addListener(() {
      if (mounted) setState(() {});
      if (hcontroller.controller!.value.hasError) {
        // customSnackbar(
        //     title: "",
        //     message:
        //         'Camera error ${hcontroller.controller!.value.errorDescription}');
      }
    });

    try {
      await hcontroller.controller!.initialize();
    } on CameraException catch (e) {
      print(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  ///It will used to zoom in and out from the in camera were it take tapdowndetails and constraints as
  ///an argunment
  ///
  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    if (hcontroller.controller == null) return;

    final CameraController cameraController = hcontroller.controller!;
    final offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    cameraController.setExposurePoint(offset);
    cameraController.setFocusPoint(offset);
  }

  void handleScaleStart(ScaleStartDetails details) {
    hcontroller.baseScale = hcontroller.currentScale;
  }

  Future<void> handleScaleUpdate(ScaleUpdateDetails details) async {
    // When there are not exactly two fingers on screen don't scale
    if (hcontroller.controller == null || hcontroller.pointers != 2) {
      return;
    }

    hcontroller.currentScale = (hcontroller.baseScale * details.scale)
        .clamp(hcontroller.minAvailableZoom, hcontroller.maxAvailablezoom);

    await hcontroller.controller!.setZoomLevel(hcontroller.currentScale);
  }

  ///its a method used to press button to click the picture
  ///
  void onTakePictureButtonPressed() {
    takePicture().then((XFile? file) {
      if (mounted) {
        setState(() {
          hcontroller.imageFile = file;
        });
        // if (file != null)
        //   customSnackbar(message: 'Picture saved to ${file.path}');
      }
    });
  }

  ///it take a picture and save it in a temporary file xfile
  ///it return future xfile after getting picture from controller
  Future<XFile?> takePicture() async {
    if (hcontroller.controller!.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }
    try {
      XFile file = await hcontroller.controller!.takePicture();
      return file;
    } on CameraException catch (e) {
      print(e);
      return null;
    }
  }

  ///it used to display ui of camera
  Widget cameraPreviewWidget() {
    final CameraController? cameraController = hcontroller.controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return const Text(
        'Tap a camera',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return Listener(
        onPointerDown: (_) => hcontroller.pointers++,
        onPointerUp: (_) => hcontroller.pointers--,
        child: CameraPreview(
          hcontroller.controller!,
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onScaleStart: handleScaleStart,
              onScaleUpdate: handleScaleUpdate,
              onTapDown: (details) => onViewFinderTap(details, constraints),
            );
          }),
        ),
      );
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      hcontroller.controller!.dispose();
    } else if (state == AppLifecycleState.resumed) {
      onNewCameraSelected(hcontroller.controller!.description);
    }

    super.didChangeAppLifecycleState(state);
  }

  CameraImage? imgCamera;
  bool isworking = false;

  //either in rotate or in other
  void onNewCameraSelected(CameraDescription cameraDescription) async {
    hcontroller.isCameraInitialized = false;

    final CameraController cameraController =
        CameraController(cameraDescription, ResolutionPreset.medium,
            // enableAudio: enableAudio,
            imageFormatGroup: ImageFormatGroup.jpeg);
    hcontroller.controller = cameraController;
    cameraController.addListener(() {
      if (mounted) setState(() {});
      if (cameraController.value.hasError) {
        // customSnackbar(
        //     message: 'Camera error ${cameraController.value.errorDescription}');
      }
    });

    try {
      await cameraController.initialize();

      await Future.wait([
        cameraController
            .getMaxZoomLevel()
            .then((value) => hcontroller.maxAvailablezoom = value),
        cameraController
            .getMinZoomLevel()
            .then((value) => hcontroller.minAvailableZoom = value),
      ]);
    } on CameraException catch (e) {
      print(e);
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() async {
    ambiguate(WidgetsBinding.instance)?.removeObserver(this);
    super.dispose();
  }
}

T? ambiguate<T>(T? value) => value;
