import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iecc/app/utils/extensions.dart';
import 'package:iecc/common_widgets/app_button.dart';
import 'package:iecc/app/modules/customAppBar/custom_app_bar.dart';
import 'package:iecc/common_widgets/custom_loading_screen.dart';
import 'package:iecc/common_widgets/custom_text_field.dart';
import 'package:iecc/common_widgets/show_hide_password_button.dart';
import 'package:iecc/constraints/app_colors.dart';
import 'package:iecc/constraints/app_strings.dart';
import 'package:iecc/constraints/body_text.dart';
import 'package:iecc/constraints/header_text.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({super.key});

  final _formKey = GlobalKey<FormState>();
  final _resetPasswordFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        bottomNavigationBar: bottomNavBar(),
        body: Obx(
          () => Stack(
            children: [
              Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 24.w // AppDimensions.horizontalPadding
                        ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: 32.h // AppDimensions.sectionPaddingVer,
                            ),
                        Text.rich(
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          const TextSpan(
                              text: "Referral ",
                              style: TextStyle(
                                color: AppColors.primaryColor,
                              ),
                              children: [
                                TextSpan(
                                  text: "App",
                                  style: TextStyle(
                                      color: AppColors.headerTextColor),
                                ),
                              ]),
                        ),
                        SizedBox(
                            height: 64.h //AppDimensions.sectionPaddingVer * 2,
                            ),
                        Text.rich(
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            const TextSpan(
                                text: "Welcome to ",
                                style: TextStyle(
                                  color: AppColors.headerTextColor,
                                ),
                                children: [
                                  TextSpan(
                                      text: "IECC",
                                      style: TextStyle(
                                          color: AppColors.primaryColor))
                                ])),
                        SizedBox(
                          height: 24.h,
                        ),
                        loginForm(),
                        forgotPasswordSection(),
                        Divider(),
                        Container(
                          width: Get.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              BodyText(
                                text:
                                    AppTitlesAndKeys.noAccountButtonTextKey.tr,
                                color: AppColors.headerTextColor,
                              ),
                              SizedBox(
                                  width: 8.w // AppDimensions.contentPaddingHor,
                                  ),
                              InkWell(
                                onTap: () {
                                  Get.offAndToNamed(Routes.REGGISTRATION);
                                },
                                child: BodyText(
                                  text: AppTitlesAndKeys.signUpTextKey.tr,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.secondaryLightColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 32.h //AppDimensions.sectionPaddingVer,
                            ),
                      ],
                    ),
                  ),
                ),
              ),
              if (controller.isLoading.value) const LoadingScreen()
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomNavBar() {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: 24.w, // AppDimensions.horizontalPadding,
            vertical: 24.h // AppDimensions.verticalPadding
            ),
        child: BodyText(
          text: "Copyright @ IECC",
          align: TextAlign.start,
        )

        );
  }

  Widget loginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            hintText: AppTitlesAndKeys.phoneOrEmailTFHint.tr,
            levelText: AppTitlesAndKeys.phoneOrEmailTFTitle.tr,
           // textInputType: TextInputType.emailAddress,
            validator: (value) {
              return (value ?? "").isEmpty
                  ? "Email is Required"
                  : (value!.isValidEmail() ? null : "Email is not valid");
            },
            controller: controller.emailController,
          ),
          SizedBox(height: 16.h //AppDimensions.widgetPaddingVer,
              ),
          CustomTextField(
            hintText: AppTitlesAndKeys.passwordTFHint.tr,
            levelText: AppTitlesAndKeys.passwordTFTitle.tr,
            isPassword: !controller.showPassword.value,
            suffix: ShowHidePasswordButton(
              showPassword: controller.showPassword.value,
              onTap: () => controller.showPassword.value =
                  !controller.showPassword.value,
            ),
            validatorText: "Password is Required",
            /*validator: (value) {
              return (value ?? "").isEmpty
                  ? "Password is Required"
                  : (value!.isValidPassword() ? null : "your password must be at least 8 characters long and include a combination of uppercase and lowercase letters, numbers, and special characters.");
            },*/
            controller: controller.passwordController,
          ),
          SizedBox(height: 32.h // AppDimensions.sectionPaddingVer,
              ),
          AppButton(
            text: AppTitlesAndKeys.logInButtonTextKey.tr,
            onTap: () {
              if (_formKey.currentState?.validate() ?? false) {
                controller.login();
              }
            },
            bgColor: AppColors.primaryColor,
          ),
          SizedBox(height: 16.h // AppDimensions.widgetPaddingVer,
              ),

          /* AppButton(
            text: AppTitlesAndKeys.registrationTextKey.tr,
            onTap: () {
              Get.toNamed(Routes.REGGISTRATION);
            },
            // bgColor: AppColors.primaryColor,
            borderColor: AppColors.inactiveColor,
            textColor: AppColors.headerTextColor,
          ),
          SizedBox(
            height:8.h//AppDimensions.contentPaddingVer,
          ),*/
        ],
      ),
    );
  }

  Widget forgotPasswordSection() {
    return Center(
      child: InkWell(
        onTap: () {
          Get.bottomSheet(
            clipBehavior: Clip.hardEdge,
            isScrollControlled: true,
            Obx(() => SingleChildScrollView(
                  child: Container(
                    //height: 150,
                    width: Get.width,
                    color: Colors.white,
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.w,
                              // AppDimensions.horizontalPadding,
                              vertical: 24.h //AppDimensions.verticalPadding
                              ),
                          child: Form(
                            key: _resetPasswordFormKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.info_outlined,
                                  color: AppColors.primaryColor,
                                  size: 80.sp,
                                ),
                                SizedBox(
                                    height:
                                        32.h // AppDimensions.sectionPaddingVer,
                                    ),
                                const HeaderText(
                                  text: "Forgot Password",
                                  fontWeight: FontWeight.w700,
                                ),
                                SizedBox(
                                    height:
                                        8.h //AppDimensions.widgetPaddingVer,
                                    ),
                                const BodyText(
                                    text:
                                        "Enter your email and we will send you an OTP to reset your password."),
                                SizedBox(
                                    height:
                                        32.h // AppDimensions.sectionPaddingVer,
                                    ),
                                CustomTextField(
                                  isRequired: true,
                                  levelText: "Email",
                                  hintText: "Enter your email",
                                 // textInputType: TextInputType.emailAddress,
                                  validator: (value) {
                                    return (value ?? "").isEmpty
                                        ? "Email is Required"
                                        : (value!.isValidEmail()
                                            ? null
                                            : "Email is not valid");
                                  },
                                  controller: controller.emailController,
                                ),
                                SizedBox(
                                    height:
                                        32.h // AppDimensions.sectionPaddingVer,
                                    ),
                                AppButton(
                                  text: "Submit",
                                  onTap: () {
                                    if (_resetPasswordFormKey.currentState
                                            ?.validate() ??
                                        false) {
                                      controller.getOTPForResetPassword();
                                    }
                                  },
                                  bgColor: AppColors.primaryColor,
                                ),
                                SizedBox(
                                    height:
                                        32.h // AppDimensions.sectionPaddingVer,
                                    ),
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.arrow_back_ios,
                                        size: 14,
                                      ),
                                      BodyText(text: "Back to Login")
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        if (controller.isLoading.value)
                          Positioned(
                            top: 0,
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              color: Colors.black12,
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
                )),
            // barrierColor: Colors.red[50],
            isDismissible: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15.r),
                topLeft: Radius.circular(15.r),
              ),
            ),
            enableDrag: false,
          );
        },
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: BodyText(text: "Forgot your password?"),
        ),
      ),
    );
  }
}
