import 'package:appbdp/app/models/providers/category_provider.dart';
import 'package:get/get.dart';

import '../controllers/good_practices_controller.dart';

class GoodPracticesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryProvider>(
      () => CategoryProvider(),
    );
    Get.put<GoodPracticesController>(
      GoodPracticesController(),
    );
  }
}
