import 'package:appbdp/app/common/widgets/bottom_bdp_view.dart';
import 'package:appbdp/app/common/widgets/element_widgets.dart';
import 'package:appbdp/app/common/widgets/header_bdp_view.dart';
import 'package:appbdp/app/common/widgets/query_widgets.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/resource_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/good_practices_controller.dart';

class GoodPracticesView extends GetView<GoodPracticesController> {
  const GoodPracticesView({super.key});
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final search = TextEditingController();
    final FocusNode searchFocusNode = FocusNode();

    return Scaffold(
      appBar: const HeaderBdpView(
        primary: true,
        title: "Buenas Practicas",
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 20,
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
              SizedBox(
                height: controller.user.value?.isClient() == true ? 15 : 0,
              ),
              Visibility(
                visible: controller.user.value?.isClient() == true,
                child: Row(
                  children: [
                    titleBdp(
                      "Filtrar",
                      align: TextAlign.left,
                    ).expand(),
                    GestureDetector(
                      onTap: () {
                        controller.cleanFilterCategory();
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
              ),
              SizedBox(
                height: controller.user.value?.isClient() == true ? 10 : 0,
              ),
              Visibility(
                visible: controller.user.value?.isClient() == true,
                child: () {
                  List<CategoryResourceModel> items = controller.categories.map(
                    (category) {
                      return category.category ?? category;
                    },
                  ).toList();
                  List<String> ids = items
                      .map(
                        (item) => item.id,
                      )
                      .toSet()
                      .toList();
                  items.retainWhere(
                    (i) => ids.remove(i.id),
                  );
                  items.sort();
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: items.toList().asMap().entries.map(
                        (category) {
                          bool isSelected =
                              controller.catagoriesSelected.contains(
                            category.value.id,
                          );
                          return tagContainer(
                            ml: category.key == 0 ? 0 : 5,
                            pv: 5,
                            ph: 15,
                            radius: 5,
                            backgroundColor: isSelected
                                ? appColorThirdOpacity
                                : appBackgroundOpacity,
                            child: titleBdp(
                              category.value.title,
                              size: 12,
                              color:
                                  isSelected ? appColorThird : appColorPrimary,
                            ),
                            action: () {
                              controller.setFilterCategory(
                                category.value.id,
                              );
                            },
                          );
                        },
                      ).toList(),
                    ),
                  );
                }(),
              ),
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                child: () {
                  List<CategoryResourceModel> categories =
                      controller.filterCategories();
                  return queryBdpWidget(
                    (!controller.loading.value && categories.isNotEmpty),
                    Column(
                      children: categories.asMap().entries.map(
                        (category) {
                          return containerBdp(
                            mt: category.key == 0 ? 0 : 15,
                            action: () {
                              controller.setCategory(category.value);
                            },
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    titleBdp(
                                      category.value.category?.title ?? "BDP",
                                      color: appColorThird,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    titleBdp(
                                      category.value.title,
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
      ),
      bottomNavigationBar: const BottomBdpView(),
    );
  }
}
