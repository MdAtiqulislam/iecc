import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iecc/app/modules/addStudentPage/controllers/add_student_page_controller.dart';
import 'package:iecc/app/routes/app_pages.dart';
import 'package:iecc/constraints/app_colors.dart';
import 'package:iecc/constraints/header_text.dart';

class CustomBottomNavBar extends StatelessWidget {

  final bool? disable;
  const CustomBottomNavBar({
    this.disable,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      width: Get.width,
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
           15.r// AppDimensions.borderRadius,
          ),
          topRight: Radius.circular(15.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const HeaderText(
            text: "Add New Student",
            size: 16,
            color: Colors.white,
          ),
          IgnorePointer(
            ignoring: /*disable??*/false,
            child: IconButton(
              onPressed: () {
                Get.put(AddStudentPageController());
                Get.find<AddStudentPageController>().resetFields();
                Get.find<AddStudentPageController>().getCountryList();
                Get.toNamed(Routes.ADD_STUDENT_PAGE);
              },
              icon: const Icon(
                Icons.add_circle,
                color: Colors.white,
                size: 36,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
