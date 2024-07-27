import 'package:flutter/material.dart';
class AppColors{
  static const Color primaryColor=Color(0xFFDE0023);
  static const Color secondaryColor=Color(0xFF006996);
  static const Color secondaryLightColor=Color(0xFF009CDF);


  static const Color headerTextColor=Color(0xFF000000);
  static const Color bodyTextColor=Color(0xFF4F4F4F);
  static const Color levelTextColor=Color(0xFF6F6F6F);
  static const Color iconColor=Color(0xFF818181);
  static const Color inactiveColor=Color(0xFFCCD0D3);
  static const Color circularBorderColor=Color(0xFFDDDDDD);

  static const Color shadowColor=Color(0xffE7E7E7);

  static const Color warningColor=Color(0xFFffc107);
  static const Color dangerColor=Color(0xFFdc3545);
  static const Color successColor=Color(0xFF28a745);
  static const Color infoColor=Color(0xFF17a2b8);

  static  MaterialColor primarySwatchColor=MaterialColor(
      0xffF97B22, <int, Color>{
    50:primaryColor.withAlpha(26),
    100:primaryColor.withAlpha(51),
    200:primaryColor.withAlpha(77),
    300:primaryColor.withAlpha(102),
    400:primaryColor.withAlpha(128),
    500:primaryColor.withAlpha(153),
    600:primaryColor.withAlpha(179),
    700:primaryColor.withAlpha(204),
    800:primaryColor.withAlpha(230),
    900:primaryColor.withAlpha(255),
  }
  );


}