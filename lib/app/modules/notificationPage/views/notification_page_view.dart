import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iecc/app/modules/customAppBar/custom_app_bar.dart';
import 'package:iecc/app/modules/notificationPage/views/single_notification.dart';
import 'package:iecc/common_widgets/app_button.dart';
import 'package:iecc/common_widgets/custom_loading_screen.dart';
import 'package:iecc/constraints/app_colors.dart';
import 'package:iecc/constraints/app_strings.dart';
import 'package:iecc/constraints/body_text.dart';
import '../../../../constraints/header_text.dart';
import '../controllers/notification_page_controller.dart';
import '../models/notification_list_model.dart';

class NotificationPageView extends GetView<NotificationPageController> {
   NotificationPageView({super.key});

  final ScrollController _scrollController=ScrollController();

  @override
  Widget build(BuildContext context) {

    _scrollController.addListener(() {
      loadMoreData();
    });

    return SafeArea(
      child: Obx(
        () => Stack(
          children: [
            Scaffold(
              appBar: CustomAppBar(
                minimal: true,
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 24.w//AppDimensions.horizontalPadding
                ),
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 16.h//AppDimensions.widgetPaddingVer,
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: controller.notificationListModel.value.data
                                ?.data?.length ??
                            0,
                        (context, index) => Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.startToEnd,
                          background: Card(
                            color: AppColors.primaryColor,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal:16.w// AppDimensions.widgetPaddingHor,
                                ),
                                child: const Icon(
                                  Icons.delete_forever,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          confirmDismiss: (direction) async {
                            var confirm = false.obs;

                            await showDialog(
                                context: context,
                                builder: (buildContext) {
                                  return Dialog(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                             24.w,// AppDimensions.horizontalPadding,
                                          vertical:24.h// AppDimensions.verticalPadding
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                              15.r//AppDimensions.borderRadius
                                          ),),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.highlight_remove,
                                            color: AppColors.primaryColor,
                                            size: 50.sp,
                                          ),
                                          SizedBox(
                                            height: 16.h//AppDimensions.widgetPaddingVer,
                                          ),
                                          const HeaderText(
                                            text: "Are you sure?",
                                            maxLine: 5,
                                            align: TextAlign.start,
                                          ),
                                          SizedBox(
                                            height:
                                               8.h// AppDimensions.contentPaddingVer,
                                          ),
                                          const BodyText(
                                            text:
                                                "Do you really want to remove this record permanently? This process can not be undo.",
                                            maxLine: 50,
                                            align: TextAlign.start,
                                          ),
                                          SizedBox(
                                            height:
                                               32.h// AppDimensions.sectionPaddingVer,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AppButton(
                                                text: "Cancel",
                                                onTap: () {
                                                  Get.back();
                                                  confirm.value = false;
                                                },
                                                bgColor: AppColors.primaryColor,
                                              ),
                                              SizedBox(
                                                width:
                                                  16.w//  AppDimensions.widgetPaddingHor,
                                              ),
                                              AppButton(
                                                text: "Confirm",
                                                onTap: () {
                                                  Get.back();
                                                  confirm.value = true;
                                                },
                                                bgColor:
                                                    AppColors.inactiveColor,
                                                borderColor:
                                                    AppColors.inactiveColor,
                                                textColor:
                                                    AppColors.primaryColor,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                            return confirm.value;
                          },
                          onDismissed: (direction) {
                            controller.deleteNotification(id:controller.notificationListModel.value.data?.data?[index].id??0);
                          },
                          child: SingleNotification(
                            notificationModel: controller.notificationListModel
                                    .value.data?.data?[index] ??
                                SingleNotificationModel(),
                            onTap: () {
                              showDialog(
                                  context: Get.context!,
                                  builder: (buildContext) {
                                    return notificationDialog(index: index);
                                  });

                              controller.changeNotificationReadStatus(
                                  id: controller.notificationListModel.value
                                          .data?.data?[index].id ??
                                      0);
                            },
                            // data: controller.data.value,
                          ),
                        ),
                      ),
                    ),
                    if (!controller.isLoading.value &&
                        (controller.notificationListModel.value.data?.data ??
                                [])
                            .isEmpty)
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            SizedBox(
                              height:32.h// AppDimensions.sectionPaddingVer,
                            ),
                            Image.asset(
                              AppImagePath.noNotificationIcon,
                              height: 70,
                            ),
                            SizedBox(
                              height:16.h// AppDimensions.widgetPaddingVer,
                            ),
                            const HeaderText(
                              text:
                                  "You don't have any new notifications at the moment.",
                              maxLine: 10,
                              align: TextAlign.start,
                            )
                          ],
                        ),
                      ),
                    if(controller.loadingMore.value)const Center(child: CircularProgressIndicator(color: AppColors.primaryColor,),)
                  ],
                ),
              ),
            ),
            if (controller.isLoading.value) const LoadingScreen(),
          ],
        ),
      ),
    );
  }

  Widget notificationDialog({required int index}) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal:24.w,// AppDimensions.horizontalPadding,
            vertical:24.h// AppDimensions.verticalPadding
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.r)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderText(
              text: controller.notificationListModel.value.data?.data?[index]
                      .classType ??
                  "",
              maxLine: 5,
              align: TextAlign.start,
            ),
            BodyText(
              text: controller
                      .notificationListModel.value.data?.data?[index].message ??
                  "",
              maxLine: 50,
              align: TextAlign.start,
            ),
            SizedBox(
              height:32.h// AppDimensions.sectionPaddingVer,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppButton(
                  text: "Back",
                  onTap: () {
                    Get.back();
                  },
                  bgColor: AppColors.primaryColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
   void loadMoreData() {
     // currentPosition.value=_scrollController.position.pixels;
     if (_scrollController.position.pixels ==
         _scrollController.position.maxScrollExtent) {
       if (controller.notificationListModel.value.data?.currentPage !=
           controller.notificationListModel.value.data?.lastPage &&
           !controller.loadingMore.value) {
         controller.loadMore(
           url: controller.notificationListModel.value.data?.nextPageUrl,
         );
       }
     }
   }
}
