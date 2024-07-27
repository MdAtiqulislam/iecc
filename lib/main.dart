import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iecc/theme/theme.dart';
import 'app/routes/app_pages.dart';
import 'languages.dart';


void main() {

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      //systemNavigationBarColor: AppColors.mainColorRed, // navigation bar color
      statusBarColor: Colors.white, // status bar color
      statusBarIconBrightness: Brightness.dark,   // Only honored in Android M and above
      statusBarBrightness: Brightness.dark,
    ),
  );

  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          locale: const Locale("en","US"),
          fallbackLocale: const Locale("en","US"),
          translations: Languages(),
          debugShowCheckedModeBanner: false,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
           theme: CustomTheme.lightTheme,
          // darkTheme: CustomTheme.darkTheme,
          // themeMode: ThemeMode.light,
        );
      },
    ),
  );
}
