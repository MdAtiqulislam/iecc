import 'package:get/get.dart';

import '../controllers/pending_page_controller.dart';

class PendingPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PendingPageController>(
      () => PendingPageController(),
    );
  }
}
