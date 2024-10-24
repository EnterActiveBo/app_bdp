import 'package:get/get.dart';

import '../controllers/prices_controller.dart';

class PricesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PricesController>(
      () => PricesController(),
    );
  }
}
