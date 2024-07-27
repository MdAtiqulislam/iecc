import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iecc/app/modules/registration/models/country_list_model.dart';
import '../constraints/app_colors.dart';

class CustomCountryDropdown extends StatelessWidget {
  final bool required;
  final bool showBorder;
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final List<SingleCountry> countryList;
  final Function(SingleCountry)? onChange;
  final  SuggestionsBoxController countrySuggestionBoxController ;

 const  CustomCountryDropdown(
      {this.required = false,
      this.controller,
      required this.countryList,
        required this.countrySuggestionBoxController,
      this.labelText,
      this.hintText,
      this.showBorder = true,
      this.onChange,
      super.key});


  @override
  Widget build(BuildContext context) {
    return DropDownSearchFormField<SingleCountry>(
      suggestionsBoxController: countrySuggestionBoxController,



      validator: required
          ? (value) {
              if ((value ?? "").isEmpty) {
                return "Country is required";
              }
              return null;
            }
          : null,
      textFieldConfiguration: TextFieldConfiguration(
        style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.bodyTextColor),
        controller: controller,
        decoration: InputDecoration(
          counterText: "",
          enabledBorder: showBorder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.r),
                  borderSide: const BorderSide(color: AppColors.inactiveColor),
                )
              : InputBorder.none,
          border: showBorder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.r),
                  borderSide: const BorderSide(color: AppColors.inactiveColor),
                )
              : InputBorder.none,
          focusedBorder: showBorder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.r),
                  borderSide: const BorderSide(color: AppColors.levelTextColor),
                )
              : InputBorder.none,
          errorBorder: showBorder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.r),
                  borderSide: const BorderSide(color: AppColors.primaryColor),
                )
              : InputBorder.none,
          contentPadding: EdgeInsets.only(
              left: 24,
              bottom: 16.h, //AppDimensions.widgetPaddingVer,
              top: 16.h //AppDimensions.widgetPaddingVer
              ),
          hintText: hintText,
          labelText: required ? "$labelText *" : labelText,
          floatingLabelStyle: const TextStyle(
              color: AppColors.headerTextColor, fontWeight: FontWeight.bold),
          suffixIcon: InkWell(
            onTap: (){
             if (countrySuggestionBoxController.isOpened()){
               countrySuggestionBoxController.close();
             }else{
               countrySuggestionBoxController.open();
             }
            },
            child: const Icon(
              Icons.arrow_drop_down_outlined,
              color: AppColors.primaryColor,
            ),
          ),
          hintStyle:
              const TextStyle(color: AppColors.levelTextColor, fontSize: 14),
          labelStyle:
              const TextStyle(color: AppColors.levelTextColor, fontSize: 12),
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
          padding: EdgeInsetsDirectional.symmetric(
              horizontal: 24.w //AppDimensions.horizontalPadding
              ),
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
                  SizedBox(width: 24.w //AppDimensions.widgetPaddingHor,
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
      },
      suggestionsCallback: (pattern) {
        return getSuggestions(pattern);
      },
    );
  }

  List<SingleCountry> getSuggestions(String query) {
    List<SingleCountry> matches = <SingleCountry>[];
    matches.addAll(countryList);
    matches.retainWhere((s) {
      return ((s.name ?? "").toLowerCase()).contains(query.toLowerCase()) ||
          ((s.iso31662 ?? "").toLowerCase()).contains(query.toLowerCase()) ||
          ((s.iso31663 ?? "").toLowerCase()).contains(query.toLowerCase());
    });

    return matches;
  }
}
