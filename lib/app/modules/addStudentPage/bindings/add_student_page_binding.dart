import 'package:get/get.dart';

import '../controllers/add_student_page_controller.dart';

class AddStudentPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddStudentPageController>(
      () => AddStudentPageController(),
    );
  }
}
