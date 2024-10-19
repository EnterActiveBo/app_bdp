import 'dart:async';
import 'dart:io';

import 'package:appbdp/app/common/check_version.dart';
import 'package:appbdp/app/common/controllers/main_controller.dart';
import 'package:appbdp/app/common/storage_box.dart';
import 'package:appbdp/app/common/utils.dart';
import 'package:appbdp/app/models/banner_model.dart';
import 'package:appbdp/app/models/providers/banner_provider.dart';
import 'package:appbdp/app/models/providers/user_provider.dart';
import 'package:appbdp/app/models/user_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:appbdp/app/common/widgets/loader_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nb_utils/nb_utils.dart';

class HomeController extends GetxController {
  GetStorage box = GetStorage('App');
  final MainController mainController = Get.find();
  final _checker = AppVersionChecker();
  StreamSubscription<List<ConnectivityResult>>? listen;
  final BannerProvider bannerProvider = Get.find();
  String bannerKey = 'banners';
  final RxList<BannerModel> banners = (List<BannerModel>.of([])).obs;
  final UserProvider userProvider = Get.find();
  String userKey = 'user';
  final Rx<UserModel?> user = (null as UserModel?).obs;
  final Rx<String?> showName = (null as String?).obs;

  @override
  void onInit() {
    super.onInit();
    startFCM();
    initData();
  }

  @override
  void onReady() {
    super.onReady();
    checkVersion();
  }

  @override
  void onClose() {
    super.onClose();
    listen?.cancel();
  }

  initData() {
    initUser();
    initBanner();
    checkNetwork();
  }

  startFCM() async {
    mainController.startFCM();
    if (mainController.messaging.value is FirebaseMessaging) {
      String? token = await mainController.messaging.value!.getToken();
      setFcmToken(token);
      mainController.messaging.value!.onTokenRefresh.listen((fcmToken) {
        setFcmToken(fcmToken);
      });
    }
  }

  setFcmToken(
    String? token,
  ) async {
    await userProvider.device({
      "type": Platform.isAndroid ? "android" : "ios",
      "fcm_token": token,
    });
  }

  checkVersion() async {
    _checker.checkUpdate().then((value) {
      if (value.appURL is String) {
        box.write("app_url", value.appURL);
      }
      if (value.canUpdate) {
        Get.dialog(
          barrierDismissible: false,
          dialogBdp(
            icon: Icons.system_security_update_warning_outlined,
            title: "Existe una nueva versión disponible",
            detail:
                "Por favor actualiza la aplicación para tener una mejor experiencia.",
            btnText: "Actualizar",
            action: () {
              if (value.appURL is String) {
                openUrl("${value.appURL}");
              }
              Get.back();
            },
          ),
        );
      }
    });
  }

  checkNetwork() async {
    bool isAvailable = await isNetworkAvailable();
    if (!isAvailable) {
      Get.dialog(
        dialogBdp(
          icon: Icons.wifi_off_outlined,
          title: '¡No se cuenta con conexión a internet!',
          detail: 'Por favor, verifica tu conexión a internet.',
        ),
      );
    }
    if (Platform.isAndroid) {
      listen = Connectivity().onConnectivityChanged.listen(
        (List<ConnectivityResult>? result) {
          if (result?.contains(ConnectivityResult.none) == true) {
            Get.dialog(
              dialogBdp(
                icon: Icons.wifi_off_outlined,
                title: '¡No se cuenta con conexión a internet!',
                detail: 'Por favor, verifica tu conexión a internet.',
              ),
            );
          }
        },
      );
    }
  }

  initBanner() {
    banners.value = bannersStored(box);
    getBanners();
  }

  getBanners() async {
    List<BannerModel>? bannerResponse = await bannerProvider.getBanners();
    if (bannerResponse is List<BannerModel>) {
      banners.value = bannerResponse;
      box.write(bannerKey, bannerResponse);
    }
  }

  initUser() {
    user.value = userStored(box);
    getUser();
    if (user.value is UserModel && user.value?.role.name == 'manager') {
      showName.value =
          "${user.value?.name} ${user.value?.firstLastName} ${user.value?.secondLastName}";
    } else {
      showName.value = user.value?.profile?.fullName;
    }
  }

  getUser() async {
    UserModel? userResponse = await userProvider.getProfile();
    if (userResponse is UserModel) {
      user.value = userResponse;
      box.write(userKey, userResponse);
    }
  }
}
