import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iecc/constraints/app_colors.dart';
import 'package:iecc/constraints/app_strings.dart';
import 'package:iecc/constraints/body_text.dart';
import 'package:iecc/constraints/header_text.dart';

class SingleStudentCart extends StatelessWidget {
  final String? name;
  final String? referral;
  final String? email;
  final String? notes;
  final String? latestStartDate;
  final int? applied;
  final int? offers;
  final int? joined;
  final bool editable;
  final VoidCallback? onTap;
  final VoidCallback? onEditTap;
  final bool isQform;
  final bool isCRM;

  const SingleStudentCart(
      {required this.editable,
      this.name,
      this.email,
      this.referral,
      this.onTap,
      this.onEditTap,
      this.applied,
      this.joined,
      this.offers,
      this.latestStartDate,
      this.notes,
       required this.isCRM,
        this.isQform=false,

      super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [


        Container(
          clipBehavior: Clip.hardEdge,
          margin: EdgeInsets.only(bottom: 8.h//AppDimensions.contentPaddingVer
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.levelTextColor, width: .1),
              borderRadius:
                  BorderRadius.all(Radius.circular(15.r)),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.shadowColor,
                  blurRadius: 2,
                )
              ]),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 24.w,//AppDimensions.horizontalPadding,
                    vertical: 24.h//AppDimensions.contentPaddingVer
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeaderText(
                          text: name ?? "",
                          size: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.bodyTextColor,
                        ),
                        Row(
                          children: [
                            const BodyText(
                                text: "Ref: ",
                                size: 12,
                                color: AppColors.bodyTextColor),
                            BodyText(text: referral ?? "")
                          ],
                        ),
                        Row(
                          children: [
                          /*  if (latestStartDate != null)
                              BodyText(
                                  text: formatDate(latestStartDate.toString())),
                            if (latestStartDate != null)
                              SizedBox(
                                width:8.w// AppDimensions.contentPaddingHor,
                              ),*/
                            const BodyText(
                                text: "App:  ",
                                size: 12,
                                color: AppColors.bodyTextColor),
                            BodyText(text: "${applied ?? " "}"),
                            SizedBox(
                              width: 8.w//AppDimensions.contentPaddingHor,
                            ),
                             BodyText(
                                text: "Offers: ",
                                size: 12,
                                color:offers.toString()=="0"? AppColors.bodyTextColor:AppColors.successColor),
                            BodyText(text: "${offers ?? ""}",color:offers.toString()=="0"? AppColors.bodyTextColor:AppColors.successColor,),
                            SizedBox(
                              width:8.w// AppDimensions.contentPaddingHor,
                            ),
                             BodyText(
                                text: "Joined: ",
                                size: 12,
                                color: (joined ?? "0") == 0 ?AppColors.bodyTextColor:AppColors.successColor ),
                            BodyText(text: (joined ?? "0") == 0 ? "No" : "Yes",color:(joined ?? "0") == 0 ?AppColors.bodyTextColor:AppColors.successColor ,),
                          ],
                        ),
                        const Divider(),
                        BodyText(
                          text: "Additional Notes: ${notes ?? ""}",
                          align: TextAlign.start,
                          maxLine: 1,
                        )
                      ],
                    ),
                    if (editable)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: InkWell(
                          onTap: onEditTap,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(AppImagePath.editIcon),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),

       if(isCRM) Positioned(
           top: 5.h,
           left: 5.w,
           child:Image.asset(AppImagePath.crmWebPortalIcon,height: 15,width: 15,) ),

        //child: const FaIcon(FontAwesomeIcons.earthAsia,color: AppColors.iconColor,size: 15,)),
       if(isQform) Positioned(
           top: 5.h,
           left: 5.w,
           child: const Icon(Icons.bolt_sharp,color: AppColors.iconColor,size: 15,)),

      ],
    );
  }
}
