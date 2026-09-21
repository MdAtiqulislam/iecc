import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:iecc/app/modules/home/views/empty_screen.dart';
import 'package:iecc/app/modules/home/views/student_list_screen.dart';
import 'package:iecc/app/modules/customAppBar/custom_app_bar.dart';
import 'package:iecc/common_widgets/custom_bottom_nav_bar.dart';
import 'package:iecc/common_widgets/my_drawer.dart';
import 'package:iecc/common_widgets/shimmer_screen.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
      Obx(
        () => (controller.isLoading.value || controller.isLoadingLeadList.value)
            ? const ShimmerScreen()
            : Scaffold(
                key: scaffoldKey,
                appBar: CustomAppBar(
                  minimal: false,
                  scaffoldKey: scaffoldKey,
                  showBackButton: false,
                  /*openDrawer: () {
            _scaffoldKey.currentState!.openDrawer();
          },*/
                ),
                drawer: MyDrawer(),
                bottomNavigationBar: CustomBottomNavBar(
                  disable: !controller.isLoadingLeadList.value,
                ),
                body: RefreshIndicator(
                  onRefresh: () {
                    return Future.delayed(const Duration(seconds: 1),
                        () => controller.reloadData());
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 24.w, //AppDimensions.horizontalPadding,
                        vertical: 16.h //AppDimensions.widgetPaddingVer
                        ),
                    child: homeScreen(),
                  ),
                ),
              ),
      ),
    );
  }

  Widget homeScreen() {
    return controller.isLoadingLeadList.value
        ? const ShimmerScreen()
        : (controller.leadListModel.value.data?.data?.length ?? 0) <= 0
            ? const EmptyScreen()
            : StudentListScreen();
  }
}
