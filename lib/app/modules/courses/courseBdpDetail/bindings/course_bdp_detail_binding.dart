import 'package:appbdp/app/models/providers/course_bdp_provider.dart';
import 'package:get/get.dart';

import '../controllers/course_bdp_detail_controller.dart';

class CourseBdpDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CourseBdpProvider>(
      () => CourseBdpProvider(),
    );
    Get.lazyPut<CourseBdpDetailController>(
      () => CourseBdpDetailController(),
    );
  }
}
