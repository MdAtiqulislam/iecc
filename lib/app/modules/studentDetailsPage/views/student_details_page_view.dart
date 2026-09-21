import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:iecc/app/modules/studentDetailsPage/Models/lead_details_model.dart';
import 'package:iecc/app/modules/studentDetailsPage/views/info_dialog.dart';
import 'package:iecc/app/modules/studentDetailsPage/views/single_university_card.dart';
import 'package:iecc/app/modules/customAppBar/custom_app_bar.dart';
import 'package:iecc/common_widgets/circular_button.dart';
import 'package:iecc/common_widgets/custom_bottom_nav_bar.dart';
import 'package:iecc/common_widgets/custom_loading_screen.dart';
import 'package:iecc/common_widgets/my_drawer.dart';
import 'package:iecc/constraints/app_colors.dart';
import 'package:iecc/constraints/app_strings.dart';
import 'package:iecc/constraints/body_text.dart';
import 'package:iecc/constraints/header_text.dart';

import '../controllers/student_details_page_controller.dart';

class StudentDetailsPageView extends GetView<StudentDetailsPageController> {
  StudentDetailsPageView({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Stack(
          children: [
            Scaffold(
              key: scaffoldKey,
              appBar: CustomAppBar(
                minimal: false,
                scaffoldKey: scaffoldKey,
              ),
              drawer: MyDrawer(),
              bottomNavigationBar: const CustomBottomNavBar(),
              body: SingleChildScrollView(

                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 24.w//AppDimensions.horizontalPadding
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.h,),
                      BackButton(
                        color: AppColors.iconColor,
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(Colors.white),
                            elevation: WidgetStatePropertyAll(3),
                            shadowColor: WidgetStatePropertyAll(Colors.black87)
                        ),
                      ),
                      SizedBox(
                        height:16.h// AppDimensions.sectionPaddingVer,
                      ),
                      headerSection(),
                      SizedBox(
                        height:32.h/// AppDimensions.sectionPaddingVer,
                      ),

                      if((controller.leadDetailsModel.value.data?.totalApplied??[]).isEmpty)
                        const HeaderText(text: "No Applications Available",color: AppColors.bodyTextColor,size: 14,),
                      universityListSection(),
                      SizedBox(
                        height: 32.h//AppDimensions.sectionPaddingHor,
                      )
                    ],
                  ),
                ),
              ),
            ),
            if (controller.isLoading.value) const LoadingScreen()
          ],
        ),
      ),
    );
  }

  Widget headerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Row(
          children: [
            const HeaderText(
              text: "Student Details",
              color: AppColors.secondaryLightColor,
              size: 18,
            ),
           if(controller.isAssigned.value) Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CircularButton(

                  callback: () {  },
                  child: IconButton(
                    onPressed: (){
                      showDialog(context: Get.context!, builder: (buildContext){
                        return InfoDialog(type: "Counsellor",data:controller.leadDetailsModel.value.data?.counsellorInfo??SupervisorInfo() ,);
                      });
                    },
                    icon: Image.asset(AppImagePath.counselorIcon,height: 20.h,),
                  ),
                ),
               /* SizedBox(width: 16.w,),
                CircularButton(

                  callback: () {  },
                  child: IconButton(

                    onPressed: () {
                      showDialog(context: Get.context!, builder: (buildContext){
                        return InfoDialog(type: "Manager",data:controller.leadDetailsModel.value.data?.managerInfo??SupervisorInfo() ,);
                      });

                    },
                    icon: Image.asset(AppImagePath.mangerIcon,height: 20.h,),
                  ),
                ),*/
              ],),
            )
          ],
        ),
        SizedBox(
          height:16.h// AppDimensions.widgetPaddingVer,
        ),
        HeaderText(
          text:
              "${controller.leadDetailsModel.value.data?.givenName ?? ""} ${controller.leadDetailsModel.value.data?.familyName ?? ""}",
          size: 14,
        ),
        Row(
          children: [
            const HeaderText(
              text: "Ref No: ",
              size: 12,
            ),
            BodyText(
                text: (controller.leadDetailsModel.value.data?.referalNo ?? "")
                    .toString()),
          ],
        ),
        SizedBox(
          height:16.h// AppDimensions.widgetPaddingVer,
        ),
        Row(
          children: [
            Icon(
              Icons.mail,
              color: AppColors.primaryColor,
              size: 15.sp,
            ),
            BodyText(
              text: " ${controller.leadDetailsModel.value.data?.email ?? " "}",
            ),
          ],
        ),
        Row(
          children: [
            Icon(
              Icons.call,
              color: AppColors.primaryColor,
              size: 15.sp,
            ),
            BodyText(
                text:
                    " ${controller.leadDetailsModel.value.data?.mobile ?? " "}")
          ],
        ),
        SizedBox(
          height:16.h// AppDimensions.widgetPaddingVer,
        ),
        BodyText(
          text: "Additional Notes: ${controller.notes.value}",
          align: TextAlign.start,
          maxLine: 5,
        ),
        const Divider(),
      ]
    );
  }

  Widget universityListSection() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (buildContext, index) {
        return SingleUniversityCard(
            appliedUniversityModel:
                controller.leadDetailsModel.value.data?.totalApplied?[index] ??
                    AppliedUniversityModel()
        );
      },
      separatorBuilder: (buildContext, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h//AppDimensions.sectionPaddingVer
          ),
          child: const Divider(
            color: AppColors.headerTextColor,
          ),
        );
      },
      itemCount:
          controller.leadDetailsModel.value.data?.totalApplied?.length ?? 0,
    );
  }
}
