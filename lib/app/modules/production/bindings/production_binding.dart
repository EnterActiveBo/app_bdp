import 'package:appbdp/app/models/providers/gatip_provider.dart';
import 'package:get/get.dart';

import '../controllers/production_controller.dart';

class ProductionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GatipProvider>(
      () => GatipProvider(),
    );
    Get.put<ProductionController>(
      ProductionController(),
    );
  }
}
