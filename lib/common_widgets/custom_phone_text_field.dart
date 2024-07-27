import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../app/modules/registration/models/country_list_model.dart';
import '../constraints/app_colors.dart';
import '../constraints/body_text.dart';
import '../constraints/header_text.dart';
import 'custom_text_field.dart';

class CustomPhoneTextField extends StatelessWidget {


  final SuggestionsBoxController phoneSuggestionController;
  final TextEditingController? controller;
  final TextEditingController? countryController;
  final List<SingleCountry> countryList;
  final SingleCountry? selectedCountry;
  final String callingCode;
  final Function(SingleCountry)? onChange;
    const CustomPhoneTextField({
    this.controller,
    this.countryController,
    this.selectedCountry,
    required this.countryList,
    required this.callingCode,
      required this.phoneSuggestionController,
    this.onChange,
    super.key});


  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      isRequired: true,
      hintText: "0000 000 000",
      levelText: "Contact No",
      validatorText: "Contact No is required",
      controller: controller,
      textInputType: TextInputType.phone,
      maxLength: 10,
      preFix: SizedBox(
        width: 150.w,
        //height: 100,
        child: Row(
          children: [
            Expanded(
              child: DropDownSearchFormField<SingleCountry>(
                intercepting: true,
                suggestionsBoxController: phoneSuggestionController,
                //initialValue: selectedCountry?.iso31662??"",
                textFieldConfiguration: TextFieldConfiguration(
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.bodyTextColor),
                  controller: countryController,
                  decoration: InputDecoration(
                    counterText: "",
                    enabledBorder: InputBorder.none,
                    border:InputBorder.none,
                    focusedBorder:InputBorder.none,
                    errorBorder:InputBorder.none,
                    contentPadding: EdgeInsets.only(
                        left: 24,
                       // right: 0,
                        bottom:16.h,// AppDimensions.widgetPaddingVer,
                        top: 16.h//AppDimensions.widgetPaddingVer
                    ),
                    suffixIcon: InkWell(
                      onTap: (){
                       if(phoneSuggestionController.isOpened()){
                         phoneSuggestionController.close();
                       }else{
                         phoneSuggestionController.open();
                       }
                      },
                      child: const Icon(
                        Icons.arrow_drop_down_outlined,
                        color: AppColors.primaryColor,
                      ),
                    ),
                   // suffixIconConstraints: BoxConstraints()

                    ),
                ),
                onSuggestionSelected: (SingleCountry value) {
                  if (onChange != null) {
                    onChange!(value);
                     }
                  // controller.selectedOffice.value=value;
                  // controller.officeController.text=value.name??"";
                },
                itemBuilder: (buildContext, value) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
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
                              width:16.w// AppDimensions.widgetPaddingHor,
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
                },
                suggestionsCallback: (pattern) {
                  return getSuggestions(pattern);
                },
              )
              /*DropdownButtonFormField<SingleCountry>(
                isExpanded: true,
                selectedItemBuilder: (_) {
                  return countryList
                      .map<Widget>((SingleCountry item) {
                    return Text(item.iso31662.toString(),
                        style: const TextStyle(color: AppColors.bodyTextColor));
                  }).toList();
                },
                decoration: const InputDecoration(border: InputBorder.none),
                iconDisabledColor: AppColors.primaryColor,
                iconEnabledColor: AppColors.primaryColor,
                padding: EdgeInsets.only(left: AppDimensions.horizontalPadding),
                items: countryList
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
                  if(onChange!=null){
                    onChange!(value??SingleCountry());
                  }
                //  controller.selectedCountry.value = value ?? SingleCountry();
                  // controller.countryController.text = value?.name ?? "";
                },
                value: selectedCountry??countryList[0],
              ),*/
            ),
            HeaderText(
                text: "+$callingCode ")
          ],
        ),
      ),
    );
  }
  List<SingleCountry> getSuggestions(String query) {
    List<SingleCountry> matches = <SingleCountry>[];
    matches.addAll(countryList);
    matches.retainWhere((s) {
      return ((s.name ?? "").toLowerCase()).contains(query.toLowerCase()) ||
          ((s.iso31662 ?? "").toLowerCase()).contains(query.toLowerCase())||
          ((s.iso31663 ?? "").toLowerCase()).contains(query.toLowerCase());
    });

    return matches;
  }
}
