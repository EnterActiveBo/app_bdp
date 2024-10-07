import 'package:appbdp/app/common/utils.dart';
import 'package:appbdp/app/common/widgets/loader_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/providers/auth_provider.dart';
import 'package:appbdp/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  GetStorage box = GetStorage('App');
  final AuthProvider authProvider = Get.find();

  @override
  void onReady() {
    super.onReady();
    checkIfSessionExpired();
  }

  login(Map data) {
    Get.closeAllSnackbars();
    Get.dialog(
      barrierDismissible: false,
      loadingDialog(),
    );
    authProvider.login(data).then((response) {
      if (response.isOk) {
        box.write('token', response.body['token']);
        Get.offAllNamed(Routes.HOME);
      } else {
        errorBdp(response);
      }
    });
  }

  checkIfSessionExpired() {
    if (Get.arguments != null && Get.arguments['logout'] == true) {
      Get.snackbar(
        "Sesión Expirada",
        "Su sesión expiro, por favor inicie sesión nuevamente.",
        icon: const Icon(
          Icons.error_outline,
          color: appColorWhite,
          size: 35,
        ),
        colorText: appColorWhite,
        backgroundColor: appColorSecondary,
        duration: const Duration(minutes: 1),
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
        margin: const EdgeInsets.all(10),
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}
