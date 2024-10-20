import 'package:appbdp/app/common/widgets/element_widgets.dart';
import 'package:appbdp/app/common/widgets/query_widgets.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/banner_model.dart';
import 'package:appbdp/app/models/resource_model.dart';
import 'package:appbdp/app/modules/goodPractices/resources/controllers/resources_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class FileListView extends GetView<ResourcesController> {
  const FileListView({super.key});
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
              isFilter: controller.searchFile.value is String,
              searchAction: (value) {
                controller.setSearchFile(value);
              },
              action: () {
                if (controller.searchFile.value is String) {
                  controller.setSearchFile(null);
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
                    controller.filterResources("file");
                return queryBdpWidget(
                  !controller.loading.value && resources.isNotEmpty,
                  Column(
                    children: resources.asMap().entries.map(
                      (resource) {
                        return containerBdp(
                          mt: resource.key == 0 ? 0 : 15,
                          action: () {
                            controller.setDocument(resource.value);
                          },
                          child: Row(
                            children: [
                              Visibility(
                                visible: resource.value.preview is FileModel,
                                child: CachedNetworkImage(
                                  imageUrl: "${resource.value.preview?.url}",
                                  fit: BoxFit.cover,
                                  width: 60,
                                  height: 70,
                                ),
                              ),
                              SizedBox(
                                width: resource.value.preview is FileModel
                                    ? 15
                                    : 0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  titleBdp(
                                    resource.value.getCategory(),
                                    color: appColorThird,
                                    size: 14,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  titleBdp(
                                    resource.value.title,
                                    align: TextAlign.left,
                                  ),
                                  SizedBox(
                                    height: (resource.value.tags.isNotEmpty)
                                        ? 5
                                        : 0,
                                  ),
                                  textBdp(
                                    resource.value.getTagsString(),
                                    align: TextAlign.left,
                                  ),
                                ],
                              ).expand(),
                              const Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: appColorThird,
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
