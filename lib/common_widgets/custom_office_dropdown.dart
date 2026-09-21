import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iecc/app/modules/registration/models/office_list_model.dart';
import '../app/modules/registration/models/country_list_model.dart';
import '../constraints/app_colors.dart';
import '../constraints/body_text.dart';

class CustomOfficeDropdown extends StatelessWidget {
  final bool required;
  final bool showBorder;
  final String? labelText;
  final String? hintText;
  final List<SingleOffice> officeList;
  final Function(SingleOffice)? onChange;
  final SingleOffice? selectedOffice;

  const CustomOfficeDropdown({
    this.required = false,
    required this.officeList,
    this.labelText,
    this.hintText,
    this.showBorder = true,
    this.onChange,
    super.key,
    this.selectedOffice
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownSearch<SingleOffice>(
          onChanged: (value) {
            if (onChange != null && value != null) {
              onChange!(value);
            }
          },
          selectedItem: selectedOffice,
          dropdownBuilder: (buildContext, office) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    office?.name ?? "",
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
          compareFn: (item1, item2) => item1.name == item2.name,
          itemAsString: (country) => country.name ?? "",
          items: (filter, infiniteScrollProps) => officeList,
          filterFn: (office, filter) {
            final query = filter.toLowerCase();
            return (office.name?.toLowerCase().contains(query) ?? false) ||
                (office.address?.toLowerCase().contains(query) ?? false);
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


            itemBuilder: (context, SingleOffice office, isSelected, _) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0, vertical: 4.0),
                child: Center(
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
