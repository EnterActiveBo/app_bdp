import 'package:appbdp/app/common/widgets/bottom_bdp_view.dart';
import 'package:appbdp/app/common/widgets/element_widgets.dart';
import 'package:appbdp/app/common/widgets/header_bdp_view.dart';
import 'package:appbdp/app/common/widgets/items_widgets.dart';
import 'package:appbdp/app/common/widgets/query_widgets.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/course_bdp_topic_controller.dart';

class CourseBdpTopicView extends GetView<CourseBdpTopicController> {
  const CourseBdpTopicView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderBdpView(
        primary: true,
        title: "Cursos BDP",
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleBdp(
                  "AULA BDP",
                  color: appColorThird,
                  size: 15,
                ),
                const SizedBox(
                  height: 2,
                ),
                titleBdp(
                  "${controller.course.value?.title}",
                  align: TextAlign.left,
                  size: 18,
                ),
                const SizedBox(
                  height: 10,
                ),
                iconTextActionBdp(
                  icon: Icons.computer_outlined,
                  title: controller.topic.value?.title,
                  iconColor: appColorThird,
                ),
                dividerBdp(),
                const SizedBox(
                  height: 10,
                ),
                queryBdpWidget(
                  !controller.loadingModules.value &&
                      controller.modules.isNotEmpty,
                  Column(
                    children: controller.modules.asMap().entries.map((module) {
                      return courseModuleItem(
                        module.value,
                        mt: module.key == 0 ? 0 : 15,
                        action: () {
                          controller.setModule(module.value);
                        },
                      );
                    }).toList(),
                  ),
                  loading: controller.loadingModules.value,
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
