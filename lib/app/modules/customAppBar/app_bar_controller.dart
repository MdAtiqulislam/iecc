import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:iecc/app/modules/home/controllers/home_controller.dart';
import 'package:iecc/app/modules/home/models/home_data_model.dart';
import 'package:iecc/app/routes/app_pages.dart';
import 'package:iecc/constraints/api_end_points.dart';
import 'package:iecc/services/local_services.dart';
import 'package:iecc/services/remote_services.dart';
import 'package:share_plus/share_plus.dart';

class AppBarController extends GetxController {
  var isLoading = false.obs;
  var homeData = HomeDataModel().obs;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    var endPoint = APIEndPoints.getHomeData;
    await RemoteServices.getRequest(endPoint: endPoint).then((value) async {
      if (value != null) {
        homeData.value = HomeDataModel.fromJson(value);
       await LocalServices.storeQForm(homeData.value.data?.qFormLink??"");
        Get.put(HomeController());
        Get.find<HomeController>().homeDataModel.value = homeData.value;
      }
    });
  }

  void editUserInfo() {}

  void openNotification() {
    Get.toNamed(Routes.NOTIFICATION_PAGE);
  }

  void qFormShare()async {
 await LocalServices.getQForm().then((value){
   if (value==null) {
     isLoading.value=true;
     fetchData().then((value) {
       shareLink(link: homeData.value.data?.qFormLink ?? "");
       isLoading.value=false;
     });
   } else {
     shareLink(link: value);
   }

 });



  }

  Future<void> shareLink({required String link}) async {
    final box = Get.context?.findRenderObject() as RenderBox?;
    try {
      await Share.share(
          "Please register via this link\n$link",
          subject: "Q-form link",
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    } on Exception catch (e) {
      print(e);
    }

  }
}
