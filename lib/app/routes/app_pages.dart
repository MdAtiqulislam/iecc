import 'package:get/get.dart';

import 'package:iecc/app/modules/addStudentPage/bindings/add_student_page_binding.dart';
import 'package:iecc/app/modules/addStudentPage/views/add_student_page_view.dart';
import 'package:iecc/app/modules/editProfilePage/bindings/edit_profile_page_binding.dart';
import 'package:iecc/app/modules/editProfilePage/views/edit_profile_page_view.dart';
import 'package:iecc/app/modules/home/bindings/home_binding.dart';
import 'package:iecc/app/modules/home/views/home_view.dart';
import 'package:iecc/app/modules/login/bindings/login_binding.dart';
import 'package:iecc/app/modules/login/views/login_view.dart';
import 'package:iecc/app/modules/notificationPage/bindings/notification_page_binding.dart';
import 'package:iecc/app/modules/notificationPage/views/notification_page_view.dart';
import 'package:iecc/app/modules/otpPage/bindings/otp_page_binding.dart';
import 'package:iecc/app/modules/otpPage/views/otp_page_view.dart';
import 'package:iecc/app/modules/pendingPage/bindings/pending_page_binding.dart';
import 'package:iecc/app/modules/pendingPage/views/pending_page_view.dart';
import 'package:iecc/app/modules/registration/bindings/reggistration_binding.dart';
import 'package:iecc/app/modules/registration/views/registration_view.dart';
import 'package:iecc/app/modules/splashScreen/bindings/splash_screen_binding.dart';
import 'package:iecc/app/modules/splashScreen/views/splash_screen_view.dart';
import 'package:iecc/app/modules/studentDetailsPage/bindings/student_details_page_binding.dart';
import 'package:iecc/app/modules/studentDetailsPage/views/student_details_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;
 // static const INITIAL = Routes.PENDING_PAGE;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGGISTRATION,
      page: () => RegistrationView(),
      binding: ReggistrationBinding(),
    ),
    GetPage(
      name: _Paths.OTP_PAGE,
      page: () => OtpPageView(),
      binding: OtpPageBinding(),
    ),
    GetPage(
      name: _Paths.PENDING_PAGE,
      page: () => const PendingPageView(),
      binding: PendingPageBinding(),
    ),
    GetPage(
      name: _Paths.ADD_STUDENT_PAGE,
      page: () => AddStudentPageView(),
      binding: AddStudentPageBinding(),
    ),
    GetPage(
      name: _Paths.STUDENT_DETAILS_PAGE,
      page: () => StudentDetailsPageView(),
      binding: StudentDetailsPageBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE_PAGE,
      page: () => EditProfilePageView(),
      binding: EditProfilePageBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION_PAGE,
      page: () => NotificationPageView(),
      binding: NotificationPageBinding(),
    ),
  ];
}
