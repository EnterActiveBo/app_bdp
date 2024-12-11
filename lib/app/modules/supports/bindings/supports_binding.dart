import 'package:appbdp/app/models/providers/file_provider.dart';
import 'package:appbdp/app/models/providers/support_provider.dart';
import 'package:appbdp/app/modules/supports/support/controllers/support_controller.dart';
import 'package:get/get.dart';

import '../controllers/supports_controller.dart';

class SupportsBinding extends Bindings {
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
    Get.put<SupportsController>(
      SupportsController(),
    );
  }
}
