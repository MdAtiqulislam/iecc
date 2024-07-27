import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iecc/app/modules/customAppBar/custom_app_bar.dart';
import 'package:iecc/app/modules/registration/models/country_list_model.dart';
import 'package:iecc/app/modules/registration/models/office_list_model.dart';
import 'package:iecc/app/utils/extensions.dart';
import 'package:iecc/common_widgets/custom_country_dropdown.dart';
import 'package:iecc/common_widgets/custom_phone_text_field.dart';
import 'package:iecc/constraints/header_text.dart';

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
                      horizontal: 24.w//AppDimensions.horizontalPadding
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 32.h//AppDimensions.sectionPaddingVer,
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
                      SizedBox(
                        height:32.h// AppDimensions.sectionPaddingVer,
                      ),
                      registrationForm(),
                      SizedBox(
                        height: 32.h//AppDimensions.sectionPaddingVer,
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

  Widget phoneTextField() {
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
                isExpanded: true,
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
                padding: EdgeInsets.only(left: 24.w//AppDimensions.horizontalPadding
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
                              width: 18.w//AppDimensions.widgetPaddingHor,
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
  }

  Widget officeDropdown() {
    return Container(
     decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(15.r),
       color: controller.disableOffice.value?AppColors.inactiveColor.withOpacity(.5):Colors.transparent
     ),
      child: DropDownSearchFormField<SingleOffice>(

        validator: (value) {
          if ((value ?? "").isEmpty) {
            return "Office is required";
          }
          return null;
        },
        textFieldConfiguration: TextFieldConfiguration(
          style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.bodyTextColor),
          controller: controller.officeController,
          decoration: InputDecoration(
            counterText: "",
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
                bottom:16.h,// AppDimensions.widgetPaddingVer,
                top: 16.h//AppDimensions.widgetPaddingVer
            ),
            hintText: "Select Nearest Office *",
            labelText: "Select Nearest Office *",
            floatingLabelStyle: const TextStyle(
                color: AppColors.headerTextColor, fontWeight: FontWeight.bold),
            suffixIcon: const Icon(
              Icons.arrow_drop_down_outlined,
              color: AppColors.primaryColor,
            ),
            hintStyle:
                const TextStyle(color: AppColors.levelTextColor, fontSize: 14),
            labelStyle:
                const TextStyle(color: AppColors.levelTextColor, fontSize: 12),
          ),
        ),
        onSuggestionSelected: (SingleOffice value) {
          controller.selectedOffice.value = value;
          controller.officeController.text = value.name ?? "";
        },
        itemBuilder: (buildContext, value) {
          return Padding(
            padding: EdgeInsetsDirectional.symmetric(
                horizontal: 24.w//AppDimensions.horizontalPadding
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BodyText(
                  text: value.name ?? "",
                  fontWeight: FontWeight.bold,
                  align: TextAlign.start,
                ),
                BodyText(
                  text: value.address ?? "",
                  size: 10,
                  align: TextAlign.start,
                ),
                const Divider()
              ],
            ),
          );
        },
        suggestionsCallback: (pattern) {
          return getSuggestions(pattern);
        },
      ),
    );
    /*DropdownButtonFormField<SingleOffice>(
      validator: (value) {
        return value == null ? "Select nearest office" : null;
      },
      isExpanded: true,
      iconSize: 25,
      iconEnabledColor: Colors.red,
      iconDisabledColor: Colors.red,
      style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.bodyTextColor),
      decoration: InputDecoration(
        counterText: "",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          borderSide: const BorderSide(color: AppColors.inactiveColor),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          borderSide: const BorderSide(color: AppColors.inactiveColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          borderSide: const BorderSide(color: AppColors.levelTextColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          borderSide: const BorderSide(color: AppColors.primaryColor),
        ),
        contentPadding: EdgeInsets.only(
            left: 24,
            right: 15,
            bottom: AppDimensions.widgetPaddingVer,
            top: AppDimensions.widgetPaddingVer),
        // hintText: hintText,
        labelText: "Select Nearest Office",
        floatingLabelStyle: const TextStyle(
            color: AppColors.headerTextColor, fontWeight: FontWeight.bold),
        //  prefixIcon: preFix,
        //  suffixIcon: suffix,
        hintStyle: const TextStyle(color: AppColors.levelTextColor),
      ),
      items: controller.officeList
          .map<DropdownMenuItem<SingleOffice>>((SingleOffice value) {
        return DropdownMenuItem<SingleOffice>(
          value: value,
          child: BodyText(
            text: value.name.toString(),
            maxLine: 3,
            align: TextAlign.start,
          ),
        );
      }).toList(),
      onChanged: (SingleOffice? value) {
        controller.selectedOffice.value=value??SingleOffice();
      },
    )*/
  }

