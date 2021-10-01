import 'dart:async';
import 'dart:io';

import 'package:aicamera/app/constant/constants.dart';
import 'package:aicamera/app/constant/enum.dart';
import 'package:aicamera/app/constant/themes.dart';
import 'package:aicamera/app/modules/home/controllers/home_controller.dart';
import 'package:aicamera/app/modules/imagepreview/views/imagepreview_view.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
    animationInitalized();
    super.initState();
  }

  void animationInitalized() {
    hcontroller.flashModeControlRowAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    hcontroller.flashModeControlRowAnimation = CurvedAnimation(
        parent: hcontroller.flashModeControlRowAnimationController,
        curve: Curves.easeInCubic);
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
                //here is the main work going on....
                Expanded(
                  child: RepaintBoundary(
                      key: hcontroller.screenshotKey,
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Expanded(
                                  child: Obx(() =>
                                      hcontroller.isImageClicked.isTrue
                                          ? Image.file(
                                              File(hcontroller
                                                  .cameraimageFile!.path),
                                              fit: BoxFit.fill)
                                          : cameraPreviewWidget())),
                            ],
                          ),
                          Obx(() => hcontroller.islogoattached.value &&
                                  hcontroller.logowithImage != null
                              ? Center(
                                  child: Image.file(
                                  File(
                                    hcontroller.logowithImage!.path,
                                  ),
                                  width: 200,
                                  height: 200,
                                ))
                              : Container()),
                          Obx(
                            () => hcontroller.islogo.value
                                ? Positioned(
                                    top: hcontroller.logoDir.value ==
                                                LogoDirection.topleft ||
                                            hcontroller.logoDir.value ==
                                                LogoDirection.topright
                                        ? 30
                                        : null,
                                    left: hcontroller.logoDir.value ==
                                                LogoDirection.topleft ||
                                            hcontroller.logoDir.value ==
                                                LogoDirection.bottomleft
                                        ? 10
                                        : null,
                                    right: hcontroller.logoDir.value ==
                                                LogoDirection.topright ||
                                            hcontroller.logoDir.value ==
                                                LogoDirection.bottomright
                                        ? 10
                                        : null,
                                    bottom: hcontroller.logoDir.value ==
                                                LogoDirection.bottomleft ||
                                            hcontroller.logoDir.value ==
                                                LogoDirection.bottomright
                                        ? 10
                                        : null,
                                    child: hcontroller.logoImageFile == null
                                        ? Icon(Icons.face, color: Themes.white)
                                        : Image.file(
                                            File(hcontroller
                                                .logoImageFile!.path),
                                            height: 50,
                                            width: 50,
                                          ))
                                : const Icon(Icons.face, color: Themes.white),
                          ),
                          Obx(
                            () => hcontroller.isImageClicked.isTrue
                                ? Container()
                                : Positioned(
                                    top: 25,
                                    right: 10,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            IconButton(
                                              color: Themes.white,
                                              icon: Icon(
                                                hcontroller.controller!.value
                                                            .flashMode ==
                                                        FlashMode.off
                                                    ? Icons.flash_off
                                                    : hcontroller
                                                                .controller!
                                                                .value
                                                                .flashMode ==
                                                            FlashMode.auto
                                                        ? Icons.flash_auto
                                                        : hcontroller
                                                                    .controller!
                                                                    .value
                                                                    .flashMode ==
                                                                FlashMode.always
                                                            ? Icons.flash_on
                                                            : hcontroller
                                                                        .controller!
                                                                        .value
                                                                        .flashMode ==
                                                                    FlashMode
                                                                        .torch
                                                                ? Icons
                                                                    .highlight
                                                                : Icons
                                                                    .flash_on_outlined,
                                                size: (MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.045),
                                              ),
                                              onPressed: hcontroller
                                                  .onFlashModeButtonPressed,
                                            ),
                                            IconButton(
                                              color: Themes.white,
                                              icon: Icon(
                                                Icons.settings,
                                                size: (MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.045),
                                              ),
                                              onPressed: () async {
                                                await hcontroller
                                                    .getLogoImage();
                                                print('clicked');
                                              },
                                            ),
                                          ],
                                        ),
                                        flashModeControlRowWidget(),
                                      ],
                                    ),
                                  ),
                          )
                        ],
                      )),
                ),
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
                          if (hcontroller.pngBytes != null) {
                            Get.to(
                              ImagepreviewView(hcontroller.pngBytes),
                            );
                          }
                        },
                        child: Obx(
                          () => !hcontroller.isImageClicked.value &&
                                  hcontroller.pngBytes == null
                              ? const CircleAvatar(
                                  backgroundColor: Themes.grey,
                                  radius: Constant.defaultRadius * 1.4,
                                )
                              : hcontroller.pngBytes == null
                                  ? const CircleAvatar(
                                      backgroundColor: Themes.grey,
                                      radius: Constant.defaultRadius * 1.4,
                                    )
                                  : CircleAvatar(
                                      backgroundImage:
                                          MemoryImage(hcontroller.pngBytes!),
                                      radius: Constant.defaultRadius * 1.4,
                                    ),
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

  ///set flash mode

  Widget flashModeControlRowWidget() {
    return SizeTransition(
      sizeFactor: hcontroller.flashModeControlRowAnimation,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          IconButton(
            icon: const Icon(Icons.flash_off),
            color: hcontroller.controller!.value.flashMode == FlashMode.off
                ? Colors.orange
                : Themes.white,
            onPressed: () => onSetFlashModeButtonPressed(FlashMode.off),
          ),
          IconButton(
            icon: const Icon(Icons.flash_auto),
            color: hcontroller.controller!.value.flashMode == FlashMode.auto
                ? Colors.orange
                : Themes.white,
            onPressed: () => onSetFlashModeButtonPressed(FlashMode.auto),
          ),
          IconButton(
            icon: const Icon(Icons.flash_on),
            color: hcontroller.controller!.value.flashMode == FlashMode.always
                ? Colors.orange
                : Themes.white,
            onPressed: () => onSetFlashModeButtonPressed(FlashMode.always),
          ),
          IconButton(
            icon: const Icon(Icons.highlight),
            color: hcontroller.controller!.value.flashMode == FlashMode.torch
                ? Colors.orange
                : Themes.white,
            onPressed: () => onSetFlashModeButtonPressed(FlashMode.torch),
          ),
        ],
      ),
    );
  }

  void onSetFlashModeButtonPressed(FlashMode mode) {
    hcontroller.setFlashMode(mode).then((_) {
      if (mounted) setState(() {});
      // customSnackbar(
      //     message: 'Flash mode set to ${mode.toString().split('.').last}');
    });
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
        //                                                                                        'Camera error ${hcontroller.controller!.value.errorDescription}');
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
    takePicture().then((XFile? file) async {
      if (mounted) {
        setState(() {
          hcontroller.cameraimageFile = file;

          hcontroller.mergingImageWithLogo();
          Fluttertoast.showToast(
              msg: "Image Capture",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        });
        hcontroller.isImageClicked.value = true;
      //  hcontroller.hideSaveButton.value = true;       
      
          Timer(const Duration(seconds: 5), hcontroller.savedImageIntoPath);
        
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
