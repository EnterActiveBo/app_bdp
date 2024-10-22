import 'package:appbdp/app/modules/pathologies/documentPathology/controllers/document_pathology_controller.dart';
import 'package:get/get.dart';

import '../controllers/pathology_controller.dart';

class PathologyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DocumentPathologyController>(
      () => DocumentPathologyController(),
    );
    Get.lazyPut<PathologyController>(
      () => PathologyController(),
    );
  }
}
