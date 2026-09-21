
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../app/modules/registration/models/country_list_model.dart';
import '../constraints/app_colors.dart';

class CustomCountryDropdown extends StatelessWidget {
  final bool required;
  final bool showBorder;
  final String? labelText;
  final String? hintText;
  final List<SingleCountry> countryList;
  final Function(SingleCountry)? onChange;
  final SingleCountry? selectedCountry;

  const CustomCountryDropdown({
    this.required = false,
    required this.countryList,
    this.labelText,
    this.hintText,
    this.showBorder = true,
    this.onChange,
    super.key,
    this.selectedCountry
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownSearch<SingleCountry>(
          onChanged: (value) {
            if (onChange != null && value != null) {
              onChange!(value);
            }
          },
          selectedItem: selectedCountry,

          dropdownBuilder: (buildContext, country) {
            final flagUrl = country?.flagUrl;
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (flagUrl != null && flagUrl.isNotEmpty)
                  SvgPicture.network(
                    flagUrl,
                    height: 20,
                    width: 30,
                    placeholderBuilder: (context) =>
                        Icon(Icons.flag, size: 20),
                  ),

                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    country?.name ?? "",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.bodyTextColor,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            );
          },


          compareFn: (item1, item2) => item1.iso31662 == item2.iso31662,
          itemAsString: (country) => country.iso31662 ?? "",
          items: (filter, infiniteScrollProps) => countryList,
          filterFn: (country, filter) {
            final query = filter.toLowerCase();
            return (country.name?.toLowerCase().contains(query) ?? false) ||
                (country.iso31662?.toLowerCase().contains(query) ?? false);
          },
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              errorMaxLines: 5,
              counterText: "",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide:
                const BorderSide(color: AppColors.inactiveColor),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide:
                const BorderSide(color: AppColors.inactiveColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide:
                const BorderSide(color: AppColors.levelTextColor),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide:
                const BorderSide(color: AppColors.primaryColor),
              ),
              contentPadding: EdgeInsets.only(
                left: 24,
                bottom: 16.h,
                top: 16.h,
              ),
              hintText: hintText,
              labelText: required ? "$labelText *" : labelText,
              floatingLabelStyle: const TextStyle(
                color: AppColors.headerTextColor,
                fontWeight: FontWeight.bold,
              ),
              suffixIconColor: AppColors.primaryColor,
              hintStyle: const TextStyle(
                color: AppColors.levelTextColor,
                fontSize: 14,
              ),
              labelStyle: const TextStyle(
                color: AppColors.levelTextColor,
                fontSize: 12,
              ),
            ),
          ),
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

            itemBuilder: (context, SingleCountry country, isSelected, _) {
              final flagUrl = country.flagUrl;
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0, vertical: 4.0),
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 16.w,),
                            if (flagUrl != null && flagUrl.isNotEmpty)
                              SvgPicture.network(
                                flagUrl,
                                height: 20,
                                width: 30,
                                placeholderBuilder: (context) =>
                                    Icon(Icons.flag, size: 20),
                              ),
                            // Fallback icon
                            SizedBox(width: 20.w),
                            Expanded(
                              child: Text(
                                country.name ?? "",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.bodyTextColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                    ],
                  ),
                ),
              );
            },


            listViewProps: ListViewProps(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }
}
