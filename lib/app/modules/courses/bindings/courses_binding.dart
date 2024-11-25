import 'package:appbdp/app/models/providers/course_bdp_provider.dart';
import 'package:appbdp/app/models/providers/course_provider.dart';
import 'package:appbdp/app/modules/courses/courseBdpDetail/controllers/course_bdp_detail_controller.dart';
import 'package:appbdp/app/modules/courses/courseBdpModule/controllers/course_bdp_module_controller.dart';
import 'package:appbdp/app/modules/courses/courseBdpTopic/controllers/course_bdp_topic_controller.dart';
import 'package:appbdp/app/modules/courses/courseDetail/controllers/course_detail_controller.dart';
import 'package:get/get.dart';

import '../controllers/courses_controller.dart';

class CoursesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CourseProvider>(
      () => CourseProvider(),
    );
    Get.lazyPut<CourseBdpProvider>(
      () => CourseBdpProvider(),
    );
    Get.lazyPut<TopicBdpProvider>(
      () => TopicBdpProvider(),
    );
    Get.lazyPut<CourseBdpModuleController>(
      () => CourseBdpModuleController(),
    );
    Get.lazyPut<CourseBdpTopicController>(
      () => CourseBdpTopicController(),
    );
    Get.lazyPut<CourseDetailController>(
      () => CourseDetailController(),
    );
    Get.lazyPut<CourseBdpDetailController>(
      () => CourseBdpDetailController(),
    );
    Get.put<CoursesController>(
      CoursesController(),
    );
  }
}
