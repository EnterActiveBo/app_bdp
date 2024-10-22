import 'package:appbdp/app/models/providers/pathology_provider.dart';
import 'package:appbdp/app/modules/pathologies/pathology/controllers/pathology_controller.dart';
import 'package:get/get.dart';

import '../controllers/pathologies_controller.dart';

class PathologiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PathologyController>(
      () => PathologyController(),
    );
    Get.lazyPut<PathologyProvider>(
      () => PathologyProvider(),
    );
    Get.put<PathologiesController>(
      PathologiesController(),
    );
  }
}
