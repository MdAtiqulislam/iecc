import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iecc/app/utils/extensions.dart';
import 'package:iecc/common_widgets/app_button.dart';
import 'package:iecc/app/modules/customAppBar/custom_app_bar.dart';
import 'package:iecc/common_widgets/custom_drop_down_field.dart';
import 'package:iecc/common_widgets/custom_loading_screen.dart';
import 'package:iecc/common_widgets/custom_phone_text_field.dart';
import 'package:iecc/common_widgets/custom_text_field.dart';
import 'package:iecc/common_widgets/my_drawer.dart';
import 'package:iecc/constraints/app_colors.dart';
import 'package:iecc/constraints/body_text.dart';
import 'package:iecc/constraints/header_text.dart';
import '../controllers/add_student_page_controller.dart';

class AddStudentPageView extends GetView<AddStudentPageController> {
  AddStudentPageView({super.key});

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: CustomAppBar(
          minimal: false,
          scaffoldKey: scaffoldKey,
        ),
        drawer: MyDrawer(),
        /*bottomNavigationBar: controller.isUpdating.value
            ? null
            : CustomBottomNavBar(
                disable: !controller.isLoading.value,
              ),*/
        body: Obx(
          () => Stack(
            children: [
              if (!controller.isLoading.value)
                Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                      horizontal: 24.w,//AppDimensions.horizontalPadding,
                      vertical: 8.h//AppDimensions.contentPaddingVer
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 24.w,//AppDimensions.horizontalPadding,
                        vertical: 24.h//AppDimensions.verticalPadding
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: AppColors.shadowColor,
                              blurRadius: 10,
                              spreadRadius: 3)
                        ],
                        borderRadius:
                            BorderRadius.circular(15.r)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            HeaderText(
                              text: controller.isUpdateForm.value
                                  ? "Update Student info"
                                  : "Add New Student",
                              color: AppColors.secondaryLightColor,
                              size: 16,
                            ),
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: const Icon(
                                Icons.cancel,
                                color: AppColors.primaryColor,
                                size: 36,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 32.h//AppDimensions.sectionPaddingVer,
                        ),
                        addStudentForm()
                      ],
                    ),
                  ),
                ),
              ),
              if (controller.isUpdating.value) const LoadingScreen()
            ],
          ),
        ),
      ),
    );
  }

  Widget addStudentForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            isRequired: true,
            levelText: "First Name",
            hintText: "First Name",
            validatorText: "Required",
            controller: controller.firstNameController,
          ),
          SizedBox(
            height:8.h// AppDimensions.contentPaddingVer,
          ),
          CustomTextField(
            isRequired: true,
            levelText: "Last Name",
            hintText: "Last Name",
            validatorText: "Required",
            controller: controller.lastNameController,
          ),
          SizedBox(
            height: 8.h//AppDimensions.contentPaddingVer,
          ),




          CustomPhoneTextField(
            callingCode: controller.selectedPhoneCountry.value.callingCode??"",
            countryList: controller.countryList,
            selectedCountry: controller.selectedPhoneCountry.value,
            onChange: (value){
              controller.selectedPhoneCountry.value=value;
              controller.countryCodeController.text=value.iso31662??"";
            },
            controller: controller.phoneController,
            countryController: controller.countryCodeController,
            phoneSuggestionController: SuggestionsBoxController(),
          ),

          //phoneTextField(),
          SizedBox(
            height: 8.h//AppDimensions.contentPaddingVer,
          ),
          CustomTextField(
            isRequired: true,
            levelText: "Email",
            hintText: "Email",
           // textInputType: TextInputType.emailAddress,
            validator: (value) {
              return (value ?? "").isEmpty
                  ? "Email is Required"
                  : (value!.isValidEmail() ? null : "Email is not valid");
            },
            controller: controller.emailController,
            //validatorText: "please try with a different email address",
          ),
          if (!controller.isEmailExist.value)
            const BodyText(
              text: "please try with a different email address",
              color: AppColors.primaryColor,
            ),
          SizedBox(
            height:8.h// AppDimensions.contentPaddingVer,
          ),
          CustomDropDownField(
            labelText: "Select Gender *",
            showBorder: true,
            itemList: controller.genderList,
            onChange: (value) {
              controller.selectedGender.value = value ?? "";
            },
            validator: (value) {
              return value == null ? "Please select gender" : null;
            },
            value: controller.selectedGender.value,
          ),
       /*   SizedBox(
            height: 8.h//AppDimensions.contentPaddingVer,
          ),

          CustomCountryDropdown(
           labelText: "Country (Nationality)",
            hintText: "Nationality",
           // showBorder: false,
              countryList: controller.countryList,
            controller: controller.countryNameController,
            onChange: (value){
                controller.selectedCountry.value=value;
                controller.countryNameController.text=value.name??"";
            },
            countrySuggestionBoxController: SuggestionsBoxController(),
          ),*/

          //countryDropdown(),
          SizedBox(
            height:8.h// AppDimensions.contentPaddingVer,
          ),
          CustomTextField(
            levelText: "Additional Notes",
            hintText: "Additional Notes",
            maxLine: 10,
            minLine: 3,
            controller: controller.notesController,
          ),
          SizedBox(
            height: 16.h//AppDimensions.widgetPaddingVer,
          ),
          CheckboxListTile(
              value: controller.isAccepted.value,
              activeColor: AppColors.primaryColor,
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              title: const BodyText(
                text: "I accept the terms & conditions of IECC Policy",
                size: 10,
                align: TextAlign.start,
              ),
              secondary: InkWell(
                onTap: () {},
                child: const Icon(
                  Icons.info_outlined,
                  color: AppColors.infoColor,
                ),
              ),
              onChanged: (value) {
                controller.isAccepted.value = value!;
              }),
          SizedBox(
            height: 16.h//AppDimensions.widgetPaddingVer,
          ),
          AppButton(
            text: controller.isUpdateForm.value ? "Update" : "Confirm",
            onTap: () {
              if (_formKey.currentState?.validate() ?? false) {
                controller.isUpdateForm.value
                    ? controller.updateUserInfo()
                    : controller.addStudent();
              }
            },
            bgColor: AppColors.primaryColor,
          )
        ],
      ),
    );
  }

