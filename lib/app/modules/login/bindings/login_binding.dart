import 'package:appbdp/app/models/providers/auth_provider.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthProvider());
    Get.put<LoginController>(
      LoginController(),
    );
  }
}
