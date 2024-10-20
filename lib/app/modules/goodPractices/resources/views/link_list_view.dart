import 'package:appbdp/app/common/utils.dart';
import 'package:appbdp/app/common/widgets/element_widgets.dart';
import 'package:appbdp/app/common/widgets/query_widgets.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/resource_model.dart';
import 'package:appbdp/app/modules/goodPractices/resources/controllers/resources_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class LinkListView extends GetView<ResourcesController> {
  const LinkListView({super.key});
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
              isFilter: controller.searchLink.value is String,
              searchAction: (value) {
                controller.setSearchLink(value);
              },
              action: () {
                if (controller.searchLink.value is String) {
                  controller.setSearchLink(null);
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
                    controller.filterResources("link");
                return queryBdpWidget(
                  !controller.loading.value && resources.isNotEmpty,
                  Column(
                    children: resources.asMap().entries.map(
                      (resource) {
                        return containerBdp(
                          mt: resource.key == 0 ? 0 : 15,
                          action: () {
                            if (resource.value.url is String) {
                              openUrl("${resource.value.url}");
                            }
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.laptop_mac_outlined,
                                color: appColorThird,
                                size: 40,
                              ),
                              const SizedBox(
                                width: 15,
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
                                    height: (resource.value.detail is String ||
                                            resource.value.tags.isNotEmpty)
                                        ? 5
                                        : 0,
                                  ),
                                  textBdp(
                                    resource.value.detail,
                                    align: TextAlign.left,
                                  ),
                                  textBdp(
                                    resource.value.getTagsString(),
                                    align: TextAlign.left,
                                  ),
                                ],
                              ).expand(),
                              const Icon(
                                Icons.link_outlined,
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
