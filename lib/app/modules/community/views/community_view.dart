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
import 'package:nb_utils/nb_utils.dart';

import '../controllers/community_controller.dart';

class CommunityView extends GetView<CommunityController> {
  const CommunityView({super.key});
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final search = TextEditingController();
    final FocusNode searchFocusNode = FocusNode();
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
                children: [
                  searchFilter(
                    formKey,
                    search: search,
                    searchFocusNode: searchFocusNode,
                    isFilter: controller.search.value is String,
                    searchAction: (value) {
                      controller.setSearch(value);
                    },
                    action: () {
                      if (controller.search.value is String) {
                        controller.setSearch(null);
                        search.text = "";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    child: () {
                      List<CommunityModel> items = controller.communities;
                      return queryBdpWidget(
                        !controller.loading.value && items.isNotEmpty,
                        Column(
                          children: items.asMap().entries.map(
                            (item) {
                              return communityItem(
                                item.value,
                                mt: item.key == 0 ? 0 : 15,
                                maxTitle: 2,
                                titleOverflow: TextOverflow.ellipsis,
                                maxDetail: 2,
                                detailOverflow: TextOverflow.ellipsis,
                                action: () {
                                  controller.setCommunity(item.value);
                                },
                                enableEdit: controller.user.value?.id ==
                                    item.value.user.id,
                                actionEdit: () {
                                  controller.setCommunityForm(
                                    value: item.value,
                                  );
                                },
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
            Positioned(
              bottom: 10,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  controller.setCommunityForm();
                },
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
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBdpView(),
    );
  }
}
