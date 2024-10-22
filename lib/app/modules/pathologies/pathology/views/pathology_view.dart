import 'package:appbdp/app/common/widgets/bottom_bdp_view.dart';
import 'package:appbdp/app/common/widgets/element_widgets.dart';
import 'package:appbdp/app/common/widgets/header_bdp_view.dart';
import 'package:appbdp/app/common/widgets/items_widgets.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/pathology_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/pathology_controller.dart';

class PathologyView extends GetView<PathologyController> {
  const PathologyView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderBdpView(
        primary: true,
        title: "Enfermedades",
      ),
      body: Obx(
        () {
          List<ResourcePathologyModel> images =
              controller.pathology.value?.getResourcesByType("image") ?? [];
          List<ResourcePathologyModel> files =
              controller.pathology.value?.getResourcesByType("file") ?? [];
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Visibility(
                  visible: images.isNotEmpty == true,
                  child: pathologyBanner(
                    images,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Visibility(
                                visible: controller
                                        .pathology.value?.tags.isNotEmpty ==
                                    true,
                                child: titleBdp(
                                  controller.pathology.value?.getTagsString() ??
                                      "",
                                  color: appColorThird,
                                  size: 14,
                                ),
                              ),
                              titleBdp(
                                controller.pathology.value?.title ?? "",
                              ),
                            ],
                          ).expand(),
                          iconButton(
                            Icons.share_outlined,
                            color: appColorTransparent,
                            iconColor: appColorThird,
                            size: 30,
                            pd: 5,
                            action: () {
                              controller.sharePathology(context);
                            },
                          ),
                        ],
                      ),
                      dividerBdp(),
                      titleBdp(
                        "Problema",
                        size: 15,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      textBdp(
                        controller.pathology.value?.problem,
                        size: 14,
                        align: TextAlign.left,
                      ),
                      dividerBdp(),
                      titleBdp(
                        "Información",
                        size: 15,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      textBdp(
                        controller.pathology.value?.information,
                        size: 14,
                        align: TextAlign.left,
                      ),
                      dividerBdp(),
                      titleBdp(
                        "Manejo",
                        size: 15,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      textBdp(
                        controller.pathology.value?.handling,
                        size: 14,
                        align: TextAlign.left,
                      ),
                      dividerBdp(),
                      Visibility(
                        visible: files.isNotEmpty,
                        child: titleBdp(
                          "Más Información",
                          size: 15,
                        ),
                      ),
                      SizedBox(
                        height: files.isNotEmpty ? 10 : 0,
                      ),
                      Column(
                        children: files.asMap().entries.map(
                          (resource) {
                            return resourceItem(
                              resource.value,
                              mt: resource.key == 0 ? 0 : 15,
                              action: () {
                                controller.setDocument(resource.value);
                              },
                            );
                          },
                        ).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const BottomBdpView(),
    );
  }
}
