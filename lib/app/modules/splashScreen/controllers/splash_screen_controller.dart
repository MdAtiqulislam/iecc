import 'package:get/get.dart';
import 'package:iecc/app/data/user_data_model.dart';
import 'package:iecc/app/routes/app_pages.dart';
import 'package:iecc/services/local_services.dart';
import 'package:iecc/app/utils/extensions.dart';


class SplashScreenController extends GetxController {

  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }


  @override
  void onClose() {}

  void fetchData() async {
    Future.delayed(const Duration(milliseconds: 500));
    await LocalServices.getToken().then((value) async {
      if (value != null) {
        await LocalServices.getUser().then((value) async {
          if (await (value ?? UserDataModel()).userStatus()) {

            Get.offAndToNamed(Routes.HOME);
          }
          else{
            Get.offAllNamed(Routes.PENDING_PAGE);
          }
        });
      } else {
        Get.offAllNamed(Routes.LOGIN);
      }
    });
  }
}
