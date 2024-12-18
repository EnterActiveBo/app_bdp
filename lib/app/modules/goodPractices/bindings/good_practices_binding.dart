import 'package:appbdp/app/models/providers/category_provider.dart';
import 'package:appbdp/app/models/providers/resource_provider.dart';
import 'package:appbdp/app/modules/goodPractices/resources/controllers/resources_controller.dart';
import 'package:appbdp/app/modules/goodPractices/resources/document/controllers/document_controller.dart';
import 'package:appbdp/app/modules/goodPractices/resources/video/controllers/video_controller.dart';
import 'package:get/get.dart';

import '../controllers/good_practices_controller.dart';

class GoodPracticesBinding extends Bindings {
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
    Get.lazyPut<CategoryProvider>(
      () => CategoryProvider(),
    );
    Get.put<GoodPracticesController>(
      GoodPracticesController(),
    );
  }
}
