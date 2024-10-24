import 'package:appbdp/app/modules/community/documentsCommunity/controllers/documents_community_controller.dart';
import 'package:appbdp/app/modules/community/fileCommunity/controllers/file_community_controller.dart';
import 'package:get/get.dart';

import '../controllers/detail_community_controller.dart';

class DetailCommunityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FileCommunityController>(
      () => FileCommunityController(),
    );
    Get.lazyPut<DocumentsCommunityController>(
      () => DocumentsCommunityController(),
    );
    Get.lazyPut<DetailCommunityController>(
      () => DetailCommunityController(),
    );
  }
}
