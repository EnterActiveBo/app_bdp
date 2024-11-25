import 'package:appbdp/app/models/providers/community_provider.dart';
import 'package:appbdp/app/models/providers/file_provider.dart';
import 'package:get/get.dart';

import '../controllers/form_community_controller.dart';

class FormCommunityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FileProvider>(
      () => FileProvider(),
    );
    Get.lazyPut<CommunityProvider>(
      () => CommunityProvider(),
    );
    Get.lazyPut<FormCommunityController>(
      () => FormCommunityController(),
    );
  }
}
