import 'package:get/get.dart';

import '../controllers/document_pathology_controller.dart';

class DocumentPathologyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DocumentPathologyController>(
      () => DocumentPathologyController(),
    );
  }
}
