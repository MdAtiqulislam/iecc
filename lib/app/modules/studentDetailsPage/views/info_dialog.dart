import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iecc/common_widgets/app_button.dart';
import 'package:iecc/constraints/app_colors.dart';
import 'package:iecc/constraints/body_text.dart';
import 'package:iecc/constraints/header_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Models/lead_details_model.dart';

class InfoDialog extends StatelessWidget {
  final SupervisorInfo data;
  final String type;

  const InfoDialog({required this.data, required this.type, super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15.r)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
              width: Get.width,
              color: AppColors.primaryColor,
              child: HeaderText(
                text: type,
                color: Colors.white,
                align: TextAlign.start,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (data.name != null) HeaderText(text: data.name ?? ""),
                  if (data.name != null)
                    SizedBox(
                      height: 16.h,
                    ),
                  if (data.phone != null)
                    InkWell(
                      onTap: () async {
                        final Uri launchUri = Uri(
                          scheme: 'tel',
                          path:data.phone,
                        );
                        await launchUrl(launchUri);
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.call),
                          SizedBox(
                            width: 8.w,
                          ),
                          HeaderText(text: data.phone)
                        ],
                      ),
                    ),
                  if (data.phone != null)
                    SizedBox(
                      height: 16.h,
                    ),
                  if (data.mobile != null)
                    InkWell(
                      onTap: () async {
                        final Uri launchUri = Uri(
                          scheme: 'tel',
                          path: data.mobile,
                        );
                        await launchUrl(launchUri);
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.phone_android_rounded),
                          SizedBox(
                            width: 8.w,
                          ),
                          HeaderText(text: data.phone)
                        ],
                      ),
                    ),
                  if (data.phone != null) const Divider(),
                  if (data.email != null)
                    InkWell(
                      onTap: () async {
                        final Uri emailLaunchUri = Uri(
                          scheme: 'mailto',
                          path: data.email,
                        );

                        launchUrl(emailLaunchUri);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.mail,
                            size: 18.sp,
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Expanded(
                              child: BodyText(
                            text: data.email ?? "",
                            maxLine: 2,
                            align: TextAlign.start,
                          )),
                        ],
                      ),
                    ),
                  SizedBox(
                    height: 32.h,
                  ),
                  AppButton(
                    text: "Back",
                    onTap: () {
                      Get.back();
                    },
                    splashColor: AppColors.primaryColor.withAlpha(50),
                  ),
                  /*Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primaryColor)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_back_ios_rounded),
                        HeaderText(text: "Back")
                      ],
                    ),
                  )*/
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
