import 'package:appbdp/app/common/widgets/bottom_bdp_view.dart';
import 'package:appbdp/app/common/widgets/element_widgets.dart';
import 'package:appbdp/app/common/widgets/header_bdp_view.dart';
import 'package:appbdp/app/common/widgets/items_widgets.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/models/banner_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/documents_community_controller.dart';

class DocumentsCommunityView extends GetView<DocumentsCommunityController> {
  const DocumentsCommunityView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderBdpView(
        primary: true,
        title: "Comunidad",
      ),
      body: Obx(
        () {
          List<FileModel> images =
              controller.community.value?.getImages() ?? [];
          return SingleChildScrollView(
            child: SizedBox(
              width: Get.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: Get.width,
                    margin: const EdgeInsets.only(
                      bottom: 15,
                    ),
                    child: titleBdp(
                      controller.community.value!.title,
                      // align: TextAlign.left,
                    ),
                  ),
                  Visibility(
                    visible: images.isNotEmpty == true,
                    child: communityBanner(
                      images,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: (controller.community.value?.getFiles() ?? [])
                          .asMap()
                          .entries
                          .map(
                        (resource) {
                          return fileItem(
                            resource.value,
                            mt: resource.key == 0 ? 0 : 15,
                            action: () {
                              controller.setDocument(resource.value);
                            },
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const BottomBdpView(),
    );
  }
}
