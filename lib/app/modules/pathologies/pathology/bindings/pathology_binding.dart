import 'package:get/get.dart';

import '../controllers/pathology_controller.dart';

class PathologyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PathologyController>(
      () => PathologyController(),
    );
  }
}
