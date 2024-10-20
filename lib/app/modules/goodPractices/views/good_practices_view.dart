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
        title: "Directorio de Proveedores",
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 20,
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
                  List<CategoryResourceModel> categories =
                      controller.filterCategories();
                  return queryBdpWidget(
                    (!controller.loading.value && categories.isNotEmpty),
                    Column(
                      children: categories.asMap().entries.map(
                        (category) {
                          return containerBdp(
                            mt: category.key == 0 ? 0 : 15,
                            action: () {},
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
