import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iecc/app/modules/otpPage/views/single_otp_box.dart';
import 'package:iecc/common_widgets/app_button.dart';
import 'package:iecc/app/modules/customAppBar/custom_app_bar.dart';
import 'package:iecc/common_widgets/custom_loading_screen.dart';
import 'package:iecc/common_widgets/custom_text_field.dart';
import 'package:iecc/common_widgets/show_hide_password_button.dart';
import 'package:iecc/constraints/header_text.dart';

import '../../../../constraints/app_colors.dart';
import '../../../../constraints/app_strings.dart';
import '../../../../constraints/body_text.dart';
import '../../../routes/app_pages.dart';
import '../controllers/otp_page_controller.dart';

class OtpPageView extends GetView<OtpPageController> {
  OtpPageView({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        bottomNavigationBar: bottomNavBar(),
        body: Obx(
          () => Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 24.w//AppDimensions.horizontalPadding
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height:32.h// AppDimensions.sectionPaddingVer,
                      ),
                      titleSection(),
                      SizedBox(
                        height:32.h// AppDimensions.sectionPaddingVer,
                      ),
                      if (!controller.isResetPassword.value) userInfoSection(),
                      SizedBox(
                        height:32.h// AppDimensions.sectionPaddingVer,
                      ),
                      otpSection(),
                      SizedBox(
                        height:32.h// AppDimensions.sectionPaddingVer,
                      ),
                      IgnorePointer(
                          ignoring: !controller.isValidate.value,
                          child: passwordSection()),
                    ],
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
          horizontal:24.w,// AppDimensions.horizontalPadding,
          vertical:24.h// AppDimensions.verticalPadding
      ),
      child: Row(
        children: [
          BodyText(text: AppTitlesAndKeys.haveAccountButtonTextKey.tr),
          SizedBox(
            width:8.w// AppDimensions.contentPaddingHor,
          ),
          InkWell(
            onTap: () {
              Get.offAndToNamed(Routes.LOGIN);
            },
            child: BodyText(
              text: AppTitlesAndKeys.logInButtonTextKey.tr,
              fontWeight: FontWeight.bold,
              color: AppColors.secondaryLightColor,
            ),
          )
        ],
      ),
    );
  }

  Widget userInfoSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: HeaderText(
                text: controller.name.value,
                maxLine: 2,
                align: TextAlign.start,
              ),
            ),
            SizedBox(
              width:16.w// AppDimensions.widgetPaddingHor,
            ),
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Image.asset(AppImagePath.editIcon),
            )
          ],
        ),
        SizedBox(
          height:8.h// AppDimensions.contentPaddingVer,
        ),
        BodyText(text: "Email: ${controller.email.value}"),
        BodyText(text: "Phone: ${controller.phone.value}"),
        BodyText(text: controller.occupation.value),
        BodyText(text: "${controller.city}, ${controller.country.value.name}"),
      ],
    );
  }

  Widget otpSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HeaderText(
          text:
              "Please enter the 6-digit code we have just sent to your email.",
          size: 12,
          fontWeight: FontWeight.w600,
          color: Colors.black,
          maxLine: 3,
          align: TextAlign.start,
        ),
        BodyText(
          text: "(${controller.email.value})",
          size: 10,
          maxLine: 2,
        ),
        SizedBox(
          height: 16.h//AppDimensions.widgetPaddingVer,
        ),
        Row(
          children: [
            SingleOTPBox(
              isEnabled: !controller.isValidate.value,
              controller: controller.c1,
              onCompleted: (value) {
                controller.checkOtpLength(value);
              },
            ),
            SizedBox(width: 5.w //Dimensions.contentPaddingHor,
                ),
            SingleOTPBox(
              isEnabled: !controller.isValidate.value,
              controller: controller.c2,
              onCompleted: (value) {
                controller.checkOtpLength(value);
              },
            ),
            SizedBox(width: 5.w //Dimensions.contentPaddingHor,
                ),
            SingleOTPBox(
              isEnabled: !controller.isValidate.value,
              controller: controller.c3,
              onCompleted: (value) {
                controller.checkOtpLength(value);
              },
            ),
            SizedBox(width: 5.w //Dimensions.contentPaddingHor,
                ),
            const HeaderText(
              text: "-",
              size: 30,
              color: AppColors.inactiveColor,
            ),
            SizedBox(width: 5.w //Dimensions.contentPaddingHor,
                ),
            SingleOTPBox(
              isEnabled: !controller.isValidate.value,
              controller: controller.c4,
              onCompleted: (value) {
                controller.checkOtpLength(value);
              },
            ),
            SizedBox(width: 5.w //Dimensions.contentPaddingHor,
                ),
            SingleOTPBox(
              isEnabled: !controller.isValidate.value,
              controller: controller.c5,
              onCompleted: (value) {
                controller.checkOtpLength(value);
              },
            ),
            SizedBox(width: 5.w //Dimensions.contentPaddingHor,
                ),
            SingleOTPBox(
              isEnabled: !controller.isValidate.value,
              controller: controller.c6,
              onCompleted: (value) {
                if (value!.length == 1) {
                  controller.verifyOTP();
                }
                controller.checkOtpLength(value);
              },
              isLast: true,
            ),
            SizedBox(
              width: 5.w,
            ),
            Visibility(
              visible: controller.isValidate.value,
              child: Image.asset(AppImagePath.checkIcon),
            ),
          ],
        ),
        SizedBox(
          height:16.h// AppDimensions.widgetPaddingVer,
        ),
        IgnorePointer(
          ignoring: controller.isValidate.value,
          child: Row(
            children: [
              Text(
                "Didn’t receive the code?",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: AppColors.bodyTextColor,
                    fontStyle: FontStyle.italic,
                    fontSize: 12.sp),
              ),
              SizedBox(
                width:16.w// AppDimensions.widgetPaddingHor,
              ),
              //  HeaderText(text: "Resend code"),
              if (controller.resendOtpTime.value > 0)
                Container(
                  width: 100.w,
                  padding: EdgeInsets.symmetric(vertical: 3.h),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(15.r),
                      color: AppColors.inactiveColor),
                  child: HeaderText(
                    text:
                        "${controller.resendOtpTime.value ~/ 60} : ${controller.resendOtpTime.value % 60}",
                    color: AppColors.primaryColor,
                    size: 12,
                  ),
                ),
              if (controller.resendOtpTime.value <= 0)
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(15.r),
                      color: controller.isValidate.value?AppColors.primaryColor.withOpacity(.5):AppColors.primaryColor
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Colors.white54,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:24.w,// AppDimensions.horizontalPadding,
                            vertical: 3.h),
                        child: const HeaderText(
                          text: "Resend OTP",
                          color: Colors.white,
                          size: 12,
                        ),
                      ),
                      onTap: () {
                        controller.resendOTP();
                      },
                    ),
                  ),
                )
            ],
          ),
        )
      ],
    );
  }

  Widget passwordSection() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            isRequired: true,
            levelText: "Set Password",
            isPassword: !controller.showPassword.value,
            suffix: ShowHidePasswordButton(
              showPassword: controller.showPassword.value,
              onTap: () => controller.showPassword.value =
                  !controller.showPassword.value,
            ),
            /*validator: (value) {
              return (value ?? "").isEmpty
                  ? "Password is Required"
                  : (value!.isValidPassword() ? null : "your password must be at least 8 characters long and include a combination of uppercase and lowercase letters, numbers, and special characters.");
            },*/
            validatorText: "Password is Required",
            controller: controller.passwordController,
          ),
          SizedBox(
            height: 16.h//AppDimensions.widgetPaddingVer,
          ),
          CustomTextField(
            isRequired: true,
            levelText: "Confirm Password",
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
            controller: controller.confirmPasswordController,
          ),
          SizedBox(
            height:32.h// AppDimensions.sectionPaddingVer,
          ),
          AppButton(
            text: controller.isResetPassword.value ? "Reset" : "Sign Up",
            onTap: () {
              if (_formKey.currentState?.validate() ?? false) {
                controller.isResetPassword.value
                    ? controller.resetPassword()
                    : controller.completeRegistration();
              }
              //Get.toNamed(Routes.PENDING_PAGE);
            },
            bgColor: controller.isValidate.value
                ? AppColors.primaryColor
                : AppColors.primaryColor.withOpacity(.5),
            showBorder: false,
          )
        ],
      ),
    );
  }

  Widget titleSection() {
    return controller.isResetPassword.value
        ? Text.rich(
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 25.sp,
              fontWeight: FontWeight.w600,
            ),
            const TextSpan(
                text: "Reset your ",
                style: TextStyle(
                  color: AppColors.headerTextColor,
                ),
                children: [
                  TextSpan(
                    text: "Password",
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                ])
            /*text: AppTitlesAndKeys.loginPageWelcomeText.tr,
                  size: 25,
                  maxLine: 5,
                  align: TextAlign.start,*/
            )
        : Text.rich(
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 25.sp,
              fontWeight: FontWeight.w600,
            ),
            const TextSpan(
                text: "Confirm your ",
                style: TextStyle(
                  color: AppColors.headerTextColor,
                ),
                children: [
                  TextSpan(
                    text: "Information",
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                ])
            /*text: AppTitlesAndKeys.loginPageWelcomeText.tr,
                  size: 25,
                  maxLine: 5,
                  align: TextAlign.start,*/
            );
  }
}
