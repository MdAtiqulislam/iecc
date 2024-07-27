import 'package:flutter_screenutil/flutter_screenutil.dart';




/*abstract class AppDimensions {
  AppDimensions._();

  static double horizontalPadding=_AppDimensions.horizontalPadding;
  static double verticalPadding=_AppDimensions.verticalPadding;
  static double sectionPaddingVer=_AppDimensions.sectionPaddingVer;
  static double widgetPaddingVer=_AppDimensions.widgetPaddingVer;
  static double contentPaddingVer=_AppDimensions.contentPaddingVer;
  static double sectionPaddingHor=_AppDimensions.sectionPaddingHor;
  static double widgetPaddingHor=_AppDimensions.widgetPaddingHor;
  static double contentPaddingHor=_AppDimensions.contentPaddingHor;

  static double titleTextSize=18.sp;
  static double headerTextSize=16.sp;
  static double bodyTextSize=14.sp;
  static double borderRadius=_AppDimensions.borderRadius;
}*/

/*abstract class _AppDimensions {
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const REGGISTRATION = '/reggistration';
  static const LEAD_LIST = '/lead-list';
  static const OTP_PAGE = '/otp-page';
  static const PENDING_PAGE = '/pending-page';
  static const ADD_STUDENT_PAGE = '/add-student-page';
  static const STUDENT_DETAILS_PAGE = '/student-details-page';
  static const SPLASH_SCREEN = '/splash-screen';
  static const EDIT_PROFILE_PAGE = '/edit-profile-page';
  static const NOTIFICATION_PAGE = '/notification-page';
}*/
abstract class _AppDimensions{

  static double horizontalPadding=24.w;
  static double verticalPadding=24.h;
  static double sectionPaddingVer=32.h;
  static double widgetPaddingVer=16.h;
  static double contentPaddingVer=8.h;
  static double sectionPaddingHor=32.w;
  static double widgetPaddingHor=16.w;
  static double contentPaddingHor=8.w;

  static double titleTextSize=18.sp;
  static double headerTextSize=16.sp;
  static double bodyTextSize=14.sp;
  static double borderRadius=15.r;
}