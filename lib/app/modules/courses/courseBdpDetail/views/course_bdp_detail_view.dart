import 'package:appbdp/app/common/utils.dart';
import 'package:appbdp/app/common/widgets/bottom_bdp_view.dart';
import 'package:appbdp/app/common/widgets/element_widgets.dart';
import 'package:appbdp/app/common/widgets/header_bdp_view.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/api.const.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/course_bdp_detail_controller.dart';

class CourseBdpDetailView extends GetView<CourseBdpDetailController> {
  const CourseBdpDetailView({super.key});
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
                containerBdp(
                  mb: 15,
                  child: Column(
                    children: [
                      iconTextActionBdp(
                        icon: Icons.calendar_month_outlined,
                        title: controller.course.value?.getDate(),
                        iconColor: appColorThird,
                        mt: 5,
                      ),
                      Visibility(
                        visible: controller.course.value?.hours is int,
                        child: iconTextActionBdp(
                          icon: Icons.schedule_outlined,
                          title: "${controller.course.value?.hours} horas",
                          iconColor: appColorThird,
                          mt: 5,
                        ),
                      ),
                    ],
                  ),
                ),
                textBdp(
                  controller.course.value?.detail,
                  align: TextAlign.left,
                ),
                dividerBdp(),
                Visibility(
                  visible: controller.topics.isNotEmpty,
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: 5,
                    ),
                    child: Column(
                      children: controller.topics.asMap().entries.map(
                        (topic) {
                          return containerBdp(
                            mt: topic.key == 0 ? 0 : 15,
                            radius: 20,
                            border: const Border(
                              left: BorderSide(
                                color: appColorThird,
                                width: 20,
                              ),
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
                                  height: 5,
                                ),
                                titleBdp(
                                  topic.value.title,
                                  color: appColorPrimary,
                                  align: TextAlign.left,
                                  size: 15,
                                ),
                                SizedBox(
                                  height: topic.value.detail is String ? 10 : 0,
                                ),
                                textBdp(
                                  topic.value.detail,
                                  align: TextAlign.left,
                                ),
                              ],
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomBdpView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openUrl(aulaBdpUrl);
        },
        backgroundColor: appColorSecondary,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: appColorWhite,
        ),
      ),
    );
  }
}
