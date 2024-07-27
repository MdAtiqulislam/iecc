import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../constraints/app_colors.dart';

Future<XFile?> picImage(ImageSource imageSource) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: imageSource);
  if (file != null) {
    return file;
  } else {
    return null;
  }
}

Future<CroppedFile?> cropImage({required String filePath}) async {
  return await ImageCropper().cropImage(
    cropStyle: CropStyle.circle,
    sourcePath: filePath,
    aspectRatioPresets: [
      // CropAspectRatioPreset.square,
      //CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      // CropAspectRatioPreset.ratio4x3,
      //CropAspectRatioPreset.ratio16x9
    ],
    uiSettings: [
      AndroidUiSettings(
          toolbarTitle: 'Edit',
          toolbarColor: Colors.white,
          toolbarWidgetColor: AppColors.primaryColor,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      IOSUiSettings(
        title: 'Edit',
      ),
    ],
  );
}

String formatDate(String? date) {
  if (date != null && date.isNotEmpty) {
    DateTime dDate = DateFormat('y-M-d').parse(date);
    return DateFormat("MMM -yy").format(dDate);
  } else {
    return "";
  }
}




