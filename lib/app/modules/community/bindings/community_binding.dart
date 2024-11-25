import 'package:appbdp/app/models/providers/community_provider.dart';
import 'package:appbdp/app/models/providers/file_provider.dart';
import 'package:appbdp/app/models/providers/user_provider.dart';
import 'package:appbdp/app/modules/community/documentsCommunity/controllers/documents_community_controller.dart';
import 'package:appbdp/app/modules/community/fileCommunity/controllers/file_community_controller.dart';
import 'package:get/get.dart';

import '../controllers/community_controller.dart';

class CommunityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FileCommunityController>(
      () => FileCommunityController(),
    );
    Get.lazyPut<DocumentsCommunityController>(
      () => DocumentsCommunityController(),
    );
    Get.lazyPut<FileProvider>(
      () => FileProvider(),
    );
    Get.lazyPut<UserProvider>(
      () => UserProvider(),
    );
    Get.lazyPut<CommunityProvider>(
      () => CommunityProvider(),
    );
    Get.put<CommunityController>(
      CommunityController(),
    );
  }
}
