import 'package:appbdp/app/models/providers/course_bdp_provider.dart';
import 'package:get/get.dart';

import '../controllers/course_bdp_module_controller.dart';

class CourseBdpModuleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TopicBdpProvider>(
      () => TopicBdpProvider(),
    );
    Get.lazyPut<CourseBdpModuleController>(
      () => CourseBdpModuleController(),
    );
  }
}
