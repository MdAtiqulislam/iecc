import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iecc/app/modules/customAppBar/app_bar_controller.dart';
import 'package:iecc/common_widgets/custom_circle_avatar.dart';
import 'package:iecc/constraints/app_strings.dart';
import 'package:iecc/constraints/body_text.dart';

import '../../../constraints/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool? minimal;
  final VoidCallback? openDrawer;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  CustomAppBar({this.scaffoldKey, this.openDrawer, this.minimal, super.key});

  final appBarController = Get.put(AppBarController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => appBarController.isLoading.value
          ? AppBar()
          : Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.shadowColor, width: 1.h),
                ),
              ),
              height: 70.h,
              child: Row(
                children: [
                  Container(
                    padding:
                        EdgeInsets.only(left: 24.w//AppDimensions.horizontalPadding
                        ),
                    decoration: BoxDecoration(
                      border: minimal ?? true
                          ? const Border()
                          : Border(
                              bottom: BorderSide(
                                  color: AppColors.primaryColor, width: 2.h),
                            ),
                    ),
                    height: 70.h,
                    child: Image.asset(
                      AppImagePath.appLogo,
                      height: 30.h,
                      width: 68.w,
                    ),
                  ),
                  if (!(minimal ?? true))
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            clipBehavior: Clip.hardEdge,
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: AppColors.shadowColor,
                                  spreadRadius: 1
                                )
                              ],
                              borderRadius: BorderRadius.circular(10.r)
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: IgnorePointer(
                                ignoring: appBarController.isLoading.value,
                                child: InkWell(
                                  onTap: () {
                                    appBarController.qFormShare();
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5.r),
                                          color: AppColors.shadowColor,
                                        ),
                                        child: const Icon(
                                          Icons.bolt_sharp,
                                          color: AppColors.iconColor,
                                        ),
                                      ),
                                      const BodyText(text: "Q-form",size: 8,fontWeight: FontWeight.bold,resizeAble: false,)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width:8.w //AppDimensions.widgetPaddingHor,
                          ),
                          /*InkWell(
                            onTap: () {
                              appBarController.openNotification();
                            },
                            child: Stack(
                              children: [
                                Image.asset(
                                  AppImagePath.notificationIcon,
                                  height: 40,
                                ),
                                if ((appBarController.homeData.value.data
                                            ?.unreadNotificationCount ??
                                        0) >
                                    0)
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Container(
                                      height: 21,
                                      width: 21,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.primaryColor),
                                      child: Center(
                                        child: HeaderText(
                                          text: (appBarController
                                                          .homeData
                                                          .value
                                                          .data
                                                          ?.unreadNotificationCount ??
                                                      0) >=
                                                  10
                                              ? "9+"
                                              : "${appBarController.homeData.value.data?.unreadNotificationCount ?? ""}",
                                          color: Colors.white,
                                          size: 12,
                                        ),
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 16.w//AppDimensions.widgetPaddingHor,
                          ),*/
                          InkWell(
                            onTap: () {
                              scaffoldKey?.currentState?.openDrawer();
                            },
                            child: CustomCircleAvatar(
                              width: 40,
                              height: 40,
                              image: appBarController
                                      .homeData.value.data?.userInfo?.avatar ??
                                  "",
                            ),
                          ),
                          SizedBox(width: 24.w,)
                        ],
                      ),
                    )
                ],
              ),
            ),
    );
  }

  @override
  Size get preferredSize => Size(Get.width, 70.h);
}
