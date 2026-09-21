
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../app/modules/registration/models/country_list_model.dart';
import '../constraints/app_colors.dart';
import '../constraints/header_text.dart';
import 'custom_text_field.dart';

class CustomPhoneTextField extends StatelessWidget {
  final TextEditingController? controller;
  final List<SingleCountry> countryList;
  final SingleCountry? selectedCountry;
  final String callingCode;
  final Function(SingleCountry)? onChange;

  const CustomPhoneTextField({
    this.controller,
    this.selectedCountry,
    required this.countryList,
    required this.callingCode,
    this.onChange,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      isRequired: true,
      hintText: "0000 000 000",
      levelText: "Contact No",
      validator: (value){
        if((value??"").isEmpty){
          if(selectedCountry?.countryCode==null){
            return "Please select country first";
          }else{
            return "Contact No is required";
          }
        }
      },

      controller: controller,
      textInputType: TextInputType.phone,
      maxLength: 10,
      preFix: SizedBox(
        width: 170.w,
        child: Row(
          children: [
            Expanded(
              child: _buildCountryDropdown(),
            ),
            HeaderText(text: "+$callingCode "),
          ],
        ),
      ),
    );
  }

  Widget _buildCountryDropdown() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
      ),
      child: DropdownSearch<SingleCountry>(
        items:(filter, infiniteScrollProps) =>  countryList,
        selectedItem: selectedCountry,
        onChanged: (value) => onChange?.call(value!),
        filterFn: (country, filter) => _filterCountries(country, filter),
        dropdownBuilder: _dropdownBuilder,
        itemAsString: (country) => country.iso31662 ?? "",
        compareFn: (item1, item2) => item1.iso31662 == item2.iso31662,
        popupProps: PopupProps.menu(
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  vertical: 8.h, horizontal: 12.w),
              // Adjust padding to control height
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(10.r),
              ),
              hintText: "Search...",
              hintStyle: TextStyle(
                  fontSize: 12.sp), // Optional: Adjust font size if needed
            ),
          ),
          itemBuilder: _buildPopupItem,
          listViewProps: const ListViewProps(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
          ),
        ),
        decoratorProps: _buildDecoratorProps(),
      ),
    );
  }



  bool _filterCountries(SingleCountry country, String filter) {
    final query = filter.toLowerCase();
    return (country.name?.toLowerCase().contains(query) ?? false) ||
        (country.iso31662?.toLowerCase().contains(query) ?? false);
  }

  Widget _dropdownBuilder(BuildContext context, SingleCountry? country) {
    if (country?.name == null) {
      return Text(
        "Choose Country*",
        style: TextStyle(
          color: AppColors.levelTextColor, fontSize: 12,
         //color: AppColors.bodyTextColor.withOpacity(0.6),
          fontStyle: FontStyle.italic, // Optional: to make it distinct
        ),
        textAlign: TextAlign.center,
      );
    }

    final flagUrl = country?.flagUrl;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (flagUrl != null && flagUrl.isNotEmpty)
          SvgPicture.network(
            flagUrl,
            height: 20,
            width: 30,
            placeholderBuilder: (context) => Icon(Icons.flag, size: 20),
          //  errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image, size: 20),
          ),
        /*else
          Icon(Icons.image_not_supported, size: 20),*/ // Fallback for missing URLs
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            country?.iso31662 ?? "",
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.bodyTextColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }



  DropDownDecoratorProps _buildDecoratorProps() {
    return DropDownDecoratorProps(
      decoration: InputDecoration(
        suffixIconColor: AppColors.primaryColor,
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      ),
    );
  }

  Widget _buildPopupItem(BuildContext context, SingleCountry country, bool isSelected, _) {
    final flagUrl = country.flagUrl;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            country.name ?? "",
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.bodyTextColor,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (flagUrl != null && flagUrl.isNotEmpty)
                SvgPicture.network(
                  flagUrl,
                  height: 20,
                  width: 30,
                  placeholderBuilder: (context) => Icon(Icons.flag, size: 20),
                 // errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image, size: 20),
                ),
              /*else
                Icon(Icons.image_not_supported, size: 20), */// Fallback for missing URLs
              SizedBox(width: 20.w),
              Expanded(
                child: Text(
                  country.iso31662 ?? "",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.bodyTextColor,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }

}
