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
    sourcePath: filePath,

    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: 'Edit',
        toolbarColor: Colors.white,
        toolbarWidgetColor: AppColors.primaryColor,
        lockAspectRatio: false,
        showCropGrid: true, // Optional: Show grid while cropping
        cropStyle: CropStyle.circle, // Circle cropping style
      ),
      IOSUiSettings(
        title: 'Edit',
        aspectRatioLockEnabled: false, // Unlock aspect ratio
        cropStyle: CropStyle.circle, // Circle cropping style
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




