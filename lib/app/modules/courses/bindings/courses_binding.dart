import 'package:appbdp/app/models/providers/course_bdp_provider.dart';
import 'package:appbdp/app/models/providers/course_provider.dart';
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
    Get.put<CoursesController>(
      CoursesController(),
    );
  }
}
