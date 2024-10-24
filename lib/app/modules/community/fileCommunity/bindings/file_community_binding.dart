import 'package:get/get.dart';

import '../controllers/file_community_controller.dart';

class FileCommunityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FileCommunityController>(
      () => FileCommunityController(),
    );
  }
}
