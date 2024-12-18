import 'package:appbdp/app/models/providers/gatip_provider.dart';
import 'package:get/get.dart';

import '../controllers/prices_controller.dart';

class PricesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GatipProvider>(
      () => GatipProvider(),
    );
    Get.put<PricesController>(
      PricesController(),
    );
  }
}
