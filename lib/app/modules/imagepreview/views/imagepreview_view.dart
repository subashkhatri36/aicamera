import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/imagepreview_controller.dart';

class ImagepreviewView extends GetView<ImagepreviewController> {
  const ImagepreviewView(
    this.arugment, {
    Key? key,
  }) : super(key: key);

  final arugment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image View'),
      ),
      body: SafeArea(
        child: arugment != null
            ? Center(
                child: Image.file(
                  File(arugment.path),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill,
                ),
              )
            : const Text('No image found'),
      ),
    );
  }
}
