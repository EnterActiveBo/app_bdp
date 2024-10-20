import 'package:appbdp/app/models/providers/resource_provider.dart';
import 'package:appbdp/app/modules/goodPractices/resources/document/controllers/document_controller.dart';
import 'package:appbdp/app/modules/goodPractices/resources/video/controllers/video_controller.dart';
import 'package:get/get.dart';

import '../controllers/resources_controller.dart';

class ResourcesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideoController>(
      () => VideoController(),
    );
    Get.lazyPut<DocumentController>(
      () => DocumentController(),
    );
    Get.lazyPut<ResourceProvider>(
      () => ResourceProvider(),
    );
    Get.lazyPut<ResourcesController>(
      () => ResourcesController(),
    );
  }
}
