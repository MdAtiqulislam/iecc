
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:iecc/app/utils/extensions.dart';
import 'package:iecc/app/data/user_data_model.dart';
import 'package:iecc/app/modules/login/models/login_model.dart';
import 'package:iecc/app/modules/otpPage/controllers/otp_page_controller.dart';
import 'package:iecc/app/routes/app_pages.dart';
import 'package:iecc/common_widgets/custom_snackbar.dart';
import 'package:iecc/constraints/api_end_points.dart';
import 'package:iecc/services/local_services.dart';
import 'package:iecc/services/remote_services.dart';

class LoginController extends GetxController {
  final showPassword = false.obs;
  final isLoading = false.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final loginModel = LoginModel().obs;



  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void onClose() {}

  void login() async {
    isLoading.value = true;
    var body = {
      "email": emailController.text,
      "password": passwordController.text
    };
    RemoteServices.postRequest(endPoint: APIEndPoints.login, body: body)
        .then((value) async {
      if (value != null) {
        loginModel.value = LoginModel.fromJson(value);
        await LocalServices.storeToken(loginModel.value.apiToken ?? "");
        await LocalServices()
            .storeUser(loginModel.value.data ?? UserDataModel());
        isLoading.value = false;
        if(await (loginModel.value.data??UserDataModel()).userStatus()){
          Get.offAllNamed(Routes.HOME);
        }else{
          Get.offAllNamed(Routes.PENDING_PAGE);
        }
      } else {
        isLoading.value = false;
        CustomSnackBar(
                msg: APIEndPoints.httpErrorMSG.value,
                isSuccess: false,
                duration: 3)
            .showSnackBar();
      }
    });
  }

  void getOTPForResetPassword() async {
    isLoading.value=true;
    var endPoint = APIEndPoints.getOTP;
    var body = {
      "email": emailController.text,
      "source":"reset_password",
      "office_id":"0"
    };

    await RemoteServices.postRequest(endPoint: endPoint, body: body)
        .then((value) {
          if(value!=null){
            Get.back();
            var otpController=Get.put(OtpPageController());
            otpController.isResetPassword.value=true;
            otpController.email.value=emailController.text;
            isLoading.value=false;
            Get.toNamed(Routes.OTP_PAGE);
          }else{
            CustomSnackBar(
              isSuccess: false,
              msg: APIEndPoints.httpErrorMSG.value
            ).showSnackBar();
            isLoading.value=false;
          }

    });
  }
}
