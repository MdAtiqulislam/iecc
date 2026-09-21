import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iecc/app/modules/customAppBar/custom_app_bar.dart';
import 'package:iecc/app/modules/registration/models/office_list_model.dart';
import 'package:iecc/app/utils/extensions.dart';
import 'package:iecc/common_widgets/custom_country_dropdown.dart';
import 'package:iecc/common_widgets/custom_office_dropdown.dart';
import 'package:iecc/common_widgets/custom_phone_text_field.dart';
import '../../../../common_widgets/app_button.dart';
import '../../../../common_widgets/custom_loading_screen.dart';
import '../../../../common_widgets/custom_text_field.dart';
import '../../../../constraints/app_colors.dart';
import '../../../../constraints/body_text.dart';
import '../controllers/edit_profile_page_controller.dart';

class EditProfilePageView extends GetView<EditProfilePageController> {
  EditProfilePageView({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: Obx(
          () => Stack(
            children: [
              Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                      horizontal: 24.w //AppDimensions.horizontalPadding
                      ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: 8.h,),
                      const BackButton(
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
                      Text.rich(
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 25.sp),
                        const TextSpan(
                            text: "Wants to ",
                            style: TextStyle(
                              color: AppColors.headerTextColor,
                            ),
                            children: [
                              TextSpan(
                                text: "update the profile?",
                                style: TextStyle(color: AppColors.primaryColor),
                              ),
                            ]),
                      ),
                      SizedBox(height: 32.h // AppDimensions.sectionPaddingVer,
                          ),
                      registrationForm(),
                      SizedBox(height: 32.h //AppDimensions.sectionPaddingVer,
                          ),
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


  Widget registrationForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          IgnorePointer(
            ignoring: controller.disableOffice.value,
            child: CustomOfficeDropdown(
              hintText: "Select Nearest Office",
              labelText: "Select Nearest Office",
              required: true,
              selectedOffice: controller.selectedOffice.value,
              officeList: controller.officeList,
              onChange: (value) {
                controller.selectedOffice.value = value;
                controller.officeController.text = value.name ?? "";
              },
            ),
          ),
          SizedBox(height: 16.h // AppDimensions.widgetPaddingVer,
              ),
          CustomTextField(
            isRequired: true,
            hintText: "Name",
            levelText: "Name",
            validatorText: "Name is required",
            controller: controller.nameController,
            // textInputType: TextInputType.name,
          ),
          SizedBox(height: 16.h //AppDimensions.widgetPaddingVer,
              ),
          IgnorePointer(
            ignoring: true,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: AppColors.inactiveColor.withOpacity(.5)),
              child: CustomTextField(
                isRequired: true,
                hintText: "xyz@mail.com",
                levelText: "Email",
                // textInputType: TextInputType.emailAddress,
                validator: (value) {
                  return (value ?? "").isEmpty
                      ? "Email is Required"
                      : (value!.isValidEmail() ? null : "Email is not valid");
                },
                controller: controller.emailController,
              ),
            ),
          ),
          SizedBox(height: 16.h //AppDimensions.widgetPaddingVer,
              ),

          if (!controller.isLoading.value)
            CustomPhoneTextField(
              countryList: controller.countryList,
              selectedCountry: controller.selectedPhoneCountry.value,
              onChange: (value) {
                controller.selectedPhoneCountry.value = value;
                controller.phoneCountryController.text = value.iso31662 ?? "";
              },
              controller: controller.phoneController,
              callingCode:
                  controller.selectedPhoneCountry.value.callingCode ?? "",
            ),
          // phoneTextField(),
          SizedBox(height: 16.h //AppDimensions.widgetPaddingVer,
              ),
          CustomCountryDropdown(
            labelText: "Present Country",
            countryList: controller.countryList,
            required: true,
            selectedCountry: controller.selectedCountry.value,
            onChange: (value) {
              controller.selectedCountry.value = value;
              controller.countryController.text = value.name ?? "";
            },

          ),

          SizedBox(height: 16.h // AppDimensions.widgetPaddingVer,
              ),
          CustomTextField(
            isRequired: true,
            hintText: "Present City",
            levelText: "Present City",
            validatorText: "City is required",
            controller: controller.cityController,
          ),
          SizedBox(height: 16.h //AppDimensions.widgetPaddingVer,
              ),
          CustomTextField(
            isRequired: true,
            hintText: "Occupation",
            levelText: "Occupation",
            validatorText: "Occupation is required",
            controller: controller.occupationController,
          ),
          SizedBox(height: 32.h //AppDimensions.sectionPaddingVer,
              ),
          AppButton(
            text: "Update",
            onTap: () {
              if (_formKey.currentState?.validate() ?? false) {
                controller.updateUser();
              }
            },
            bgColor: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }

  List<SingleOffice> getSuggestions(String query) {
    List<SingleOffice> matches = <SingleOffice>[];
    matches.addAll(controller.officeList);

    matches.retainWhere(
        (s) => (s.name ?? "").toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}
