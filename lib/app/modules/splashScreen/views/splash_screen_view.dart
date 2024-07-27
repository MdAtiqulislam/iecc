import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iecc/common_widgets/shimmer_screen.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? const Scaffold(
              body: ShimmerScreen(),
            )
          : Container(),
    );
  }
}
