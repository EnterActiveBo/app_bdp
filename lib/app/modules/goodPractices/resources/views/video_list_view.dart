import 'package:appbdp/app/common/widgets/element_widgets.dart';
import 'package:appbdp/app/common/widgets/query_widgets.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/resource_model.dart';
import 'package:appbdp/app/modules/goodPractices/resources/controllers/resources_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class VideoListView extends GetView<ResourcesController> {
  const VideoListView({super.key});
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final search = TextEditingController();
    final FocusNode searchFocusNode = FocusNode();
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 15,
        ),
        child: Column(
          children: [
            searchFilter(
              formKey,
              search: search,
              searchFocusNode: searchFocusNode,
              isFilter: controller.searchVideo.value is String,
              searchAction: (value) {
                controller.setSearchVideo(value);
              },
              action: () {
                if (controller.searchVideo.value is String) {
                  controller.setSearchVideo(null);
                  search.text = "";
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              child: () {
                List<ResourceModel> resources =
                    controller.filterResources("video");
                return queryBdpWidget(
                  !controller.loading.value && resources.isNotEmpty,
                  Column(
                    children: resources.asMap().entries.map(
                      (resource) {
                        return containerBdp(
                          mt: resource.key == 0 ? 0 : 15,
                          backgroundColor: appColorTransparent,
                          ph: 0,
                          pv: 0,
                          action: () {
                            controller.setVideo(resource.value);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              containerBdp(
                                mb: 15,
                                ph: 0,
                                pv: 0,
                                backgroundColor: appColorTransparent,
                                child: () {
                                  String? imageUrl = controller.getVideoThumb(
                                    resource.value,
                                  );
                                  if (imageUrl is String) {
                                    return Stack(
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: imageUrl,
                                          width: Get.width,
                                          height: Get.width / 2,
                                          fit: BoxFit.cover,
                                        ),
                                        const Positioned.fill(
                                          child: Icon(
                                            Icons.play_circle_outline,
                                            color: appColorSecondary,
                                            size: 70,
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                  return null;
                                }(),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              titleBdp(
                                resource.value.title,
                                align: TextAlign.left,
                              ),
                              SizedBox(
                                height:
                                    (resource.value.tags.isNotEmpty) ? 5 : 0,
                              ),
                              Row(
                                children: [
                                  textBdp(
                                    resource.value.getCategory(),
                                    color: appColorThird,
                                    size: 14,
                                    weight: FontWeight.bold,
                                  ),
                                  textBdp(
                                    " | ",
                                    size: 14,
                                  ),
                                  textBdp(
                                    resource.value.getTagsString(),
                                    align: TextAlign.left,
                                    size: 14,
                                  ).expand(),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ).toList(),
                  ),
                  loading: controller.loading.value,
                );
              }(),
            ).expand(),
          ],
        ),
      ),
    );
  }
}