/*  Widget officeDropdown() {
    return DropdownButtonFormField<SingleOffice>(
      validator: (value) {
        return value == null ? "Select nearest office" : null;
      },
      isExpanded: true,
      iconSize: 25,
      iconEnabledColor: Colors.red,
      iconDisabledColor: Colors.red,
      style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.bodyTextColor),
      decoration: InputDecoration(
        counterText: "",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          borderSide: const BorderSide(color: AppColors.inactiveColor),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          borderSide: const BorderSide(color: AppColors.inactiveColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          borderSide: const BorderSide(color: AppColors.levelTextColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          borderSide: const BorderSide(color: AppColors.primaryColor),
        ),
        contentPadding: EdgeInsets.only(
            left: 24,
            right: 15,
            bottom: AppDimensions.widgetPaddingVer,
            top: AppDimensions.widgetPaddingVer),
        // hintText: hintText,
        labelText: "Select Nearest Office",
        floatingLabelStyle: const TextStyle(
            color: AppColors.headerTextColor, fontWeight: FontWeight.bold),
        //  prefixIcon: preFix,
        //  suffixIcon: suffix,
        hintStyle: const TextStyle(color: AppColors.levelTextColor),
      ),
      items: controller.officeList
          .map<DropdownMenuItem<SingleOffice>>((SingleOffice value) {
        return DropdownMenuItem<SingleOffice>(
          value: value,
          child: BodyText(
            text: value.name.toString(),
            maxLine: 3,
            align: TextAlign.start,
          ),
        );
      }).toList(),
      onChanged: (SingleOffice? value) {
        controller.selectedOffice.value = value ?? SingleOffice();
      },
      value: controller.selectedOffice.value,
    );
  }*/

  Widget registrationForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          IgnorePointer(
            ignoring: controller.disableOffice.value,
            child: officeDropdown(),
          ),
          SizedBox(
            height:16.h// AppDimensions.widgetPaddingVer,
          ),
          CustomTextField(
            isRequired: true,
            hintText: "Namne",
            levelText: "Name",
            validatorText: "Name is required",
            controller: controller.nameController,
           // textInputType: TextInputType.name,
          ),
          SizedBox(
            height: 16.h//AppDimensions.widgetPaddingVer,
          ),
          IgnorePointer(
            ignoring: true,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: AppColors.inactiveColor.withOpacity(.5)
              ),
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
          SizedBox(
            height: 16.h//AppDimensions.widgetPaddingVer,
          ),

          if (!controller.isLoading.value)
            CustomPhoneTextField(
              countryList: controller.countryList,
              selectedCountry: controller.selectedPhoneCountry.value,
              onChange: (value) {
                controller.selectedPhoneCountry.value = value;
                controller.phoneCountryController.text=value.iso31662??"";
              },
              controller: controller.phoneController,
              countryController: controller.phoneCountryController,
              callingCode: controller.selectedPhoneCountry.value.callingCode??"",
              phoneSuggestionController: SuggestionsBoxController(),
            ),
          // phoneTextField(),
          SizedBox(
            height: 16.h//AppDimensions.widgetPaddingVer,
          ),
          CustomCountryDropdown(
            labelText:"Present Country" ,
            countryList: controller.countryList,
            required: true,
            controller: controller.countryController,
            onChange: (value){
              controller.selectedCountry.value=value;
              controller.countryController.text=value.name??"";
            },
            countrySuggestionBoxController: SuggestionsBoxController(),
          ),
          /* CustomTextField(
            isRequired: true,
            hintText: "Present Country",
            levelText: "Present Country",
            validatorText: "Country is required",
            controller: controller.countryController,
          ),*/
          SizedBox(
            height:16.h// AppDimensions.widgetPaddingVer,
          ),
          CustomTextField(
            isRequired: true,
            hintText: "Present City",
            levelText: "Present City",
            validatorText: "City is required",
            controller: controller.cityController,
          ),
          SizedBox(
            height: 16.h//AppDimensions.widgetPaddingVer,
          ),
          CustomTextField(
            isRequired: true,
            hintText: "Occupation",
            levelText: "Occupation",
            validatorText: "Occupation is required",
            controller: controller.occupationController,
          ),
          SizedBox(
            height: 32.h//AppDimensions.sectionPaddingVer,
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
