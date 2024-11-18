import 'package:appbdp/app/common/utils.dart';
import 'package:appbdp/app/common/widgets/bottom_bdp_view.dart';
import 'package:appbdp/app/common/widgets/element_widgets.dart';
import 'package:appbdp/app/common/widgets/header_bdp_view.dart';
import 'package:appbdp/app/common/widgets/input_widgets.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/banner_model.dart';
import 'package:appbdp/app/models/course_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/course_detail_controller.dart';

class CourseDetailView extends GetView<CourseDetailController> {
  const CourseDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderBdpView(
        primary: true,
        title: "Eventos BDP",
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
                () {
                  if (controller.course.value is CourseModel &&
                      controller.course.value?.image is FileModel) {
                    return Container(
                      width: Get.width,
                      clipBehavior: Clip.antiAlias,
                      decoration: boxDecorationRoundedWithShadow(
                        20,
                        shadowColor: appColorTransparent,
                      ),
                      margin: const EdgeInsets.only(
                        bottom: 10,
                      ),
                      child: CachedNetworkImage(
                        imageUrl: "${controller.course.value?.image?.url}",
                        width: Get.width,
                        fit: BoxFit.fitHeight,
                      ),
                    );
                  }
                  return const SizedBox();
                }(),
                titleBdp(
                  "EVENTO BDP",
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
                      iconTextActionBdp(
                        icon: Icons.schedule_outlined,
                        title: controller.course.value?.schedule,
                        iconColor: appColorThird,
                        mt: 5,
                      ),
                    ],
                  ),
                ),
                textBdp(
                  controller.course.value?.detail,
                  align: TextAlign.left,
                ),
                SizedBox(
                  height:
                      controller.course.value?.meetingUrl is String ? 10 : 0,
                ),
                Visibility(
                  visible: controller.course.value?.meetingUrl is String,
                  child: buttonBdp(
                    "Más Información",
                    () {
                      openUrl("${controller.course.value?.meetingUrl}");
                    },
                  ),
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
