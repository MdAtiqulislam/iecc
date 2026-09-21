import 'package:get/get.dart';

import '../controllers/student_details_page_controller.dart';

class StudentDetailsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentDetailsPageController>(
      () => StudentDetailsPageController(),
    );
  }
}
