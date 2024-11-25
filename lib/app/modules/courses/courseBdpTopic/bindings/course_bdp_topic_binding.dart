import 'package:appbdp/app/models/providers/course_bdp_provider.dart';
import 'package:appbdp/app/modules/courses/courseBdpModule/controllers/course_bdp_module_controller.dart';
import 'package:get/get.dart';

import '../controllers/course_bdp_topic_controller.dart';

class CourseBdpTopicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TopicBdpProvider>(
      () => TopicBdpProvider(),
    );
    Get.lazyPut<CourseBdpModuleController>(
      () => CourseBdpModuleController(),
    );
    Get.lazyPut<CourseBdpTopicController>(
      () => CourseBdpTopicController(),
    );
  }
}
