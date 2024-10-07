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
          bottomNavigationItem(Icons.notification_important_outlined),
          bottomNavigationItem(Icons.home_outlined),
          bottomNavigationItem(Icons.person_outline),
          bottomNavigationItem(Icons.phone_outlined),
          bottomNavigationItem(Icons.menu),
        ],
      ),
    );
  }

  bottomNavigationItem(IconData icon) {
    return BottomNavigationBarItem(
      icon: iconWeightBdp(
        icon,
        size: 30,
        weight: FontWeight.w100,
      ),
      label: '',
      activeIcon: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
          color: appColorSecondary,
          shape: BoxShape.circle,
        ),
        child: iconWeightBdp(
          icon,
          size: 25,
          color: appColorWhite,
          weight: FontWeight.w100,
        ),
      ),
    );
  }
}
