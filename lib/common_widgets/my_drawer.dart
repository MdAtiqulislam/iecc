import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iecc/common_widgets/custom_loading_screen.dart';
import 'package:iecc/constraints/app_strings.dart';
import 'package:iecc/constraints/body_text.dart';
import 'package:iecc/constraints/header_text.dart';
import 'package:image_picker/image_picker.dart';
import '../app/data/my_drawer_controller.dart';
import '../constraints/app_colors.dart';
import 'custom_circle_avatar.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});
  final MyDrawerController controller = Get.put(MyDrawerController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: Stack(
          children: [
            Drawer(
              backgroundColor: Colors.white,
              width: MediaQuery.of(context).orientation == Orientation.portrait
                  ? Get.width * .8
                  : Get.width * .5,
              child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                      horizontal: 24.w,//AppDimensions.horizontalPadding,
                      vertical: 24.h//AppDimensions.verticalPadding
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 32.h//AppDimensions.sectionPaddingVer,
                      ),
                      Stack(
                        children: [
                          CustomCircleAvatar(
                            width: 100,
                            height: 100,
                            image: controller.userData.value.avatar ?? '',
                            bgColor: AppColors.primaryColor.withOpacity(.5),
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.primaryColor),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: Colors.white54,
                                    onTap: () {
                                      // controller.chooseImage();

                                      Get.bottomSheet(choseImage());
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Icon(
                                        Icons.camera_alt_outlined,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 16.h//AppDimensions.widgetPaddingVer,
                      ),
                      const Divider(),
                      SizedBox(
                        height: 32.h//AppDimensions.sectionPaddingVer,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: HeaderText(
                            text: controller.userData.value.name ?? "",
                            align: TextAlign.start,
                            maxLine: 3,
                          )),
                          IconButton(
                              onPressed: () {
                                controller.updateUser();
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: AppColors.primaryColor,
                              ))
                        ],
                      ),
                      BodyText(text: controller.userData.value.email ?? ""),
                      BodyText(text: controller.userData.value.phone ?? ""),
                     if(controller.userData.value.country!=null) BodyText(
                          text: "${controller.userData.value.city ?? ""}, "
                             "${controller.countryList[controller.countryList.indexWhere((element) => element.id == controller.userData.value.country)].name ?? ""}"
                      ),
                      BodyText(
                          text:
                              controller.userData.value.sourceOccupation ?? ""),
                      SizedBox(
                        height:32.h// AppDimensions.sectionPaddingVer,
                      ),
                      const Divider(),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        iconColor: AppColors.primaryColor,
                        onTap: () {
                          controller.logOut();
                        },
                        leading: const Icon(Icons.logout),
                        title: const HeaderText(
                          text: "Log Out",
                          align: TextAlign.start,
                          color: AppColors.primaryColor,
                        ),
                      ),

                    if(Platform.isIOS)
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        iconColor: AppColors.primaryColor,
                        onTap: () {
                          controller.removeAccount();
                        },
                        leading: const Icon(Icons.delete),
                        title: const HeaderText(
                          text: "Remove Your Account",
                          align: TextAlign.start,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  )),
            ),
            if (controller.isLoading.value) const LoadingScreen()
          ],
        ),
      ),
    );
  }

  Widget choseImage() {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15.r),
              topLeft: Radius.circular(15.r),),),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height:32.h,
          ),
          const HeaderText(
            text: "Select an action",
            color: AppColors.primaryColor,
            size: 18,
          ),
          SizedBox(
            height: 32.h//AppDimensions.widgetPaddingVer,
          ),
          const Divider(
            thickness: 5,
            color: AppColors.primaryColor,
          ),
          SizedBox(
            height:32.h// AppDimensions.contentPaddingVer,
          ),
          Container(
            margin: const EdgeInsets.all(5),
            color: Colors.white,
            child: Material(
              child: InkWell(
                onTap: () {
                  controller.selectImage(source: ImageSource.camera);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal:24.w,// AppDimensions.horizontalPadding,
                      vertical:24.h// AppDimensions.widgetPaddingVer
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        AppImagePath.cameraIcon,
                        height: 40.h,
                      ),
                      SizedBox(
                        width:24.w// AppDimensions.widgetPaddingHor,
                      ),
                      const HeaderText(text: "Open Camera"),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Divider(),
          // SizedBox(height: Dimensions.widgetPaddingVer,),
          Container(
            margin: const EdgeInsets.all(5),
            color: Colors.white,
            child: Material(
              child: InkWell(
                onTap: () {
                  controller.selectImage(source: ImageSource.gallery);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal:24.w,// AppDimensions.horizontalPadding,
                      vertical: 24.w//AppDimensions.widgetPaddingVer
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        AppImagePath.galleryIcon,
                        height: 40.h,
                      ),
                      SizedBox(
                        width:16.w// AppDimensions.widgetPaddingHor,
                      ),
                      const HeaderText(text: "Open Gallery"),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 32.h//AppDimensions.sectionPaddingVer,
          )
        ],
      ),
    );
  }
}
