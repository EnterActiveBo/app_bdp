import 'package:appbdp/app/models/providers/file_provider.dart';
import 'package:appbdp/app/models/providers/support_provider.dart';
import 'package:get/get.dart';

import '../controllers/support_controller.dart';

class SupportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FileProvider>(
      () => FileProvider(),
    );
    Get.lazyPut<SupportProvider>(
      () => SupportProvider(),
    );
    Get.lazyPut<SupportController>(
      () => SupportController(),
    );
  }
}
