import 'package:appbdp/app/models/providers/gatip_provider.dart';
import 'package:appbdp/app/models/providers/user_provider.dart';
import 'package:get/get.dart';

import '../controllers/weather_controller.dart';

class WeatherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserProvider>(
      () => UserProvider(),
    );
    Get.lazyPut<GatipProvider>(
      () => GatipProvider(),
    );
    Get.put<WeatherController>(
      WeatherController(),
    );
  }
}
