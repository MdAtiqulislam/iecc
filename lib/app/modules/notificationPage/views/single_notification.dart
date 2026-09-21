import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iecc/app/modules/notificationPage/models/notification_list_model.dart';
import 'package:iecc/constraints/app_colors.dart';

class SingleNotification extends StatelessWidget {
  final SingleNotificationModel notificationModel;
  final VoidCallback? onTap;

  const SingleNotification(
      {required this.notificationModel, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: Get.width,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 24.w,//AppDimensions.horizontalPadding,
                    vertical:8.h// AppDimensions.contentPaddingVer
                ),
                child: Text(notificationModel.message ?? ""),
              ),
              if (notificationModel.readAt == null)
                Positioned(
                  top:8.h,// AppDimensions.contentPaddingVer,
                  right: 16.w,//AppDimensions.widgetPaddingVer,
                  child: Container(
                    height: 10,
                    width: 10,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
