import 'package:appbdp/app/common/widgets/bottom_bdp_view.dart';
import 'package:appbdp/app/common/widgets/element_widgets.dart';
import 'package:appbdp/app/common/widgets/header_bdp_view.dart';
import 'package:appbdp/app/common/widgets/items_widgets.dart';
import 'package:appbdp/app/common/widgets/query_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/banner_model.dart';
import 'package:appbdp/app/models/community_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/detail_community_controller.dart';

class DetailCommunityView extends GetView<DetailCommunityController> {
  const DetailCommunityView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBdpView(
        primary: true,
        title: "Comunidad BDP",
        customBack: () {
          if (controller.prev.value is CommunityModel) {
            controller.setCommunity(
              controller.prev.value!,
            );
          } else {
            Get.back();
          }
        },
      ),
      body: Obx(
        () {
          List<FileModel> images =
              controller.community.value?.getImages() ?? [];
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Visibility(
                  visible: images.isNotEmpty == true,
                  child: communityBanner(
                    images,
                  ),
                ),
                Visibility(
                  visible: controller.community.value is CommunityModel,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 15,
                    ),
                    child: communityItem(
                      controller.community.value!,
                      enableImage: false,
                      backgroundColor: appColorWhite,
                      voteIconSize: 15,
                      voteTitleSize: 10,
                      showNextArrow: false,
                      showReply: true,
                      showResources:
                          controller.community.value?.getFiles().isNotEmpty,
                      actionReply: () {
                        controller.setCommunityForm(
                          targetValue: controller.community.value,
                          reply: controller.community.value,
                        );
                      },
                      actionResource: () {
                        controller.setDocumentCommunity(
                          controller.community.value!,
                        );
                      },
                      actionVote: (value) {
                        controller.setVote(value);
                      },
                    ),
                  ),
                ),
                queryBdpWidget(
                  !controller.loading.value &&
                      controller.community.value?.children.isNotEmpty == true,
                  Container(
                    color: appBackgroundLight,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    child: Column(
                      children: (controller.community.value?.children ?? [])
                          .asMap()
                          .entries
                          .map(
                        (community) {
                          return communityItem(
                            community.value,
                            enableImage: false,
                            backgroundColor: appColorTransparent,
                            voteIconSize: 15,
                            voteTitleSize: 10,
                            enableEdit: controller.user.value?.id ==
                                community.value.user.id,
                            actionEdit: () {
                              controller.setCommunityForm(
                                value: community.value,
                              );
                            },
                            showNextArrow:
                                community.value.meta.interactions > 0,
                            showResources:
                                community.value.getFiles().isNotEmpty,
                            showReply: true,
                            actionReply: () {
                              controller.setCommunityForm(
                                targetValue: controller.community.value,
                                reply: community.value,
                              );
                            },
                            actionNext: () {
                              controller.setCommunity(
                                community.value,
                                prevValue: controller.community.value,
                                tagsValue: controller.tags,
                              );
                            },
                            actionResource: () {
                              controller.setDocumentCommunity(
                                community.value,
                              );
                            },
                            actionVote: (value) {
                              controller.setVote(
                                value,
                                index: community.key,
                              );
                            },
                          );
                        },
                      ).toList(),
                    ),
                  ),
                  loading: controller.loading.value,
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
