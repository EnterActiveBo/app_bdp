import 'package:appbdp/app/common/widgets/bottom_bdp_view.dart';
import 'package:appbdp/app/common/widgets/element_widgets.dart';
import 'package:appbdp/app/common/widgets/header_bdp_view.dart';
import 'package:appbdp/app/common/widgets/query_widgets.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/pathology_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/pathologies_controller.dart';

class PathologiesView extends GetView<PathologiesController> {
  const PathologiesView({super.key});
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final search = TextEditingController();
    final FocusNode searchFocusNode = FocusNode();

    return Scaffold(
      appBar: const HeaderBdpView(
        primary: true,
        title: "Enfermedades",
      ),
      body: Obx(
        () => Padding(
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
              Row(
                children: [
                  titleBdp(
                    "Filtrar",
                    align: TextAlign.left,
                  ).expand(),
                  GestureDetector(
                    onTap: () {
                      controller.cleanTags();
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
                  children: controller.tagsPathology.asMap().entries.map(
                    (tag) {
                      bool isSelected = controller.tags.contains(tag.value.id);
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
                          color: isSelected ? appColorThird : appColorPrimary,
                        ),
                        action: () {
                          controller.setTag(tag.value.id);
                        },
                      );
                    },
                  ).toList(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              () {
                List<PathologyModel> pathologies =
                    controller.filterPathologies();
                return queryBdpWidget(
                  !controller.loading.value && pathologies.isNotEmpty,
                  GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 15,
                    children: pathologies.asMap().entries.map(
                      (pathology) {
                        return pathologyItem(
                          pathology.value,
                          action: () {
                            controller.setPathology(pathology.value);
                          },
                        );
                      },
                    ).toList(),
                  ).expand(),
                  loading: controller.loading.value,
                );
              }(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomBdpView(),
    );
  }
}
