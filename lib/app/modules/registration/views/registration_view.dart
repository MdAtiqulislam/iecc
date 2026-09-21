import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iecc/app/utils/extensions.dart';
import 'package:iecc/app/modules/registration/models/office_list_model.dart';
import 'package:iecc/app/routes/app_pages.dart';
import 'package:iecc/app/modules/customAppBar/custom_app_bar.dart';
import 'package:iecc/common_widgets/custom_country_dropdown.dart';
import 'package:iecc/common_widgets/custom_loading_screen.dart';
import 'package:iecc/common_widgets/custom_office_dropdown.dart';
import 'package:iecc/common_widgets/custom_phone_text_field.dart';
import 'package:iecc/constraints/app_strings.dart';

import '../../../../common_widgets/app_button.dart';
import '../../../../common_widgets/custom_text_field.dart';
import '../../../../constraints/app_colors.dart';
import '../../../../constraints/body_text.dart';
import '../../../../constraints/header_text.dart';
import '../controllers/registration_controller.dart';
import '../models/country_list_model.dart';

class RegistrationView extends GetView<RegistrationController> {
  RegistrationView({super.key});

  final _formKey = GlobalKey<FormState>();
  final suggestionBoxController = SuggestionsBoxController();

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
                        horizontal: 24.w //AppDimensions.horizontalPadding
                        ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 32.h //AppDimensions.sectionPaddingVer,
                            ),
                        Text.rich(
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 25.sp),
                          const TextSpan(
                              text: "Wants to be ",
                              style: TextStyle(
                                color: AppColors.headerTextColor,
                              ),
                              children: [
                                TextSpan(
                                    text: "registered?",
                                    style: TextStyle(
                                        color: AppColors.primaryColor))
                              ]),
                        ),
                        SizedBox(
                            height: 32.h // AppDimensions.sectionPaddingVer,
                            ),
                        registrationForm(),
                        SizedBox(
                            height: 32.h // AppDimensions.sectionPaddingVer,
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
          horizontal: 24.w, //AppDimensions.horizontalPadding,
          vertical: 24.h //AppDimensions.verticalPadding
          ),
      child: Row(
        children: [
          BodyText(text: AppTitlesAndKeys.haveAccountButtonTextKey.tr),
          SizedBox(width: 8.w //AppDimensions.contentPaddingHor,
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

/*  Widget phoneTextField() {
    return CustomTextField(
      isRequired: true,
      hintText: "0000 000 000",
      levelText: "Contact No",
      validatorText: "Contact No is required",
      controller: controller.phoneController,
      textInputType: TextInputType.phone,
      preFix: SizedBox(
        width: 120.w,
        //height: 100,
        child: Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<SingleCountry>(
                isExpanded: false,

                selectedItemBuilder: (_) {
                  return controller.countryList
                      .map<Widget>((SingleCountry item) {
                    return Text(item.iso31662.toString(),
                        style: const TextStyle(color: AppColors.bodyTextColor));
                  }).toList();
                },
                decoration: const InputDecoration(border: InputBorder.none),
                iconDisabledColor: AppColors.primaryColor,
                iconEnabledColor: AppColors.primaryColor,
                padding:
                    EdgeInsets.only(left: 24.w //AppDimensions.horizontalPadding
                        ),
                items: controller.countryList
                    .map<DropdownMenuItem<SingleCountry>>(
                        (SingleCountry value) {
                  return DropdownMenuItem<SingleCountry>(
                    value: value,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        BodyText(
                          text: value.name ?? "",
                          size: 8,
                          maxLine: 2,
                          align: TextAlign.start,
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.network(
                              value.flagUrl ?? "",
                              height: 20,
                            ),
                            SizedBox(
                                width: 16.w //AppDimensions.widgetPaddingHor,
                                ),
                            Expanded(
                              child: Text(
                                value.iso31662.toString(),
                                style: const TextStyle(
                                    color: AppColors.bodyTextColor),
                              ),
                            ),
                          ],
                        ),
                        const Divider()
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (SingleCountry? value) {
                  controller.selectedCountry.value = value ?? SingleCountry();
                  controller.countryController.text = value?.name ?? "";
                },
                value: controller.selectedCountry.value,
              ),
            ),
            HeaderText(
                text: "+${controller.selectedCountry.value.callingCode ?? ""} ")
          ],
        ),
      ),
    );
  }*/



  Widget officeDropdown() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color:Colors.transparent),
      child: Column(
        children: [
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller.officeController,
            builder: (context, value, child) {
              // Fetch filtered suggestions based on the current text input
              List<SingleOffice> suggestions = getSuggestions(value.text);

              return DropdownMenu<SingleOffice>(
                hintText: "Select Nearest Office *",
                label: const Text("Select Nearest Office *"),
                onSelected: (selectedOffice) {
                  // Update the selected office and the text field
                  controller.selectedOffice.value = selectedOffice!;
                  controller.officeController.text = selectedOffice.name ?? "";
                },
                menuHeight: 300.h,
                trailingIcon: const Icon(
                  Icons.arrow_drop_down_sharp,
                  color: AppColors.primaryColor,
                ),
                selectedTrailingIcon: const Icon(
                  Icons.arrow_drop_up_sharp,
                  color: AppColors.primaryColor,
                ),
                width: Get.width - (24.w * 2),
                inputDecorationTheme: InputDecorationTheme(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: const BorderSide(color: AppColors.inactiveColor),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: const BorderSide(color: AppColors.inactiveColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: const BorderSide(color: AppColors.levelTextColor),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: const BorderSide(color: AppColors.primaryColor),
                  ),
                  contentPadding: EdgeInsets.only(
                    left: 24,
                    bottom: 16.h,
                    top: 16.h,
                  ),
                  floatingLabelStyle: const TextStyle(
                    color: AppColors.headerTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                  hintStyle: const TextStyle(
                    color: AppColors.levelTextColor,
                    fontSize: 14,
                  ),
                  labelStyle: const TextStyle(
                    color: AppColors.levelTextColor,
                    fontSize: 12,
                  ),
                ),
                requestFocusOnTap: true,
                controller: controller.officeController,
                dropdownMenuEntries: suggestions
                    .map<DropdownMenuEntry<SingleOffice>>((SingleOffice office) {
                  return DropdownMenuEntry<SingleOffice>(
                    value: office,
                    label: office.name ?? "",
                    enabled: true,
                    labelWidget: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.symmetric(
                          horizontal: 24.w,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BodyText(
                              text: office.name ?? "",
                              fontWeight: FontWeight.bold,
                              align: TextAlign.start,
                            ),
                            BodyText(
                              text: office.address ?? "",
                              size: 10,
                              align: TextAlign.start,
                            ),
                            const Divider(),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
                textStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.headerTextColor,
                ),
              );
            },
          )

        ],
      ),
    );
  }

  Widget registrationForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomOfficeDropdown(
            hintText: "Select Nearest Office",
            labelText: "Select Nearest Office",
            required: true,
            officeList: controller.officeList,
            onChange: (value) {
              controller.selectedOffice.value = value;
              controller.officeController.text = value.name ?? "";
            },
          ),
          //officeDropdown(),
          SizedBox(height: 16.h //AppDimensions.widgetPaddingVer,
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
          CustomTextField(
            isRequired: true,
            hintText: "xyz@mail.com",
            levelText: "Email",
          //  textInputType: TextInputType.emailAddress,
            validator: (value) {
              return (value ?? "").isEmpty
                  ? "Email is Required"
                  : (value!.isValidEmail() ? null : "Email is not valid");
            },
            controller: controller.emailController,
          ),

          if(controller.isEmailExist.value)Padding(
            padding: EdgeInsets.only(left: 3.0.w),
            child: const BodyText(
              text:
                  "Email already exist",
              size: 10,
              align: TextAlign.start,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 16.h // AppDimensions.widgetPaddingVer,
              ),

          CustomPhoneTextField(
            callingCode:
                controller.selectedPhoneCountry.value.callingCode ?? "",
            countryList: controller.countryList,
            selectedCountry: controller.selectedPhoneCountry.value,
            onChange: (value) {
              controller.selectedPhoneCountry.value = value;
              controller.phoneCountryController.text = value.iso31662 ?? "";
            },
            controller: controller.phoneController,
          ),
          //  phoneTextField(),
          SizedBox(height: 16.h // AppDimensions.widgetPaddingVer,
              ),
          CustomCountryDropdown(
            labelText: "Present Country",
            hintText: "Present Country",
            required: true,
            countryList: controller.countryList,
            onChange: (value) {
              controller.selectedCountry.value = value;
              controller.countryController.text = value.name ?? "";
            },
          ),
          /*CustomTextField(
            isRequired: true,
            hintText: "Present Country",
            levelText: "Present Country",
            validatorText: "Country is required",
            controller: controller.countryController,
          ),*/
          SizedBox(height: 16.h // AppDimensions.widgetPaddingVer,
              ),
          CustomTextField(
            isRequired: true,
            hintText: "Present City",
            levelText: "Present City",
            validatorText: "City is required",
            controller: controller.cityController,
          ),
          SizedBox(height: 16.h // AppDimensions.widgetPaddingVer,
              ),
          CustomTextField(
            isRequired: true,
            hintText: "Occupation",
            levelText: "Occupation",
            validatorText: "Occupation is required",
            controller: controller.occupationController,
          ),
          SizedBox(height: 32.h // AppDimensions.sectionPaddingVer,
              ),
          AppButton(
            text: "Next",
            onTap: () {
              if (_formKey.currentState?.validate() ?? false) {
                controller.getOTP();
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
