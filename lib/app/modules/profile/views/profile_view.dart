import 'package:appbdp/app/common/conditions.dart';
import 'package:appbdp/app/common/utils.dart';
import 'package:appbdp/app/common/widgets/bottom_bdp_view.dart';
import 'package:appbdp/app/common/widgets/element_widgets.dart';
import 'package:appbdp/app/common/widgets/header_bdp_view.dart';
import 'package:appbdp/app/common/widgets/input_widgets.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderBdpView(
        primary: true,
        title: "Datos Personales",
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 20,
            ),
            child: Column(
              children: [
                Container(
                  width: Get.width,
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 15,
                  ),
                  decoration: boxDecorationRoundedWithShadow(
                    10,
                    backgroundColor: appBackground,
                    shadowColor: appColorTransparent,
                  ),
                  child: Column(
                    children: [
                      textBdp(
                        controller.user.value?.profile?.fullName ?? "",
                        color: appColorPrimary,
                        weight: FontWeight.bold,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      textBdp(
                        controller.user.value?.email ?? "",
                        color: appColorThird,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      profileItem(
                        Icons.map_outlined,
                        title: controller.user.value?.profile?.department?.name,
                        color: appColorPrimary,
                      ),
                      profileItem(
                        Icons.pin_drop_outlined,
                        title: controller.user.value?.profile?.locality?.name,
                        color: appColorPrimary,
                      ),
                      profileItem(
                        Icons.transgender_outlined,
                        title: getGender(
                          controller.user.value?.profile?.gender,
                        ),
                        color: appColorPrimary,
                      ),
                      profileItem(
                        Icons.factory_outlined,
                        title: getEconomicActivity(
                          controller.user.value?.profile?.economicActivities ??
                              [],
                          "PRINCIPAL",
                        ),
                        color: appColorPrimary,
                      ),
                      profileItem(
                        Icons.factory_outlined,
                        title: getEconomicActivity(
                          controller.user.value?.profile?.economicActivities ??
                              [],
                          "SECUNDARIA",
                        ),
                        color: appColorPrimary,
                      ),
                      profileItem(
                        Icons.phone_outlined,
                        title: controller.user.value?.profile?.phone,
                        color: appColorPrimary,
                      ),
                      profileItem(
                        Icons.phone_android_outlined,
                        title: controller.user.value?.profile?.cellPhone,
                        color: appColorPrimary,
                      ),
                      profileItem(
                        Icons.alternate_email_outlined,
                        title: controller.user.value?.profile?.email,
                        color: appColorPrimary,
                      ),
                      profileItem(
                        Icons.badge_outlined,
                        title: controller.user.value?.profile?.documentNumber,
                        color: appColorPrimary,
                      ),
                      profileItem(
                        Icons.cake_outlined,
                        title: dateBdp(
                          controller.user.value?.profile?.birthDate,
                        ),
                        color: appColorPrimary,
                        enableBorder: false,
                        pb: 0,
                        mb: 0,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                buttonBdp(
                  "Cerrar Sesión",
                  () => controller.logout(),
                ),
                const SizedBox(
                  height: 20,
                ),
                buttonBdp(
                  "Eliminar Cuenta",
                  () {},
                  color: appColorPrimary,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomBdpView(),
    );
  }
}
