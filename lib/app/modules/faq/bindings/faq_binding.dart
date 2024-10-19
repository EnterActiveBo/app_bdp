import 'package:appbdp/app/models/providers/faq_provider.dart';
import 'package:get/get.dart';

import '../controllers/faq_controller.dart';

class FaqBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FaqProvider>(
      () => FaqProvider(),
    );
    Get.put<FaqController>(
      FaqController(),
    );
  }
}
