import 'package:appbdp/app/models/providers/user_provider.dart';
import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserProvider>(
      () => UserProvider(),
    );
    Get.put<ProfileController>(
      ProfileController(),
    );
  }
}
