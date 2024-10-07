import 'dart:async';

import 'package:appbdp/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    Timer(
      const Duration(
        milliseconds: 1500,
      ),
      () {
        Get.offAllNamed(
          Routes.LOGIN,
        );
      },
    );
  }
}