/*  Widget countryDropdown() {
    return DropdownButtonFormField<SingleCountry>(
      isExpanded: true,
      iconSize: 25,
      iconEnabledColor: Colors.red,
      iconDisabledColor: Colors.red,
      validator: (value) {
        return value == null ? "Please select country" : null;
      },
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
        labelText: "Select Country (Nationality)",
        floatingLabelStyle: const TextStyle(
            color: AppColors.headerTextColor, fontWeight: FontWeight.bold),
        //  prefixIcon: preFix,
        //  suffixIcon: suffix,
        hintStyle: const TextStyle(color: AppColors.levelTextColor),
      ),
      selectedItemBuilder: (_) {
        return controller.countryList.map<Widget>((SingleCountry item) {
          return Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.network(
                item.flagUrl ?? "",
                height: 20,
              ),
              SizedBox(
                width: AppDimensions.widgetPaddingHor,
              ),
              Expanded(
                child: BodyText(
                  text: item.name ?? "",
                  maxLine: 1,
                  align: TextAlign.start,
                ),
              ),
            ],
          );
        }).toList();
      },
      items: controller.countryList
          .map<DropdownMenuItem<SingleCountry>>((SingleCountry value) {
        return DropdownMenuItem<SingleCountry>(
          value: value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.network(
                    value.flagUrl ?? "",
                    height: 20,
                  ),
                  SizedBox(
                    width: AppDimensions.widgetPaddingHor,
                  ),
                  Expanded(
                    child: Text(
                      value.name ?? "",
                      style: const TextStyle(color: AppColors.bodyTextColor),
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
        //  controller.countryController.text = value?.name ?? "";
      },
      value: controller.selectedCountry.value,
    );
  }*/


/*Widget phoneTextField() {
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
                padding: EdgeInsets.only(left: AppDimensions.horizontalPadding),
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
                                  width: AppDimensions.widgetPaddingHor,
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
                 // controller.countryController.text = value?.name ?? "";
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


}
