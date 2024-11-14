import 'package:appbdp/app/common/widgets/bottom_bdp_view.dart';
import 'package:appbdp/app/common/widgets/element_widgets.dart';
import 'package:appbdp/app/common/widgets/header_bdp_view.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/menu_model.dart';
import 'package:appbdp/app/routes/app_pages.dart';
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
                  vertical: 10,
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
                        controller.user.value?.getName() ?? "",
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
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                child: Column(
                  children: [
                    titleBdp(
                      "Herramientas",
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: () {
                  List<MenuModel> items = controller.menu.where(
                    (m) {
                      return (m.disabled ?? false) == false;
                    },
                  ).toList();
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 15,
                    ),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const ScrollPhysics(),
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      MenuModel item = items[index];
                      return menuHome(item);
                    },
                  );
                }(),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomBdpView(),
      floatingActionButton: () {
        if (controller.user.value?.role.name == 'client') {
          return FloatingActionButton(
            onPressed: () {
              Get.toNamed(Routes.PRODUCTION);
            },
            backgroundColor: appColorSecondary,
            shape: const CircleBorder(),
            child: const Icon(
              Icons.bar_chart_outlined,
              color: appColorWhite,
            ),
          );
        }
        return null;
      }(),
    );
  }
}
