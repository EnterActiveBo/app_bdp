import 'package:appbdp/app/common/controllers/main_controller.dart';
import 'package:appbdp/app/common/widgets/element_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBdpView extends GetView<MainController> {
  const BottomBdpView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        backgroundColor: appColorWhite,
        unselectedItemColor: appColorPrimary,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontSize: 0),
        unselectedLabelStyle: const TextStyle(fontSize: 0),
        currentIndex: controller.current.value,
        onTap: (index) {
          controller.goTo(index);
        },
        items: [
          bottomNavigationItem(
            Icons.notification_important_outlined,
            svg: "assets/images/icons/practicas_bottom.svg",
          ),
          bottomNavigationItem(
            Icons.home_outlined,
            svg: "assets/images/icons/comunidad_bottom.svg",
          ),
          bottomNavigationItem(
            Icons.home_outlined,
            svg: "assets/images/icons/home.svg",
          ),
          bottomNavigationItem(
            Icons.phone_outlined,
            svg: "assets/images/icons/cursos_bottom.svg",
          ),
          bottomNavigationItem(
            Icons.person_outline,
            svg: "assets/images/icons/user.svg",
          ),
        ],
      ),
    );
  }

  bottomNavigationItem(
    IconData icon, {
    String? svg,
  }) {
    return BottomNavigationBarItem(
      icon: iconWeightBdp(
        icon,
        svg: svg,
        size: 30,
        weight: FontWeight.w100,
      ),
      label: '',
      activeIcon: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
          color: appColorThird,
          shape: BoxShape.circle,
        ),
        child: iconWeightBdp(
          icon,
          svg: svg,
          size: 25,
          color: appColorWhite,
          weight: FontWeight.w100,
        ),
      ),
    );
  }
}
