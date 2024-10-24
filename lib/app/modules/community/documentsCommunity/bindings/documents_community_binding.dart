import 'package:appbdp/app/modules/community/fileCommunity/controllers/file_community_controller.dart';
import 'package:get/get.dart';

import '../controllers/documents_community_controller.dart';

class DocumentsCommunityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FileCommunityController>(
      () => FileCommunityController(),
    );
    Get.lazyPut<DocumentsCommunityController>(
      () => DocumentsCommunityController(),
    );
  }
}
