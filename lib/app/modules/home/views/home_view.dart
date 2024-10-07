import 'package:appbdp/app/common/widgets/bottom_bdp_view.dart';
import 'package:appbdp/app/common/widgets/element_widgets.dart';
import 'package:appbdp/app/common/widgets/header_bdp_view.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderBdpView(),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleBdp("¡Hola!"),
                    Container(
                      width: Get.width,
                      padding: const EdgeInsets.only(
                        top: 5,
                      ),
                      child: textBdp(
                        controller.user.value?.profile?.fullName ?? "",
                        color: appColorPrimary,
                        align: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
              bannerSliderBdp(
                controller.banners,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomBdpView(),
    );
  }
}
