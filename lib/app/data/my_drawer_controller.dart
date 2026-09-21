import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iecc/app/data/user_info_model.dart';
import 'package:iecc/app/modules/customAppBar/app_bar_controller.dart';
import 'package:iecc/app/modules/registration/models/country_list_model.dart';
import 'package:iecc/app/routes/app_pages.dart';
import 'package:iecc/common_widgets/app_button.dart';
import 'package:iecc/common_widgets/custom_snackbar.dart';
import 'package:iecc/constraints/api_end_points.dart';
import 'package:iecc/constraints/app_colors.dart';
import 'package:iecc/constraints/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iecc/app/data/user_data_model.dart';
import 'package:iecc/app/utils/utils.dart';
import 'package:iecc/constraints/body_text.dart';
import 'package:iecc/constraints/header_text.dart';
import 'package:iecc/services/local_services.dart';
import 'package:iecc/services/remote_services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class MyDrawerController extends GetxController {
  var isLoading = false.obs;
  var userData = UserDataModel().obs;
  var countryList = <SingleCountry>[].obs;

  @override
  void onInit() {
    getUserData();
    super.onInit();
  }

  void getCounterData() async {
    await RemoteServices.getCountryList().then((value) {
      if (value != null) {
        countryList.value = value;
      }
    });
  }

  void getUserData() async {
    await LocalServices.getUser().then((value) {
      if (value != null) {
        userData.value = value;
        getCounterData();
      }
    });
  }

  void reloadUserData() async {
    var endPoint = APIEndPoints.getUserData;
    var userInfoModel = UserInfoModel();
    await RemoteServices.getRequest(endPoint: endPoint).then((value) async {
      if (value != null) {
        userInfoModel = UserInfoModel.fromJson(value);
        userData.value = userInfoModel.data ?? UserDataModel();
        await LocalServices().storeUser(userData.value).then((value) {
          /*AppBarController appBarController =*/
          Get.put(AppBarController());
          Get.find<AppBarController>().fetchData();
          Get.find<AppBarController>().refresh();
        });
      }
    });
  }

  Future<void> selectImage({required ImageSource source}) async {
    picImage(source).then((value) async {
      if (value != null) {
        Get.back();
        await cropImage(filePath: value.path).then((value) async {
          if (value != null) {
            {
              var f = await value.readAsBytes();
              showDialog(
                  context: Get.context!,
                  builder: (_) {
                    return Obx(
                      () => Dialog(
                        clipBehavior: Clip.hardEdge,
                        child: SingleChildScrollView(
                          child: Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24.w
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 32.h,
                                    ),
                                    Container(
                                        width: 200,
                                        height: 200,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle),
                                        child: Image.memory(
                                          f,
                                          fit: BoxFit.cover,
                                        )),
                                    SizedBox(
                                      height:32.h,// AppDimensions.sectionPaddingVer,
                                    ),
                                    AppButton(
                                      text: 'Submit',
                                      onTap: () {
                                        uploadImage(file: value);
                                      },
                                      bgColor: AppColors.primaryColor,
                                    ),
                                    SizedBox(
                                      height: 32.h//AppDimensions.sectionPaddingVer,
                                    )
                                  ],
                                ),
                              ),
                              if (isLoading.value)
                                Positioned(
                                  top: 0,
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    color: Colors.black38,
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
          }
        });
      }
    });
  }

  void uploadImage({required CroppedFile file}) async {
    isLoading.value = true;
    var endPoint = APIEndPoints.uploadProfilePic;

    await RemoteServices.uploadImages(
            image: File(file.path), endPoint: endPoint)
        .then((value) {
      if (value != null) {
        reloadUserData();
        isLoading.value = false;
        Get.back();
        CustomSnackBar(msg: value["msg"], isSuccess: true).showSnackBar();
      } else {
        CustomSnackBar(msg: APIEndPoints.httpErrorMSG.value, isSuccess: false)
            .showSnackBar();
        isLoading.value = false;
      }
    });
  }

  void updateUser() {
    Get.toNamed(Routes.EDIT_PROFILE_PAGE);
  }

  void logOut() {
    showDialog(
        context: Get.context!,
        builder: (buildContext) {
          return Dialog(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 24.w,//AppDimensions.horizontalPadding,
                  vertical: 24.h,//AppDimensions.verticalPadding
              ),
              decoration: BoxDecoration(
                color: Colors.white, 
                borderRadius: BorderRadius.circular(15.r)
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  Image.asset(AppImagePath.warningIcon),
                  SizedBox(height: 16.h//AppDimensions.widgetPaddingVer,
                  ),
                  //  const CustomCircleAvatar(width: 50, height: 50, image: AppImagePath.warningIcon),
                    const HeaderText(text: "Are you sure you want to log out?"),
                    SizedBox(height: 32.h//AppDimensions.sectionPaddingVer,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppButton(text: "Cancel", onTap: (){
                          Get.back();
                        },bgColor: AppColors.primaryColor,),
                        SizedBox(width: 16.w//AppDimensions.widgetPaddingHor,
                        ),
                        AppButton(text: "Confirm", onTap: (){
                          Get.offAllNamed(Routes.LOGIN);
                          LocalServices.deleteData();
                        },),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  void removeAccount() async{
    showDialog(
        context: Get.context!,
        builder: (buildContext) {
          return Dialog(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 24.w,//AppDimensions.horizontalPadding,
                vertical: 24.h,//AppDimensions.verticalPadding
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.r)
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(AppImagePath.warningIcon),
                    SizedBox(height: 16.h//AppDimensions.widgetPaddingVer,
                    ),
                    //  const CustomCircleAvatar(width: 50, height: 50, image: AppImagePath.warningIcon),
                    const HeaderText(text: "Are you sure you want to remove your account?",maxLine: 10,),
                    SizedBox(height: 16.h,),
                    const BodyText(text: "If you remove the account, all of your information will be lost permanently.",maxLine: 10,),
                    SizedBox(height: 32.h//AppDimensions.sectionPaddingVer,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppButton(text: "Cancel", onTap: (){
                          Get.back();
                        },bgColor: AppColors.primaryColor,),
                        SizedBox(width: 16.w//AppDimensions.widgetPaddingHor,
                        ),
                        AppButton(text: "Confirm", onTap: () async {

                          isLoading.value=true;
                          var endpoint=APIEndPoints.removeAccount;

                          try{
                            var response=await RemoteServices.getRequest(endPoint: endpoint);
                            if(response!=null){
                              Get.offAllNamed(Routes.LOGIN);
                              LocalServices.deleteData();
                            }else{
                              CustomSnackBar(
                                msg: APIEndPoints.httpErrorMSG.value,
                                isSuccess: false
                              ).showSnackBar();
                            }

                          }finally{
                            isLoading.value=false;
                          }
                        },),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
