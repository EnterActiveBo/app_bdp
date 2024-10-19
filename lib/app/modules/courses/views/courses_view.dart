import 'package:appbdp/app/common/widgets/bottom_bdp_view.dart';
import 'package:appbdp/app/common/widgets/header_bdp_view.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/courses_controller.dart';

class CoursesView extends GetView<CoursesController> {
  const CoursesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderBdpView(
        primary: true,
        title: "Cursos",
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 15,
              right: 15,
            ),
            child: TabBar(
              controller: controller.tabController.value,
              labelColor: appColorPrimary,
              indicatorColor: appColorThird,
              automaticIndicatorColorAdjustment: false,
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelColor: Colors.grey,
              labelStyle: boldTextStyle(
                size: 14,
              ),
              tabAlignment: TabAlignment.fill,
              isScrollable: false,
              tabs: controller.enableTabs,
            ),
          ),
          TabBarView(
            controller: controller.tabController.value,
            children: controller.tabContents,
          ).expand(),
        ],
      ),
      bottomNavigationBar: const BottomBdpView(),
    );
  }
}
