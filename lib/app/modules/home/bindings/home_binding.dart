import 'package:appbdp/app/models/providers/banner_provider.dart';
import 'package:appbdp/app/models/providers/user_provider.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BannerProvider>(
      () => BannerProvider(),
    );
    Get.lazyPut<UserProvider>(
      () => UserProvider(),
    );
    Get.put<HomeController>(
      HomeController(),
    );
  }
}
