import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iecc/app/modules/studentDetailsPage/Models/lead_details_model.dart';
import 'package:iecc/app/modules/studentDetailsPage/controllers/student_details_page_controller.dart';
import 'package:iecc/constraints/app_colors.dart';
import 'package:iecc/constraints/body_text.dart';
import 'package:iecc/constraints/header_text.dart';

import '../../../../constraints/app_strings.dart';
import '../../../utils/utils.dart';

class SingleUniversityCard extends GetView<StudentDetailsPageController> {
  final AppliedUniversityModel appliedUniversityModel;

  const SingleUniversityCard({required this.appliedUniversityModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 70.sp,
              height: 50.sp,
              decoration: BoxDecoration(
                  border: Border.all(width: 3, color: AppColors.inactiveColor)),
              child: SvgPicture.network(
                controller.getCountryFlug(appliedUniversityModel.country),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16.w //AppDimensions.widgetPaddingHor,
                ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BodyText(
                    text: appliedUniversityModel.university ?? "",
                    fontWeight: FontWeight.w600,
                  ),
                  BodyText(
                    text:
                        "${appliedUniversityModel.level} . ${formatDate(appliedUniversityModel.startDate)}",
                    fontWeight: FontWeight.w600,
                    maxLine: 3,
                    color: Colors.grey,
                  ),
                  /*SizedBox(height: 8.h // AppDimensions.contentPaddingVer,
                      ),*/
                  BodyText(
                    text: appliedUniversityModel.subject ?? "",
                    fontWeight: FontWeight.w600,
                    maxLine: 3,
                  ),
                  const HeaderText(
                    text: "App Status: ",
                    size: 12,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: AppColors.inactiveColor),
                    child: BodyText(
                        text: (appliedUniversityModel.appStatus ?? "")
                                        .toLowerCase() ==
                                    "need to apply" ||
                                (appliedUniversityModel.appStatus ?? "")
                                        .toLowerCase() ==
                                    "application ready"
                            ? "In Process"
                            : appliedUniversityModel.appStatus ?? ""),
                  ),

                 if(appliedUniversityModel.depositPaid.toString()=="1")
                   Row(
                     children: [
                       Image.asset(AppImagePath.dollarIcon),
                       SizedBox(
                           width: 8.w//AppDimensions.contentPaddingHor,
                       ),
                       const Expanded(
                         child: BodyText(
                           text: "Deposit Paid",
                           // color: AppColors.headerTextColor,
                           color: AppColors.successColor,
                           maxLine: 3,
                           fontWeight: FontWeight.w600,
                           align: TextAlign.start,
                         ),
                       )
                     ],
                   ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h,),
        Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 3.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: appliedUniversityModel.studentDecision?.toLowerCase() ==
                "joined"
                ? AppColors.successColor
                : AppColors.inactiveColor,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              HeaderText(
                text: "Student Status: ",
                size: 12,
                color:
                    appliedUniversityModel.studentDecision?.toLowerCase() ==
                            "joined"
                        ? Colors.white
                        : AppColors.bodyTextColor,
              ),
              BodyText(
                text: (appliedUniversityModel.studentDecision ?? "")
                                .toLowerCase() ==
                            "need to apply" ||
                        (appliedUniversityModel.studentDecision ?? "")
                                .toLowerCase() ==
                            "application ready"
                    ? "In Process"
                    : appliedUniversityModel.studentDecision ?? "",
                color:
                    appliedUniversityModel.studentDecision?.toLowerCase() ==
                            "joined"
                        ? Colors.white
                        : AppColors.bodyTextColor,
                size: 12,
              )
            ],
          ),
        ),
      ],
    );
  }
}
