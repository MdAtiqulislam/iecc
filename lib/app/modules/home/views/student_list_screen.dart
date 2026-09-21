import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iecc/app/modules/addStudentPage/controllers/add_student_page_controller.dart';
import 'package:iecc/app/modules/home/controllers/home_controller.dart';
import 'package:iecc/app/modules/home/views/single_student_cart.dart';
import 'package:iecc/app/modules/studentDetailsPage/controllers/student_details_page_controller.dart';
import 'package:iecc/app/routes/app_pages.dart';
import 'package:iecc/constraints/app_colors.dart';
import 'package:iecc/constraints/app_strings.dart';
import 'package:iecc/constraints/body_text.dart';
import 'package:iecc/constraints/header_text.dart';

class StudentListScreen extends GetView<HomeController> {
  StudentListScreen({super.key});

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
       loadMoreData();
    });
    return Obx(() => CustomScrollView(
      controller: _scrollController,
      slivers: [
        /*SliverToBoxAdapter(
          child: SizedBox(
            height: AppDimensions.sectionPaddingVer,
          ),
        ),*/
        SliverToBoxAdapter(
          child: accountInfoSection(),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height:16.h //AppDimensions.widgetPaddingVer,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
              childCount: controller.leads.length, (buildContext, index) {
            return SingleStudentCart(
              editable: controller.leads[index].supervisorId == null,
              name:
              "${controller.leads[index].givenName ?? ""} ${controller.leads[index].familyName ?? ""} ",
              referral: "${controller.leads[index].referalNo ?? ""}",
              applied: controller.leads[index].totalApplied,
              offers: controller.leads[index].totalOffer,
              joined: controller.leads[index].isJoined,
              latestStartDate: controller.leads[index].latestStartDate,
              notes: controller.leads[index].notes,
              isCRM:( controller.leads[index].saTaggingSourceId.toString()=="4"),
              isQform: (controller.leads[index].qForm.toString()=="1"),

              // email: "${controller.leadListModel.value.data?.data?[index].m??""}" ,
              onTap: () {
                Get.put(StudentDetailsPageController());
                Get.find<StudentDetailsPageController>().notes.value=controller.leads[index].notes??"";
                Get.find<StudentDetailsPageController>().isAssigned.value=(controller.leads[index].supervisorId!=null);
                Get.find<StudentDetailsPageController>().getLeadDetails(
                    leadId: controller.leads[index].id ?? 0
                  // leadId:  51174
                );
                Get.toNamed(Routes.STUDENT_DETAILS_PAGE);
              },
              onEditTap: () {
                Get.put(AddStudentPageController());
                Get.find<AddStudentPageController>().resetFields();
                Get.find<AddStudentPageController>().lead.value =
                controller.leads[index];
                Get.find<AddStudentPageController>().preLoadData();
                Get.find<AddStudentPageController>().isUpdateForm.value = true;

                Get.toNamed(Routes.ADD_STUDENT_PAGE);
              },
            );
          }),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 16.h//AppDimensions.widgetPaddingVer,
          ),
        ),
        if (controller.loadingMore.value)
          SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 24.h//AppDimensions.verticalPadding
                ),
                child: const CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
      ],
    ),);
  }

  Widget accountInfoSection() {
    return Container(
      padding: EdgeInsets.symmetric(vertical:16.h// AppDimensions.widgetPaddingVer
      ),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.shadowColor),
          bottom: BorderSide(color: AppColors.shadowColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderText(
                text: "Your student List",
                color: AppColors.secondaryLightColor,
                size: 18,
              ),
              BodyText(
                text:
                    "Estimated income - £${controller.estimatedIncome.value.estimatedIncome??0}",
                color: AppColors.headerTextColor,
                size: 12,
              )
            ],
          ),
          Row(
            children: [
              Image.asset(AppImagePath.studentIcon),
              SizedBox(
                width: 8.w//AppDimensions.contentPaddingHor,
              ),
              HeaderText(
                  text: (controller.leadListModel.value.data?.total ?? 0)
                      .toString())
            ],
          )
        ],
      ),
    );
  }

  void loadMoreData() {
    // currentPosition.value=_scrollController.position.pixels;
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (controller.leadListModel.value.data?.currentPage !=
              controller.leadListModel.value.data?.lastPage &&
          !controller.loadingMore.value) {
        controller.loadMore(
          url: controller.leadListModel.value.data?.nextPageUrl,
        );
      }
    }
  }
}
