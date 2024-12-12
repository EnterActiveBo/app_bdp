import 'package:appbdp/app/common/widgets/bottom_bdp_view.dart';
import 'package:appbdp/app/common/widgets/element_widgets.dart';
import 'package:appbdp/app/common/widgets/header_bdp_view.dart';
import 'package:appbdp/app/common/widgets/items_widgets.dart';
import 'package:appbdp/app/common/widgets/query_widgets.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/community_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/community_controller.dart';

class CommunityView extends GetView<CommunityController> {
  const CommunityView({super.key});
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final search = TextEditingController();
    final FocusNode searchFocusNode = FocusNode();
    final ScrollController scrollController = ScrollController();
    return Scaffold(
      appBar: const HeaderBdpView(
        primary: true,
        title: "Comunidad",
      ),
      body: Obx(
        () => Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  searchFilter(
                    formKey,
                    search: search,
                    searchFocusNode: searchFocusNode,
                    isFilter: controller.activeSearch.value,
                    searchAction: (value) {
                      controller.setSearch(value);
                    },
                    action: () {
                      if (controller.activeSearch.value) {
                        controller.setSearch(null);
                        search.text = "";
                        FocusManager.instance.primaryFocus?.unfocus();
                      } else {
                        if (controller.search.value is String) {
                          controller.findCommunity();
                          FocusManager.instance.primaryFocus?.unfocus();
                        }
                      }
                    },
                  ),
                  Row(
                    children: [
                      titleBdp(
                        "Filtrar",
                        align: TextAlign.left,
                      ).expand(),
                      GestureDetector(
                        onTap: () {
                          controller.cleanTagsSelected();
                        },
                        child: titleBdp(
                          "Limpiar",
                          size: 13,
                          color: appColorThird,
                          align: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: controller.tags.asMap().entries.map(
                        (tag) {
                          bool isSelected = controller.tagsSelected.contains(
                            tag.value.id,
                          );
                          return tagContainer(
                            ml: tag.key == 0 ? 0 : 5,
                            pv: 5,
                            ph: 15,
                            radius: 5,
                            backgroundColor: isSelected
                                ? appColorThirdOpacity
                                : appBackgroundOpacity,
                            child: titleBdp(
                              tag.value.title,
                              size: 12,
                              color:
                                  isSelected ? appColorThird : appColorPrimary,
                            ),
                            action: () {
                              controller.setTagSelected(tag.value.id);
                            },
                          );
                        },
                      ).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  () {
                    List<CommunityModel> items = controller.communities;
                    return queryBdpWidget(
                      !controller.loading.value && items.isNotEmpty,
                      LazyLoadScrollView(
                        isLoading: true,
                        child: ListView.separated(
                          controller: scrollController,
                          itemBuilder: (context, index) {
                            CommunityModel item = items[index];
                            return communityItem(
                              item,
                              maxTitle: 2,
                              titleOverflow: TextOverflow.ellipsis,
                              maxDetail: 2,
                              detailOverflow: TextOverflow.ellipsis,
                              actionVote: (value) {
                                controller.setVote(value, index);
                              },
                              enableEdit:
                                  controller.user.value?.id == item.user.id,
                              actionEdit: () {
                                controller.setCommunityForm(
                                  value: item,
                                );
                              },
                              actionNext: () {
                                controller.setCommunity(item);
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 15,
                            );
                          },
                          itemCount: items.length,
                        ),
                        onEndOfPage: () {
                          controller.getNextPage();
                        },
                      ),
                      loading: controller.loading.value,
                    ).expand();
                  }(),
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: buttonCustom(
                backgroundColor: appColorThird,
                pv: 5,
                ph: 15,
                radius: 30,
                child: Row(
                  children: [
                    const Icon(
                      Icons.edit_outlined,
                      color: appColorWhite,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    titleBdp(
                      "Pregunta a la comunidad",
                      color: appColorWhite,
                      size: 13,
                    ),
                  ],
                ),
                action: () {
                  controller.setCommunityForm();
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBdpView(),
    );
  }
}
