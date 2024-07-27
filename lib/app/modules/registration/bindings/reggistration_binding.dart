import 'package:get/get.dart';

import '../controllers/registration_controller.dart';

class ReggistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegistrationController>(
      () => RegistrationController(),
    );
  }
}
