import 'package:appbdp/app/common/widgets/bottom_bdp_view.dart';
import 'package:appbdp/app/common/widgets/element_widgets.dart';
import 'package:appbdp/app/common/widgets/header_bdp_view.dart';
import 'package:appbdp/app/common/widgets/items_widgets.dart';
import 'package:appbdp/app/common/widgets/query_widgets.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/supplier_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/suppliers_controller.dart';

class SuppliersView extends GetView<SuppliersController> {
  const SuppliersView({super.key});
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
                isFilter: controller.search.value is String ||
                    controller.technology.value is TechnologyModel,
                searchAction: (value) {
                  controller.setSearch(value);
                },
                action: () {
                  if (controller.search.value is String) {
                    controller.setSearch(null);
                    search.text = "";
                  }
                  if (controller.technology.value is TechnologyModel) {
                    controller.setTechnology(null);
                  }
                },
                filterWidget: PopupMenuButton(
                  tooltip: "Seleccionar Tecnología",
                  icon: iconRounded(
                    Icons.tune_outlined,
                  ),
                  onSelected: (TechnologyModel? value) {
                    controller.setTechnology(value);
                  },
                  itemBuilder: (context) {
                    List<PopupMenuEntry<TechnologyModel?>> items = [];
                    items.addAll(
                      controller.technologies.map(
                        (technology) {
                          return PopupMenuItem(
                            value: technology,
                            child: titleBdp(
                              technology.title,
                              size: 14,
                              align: TextAlign.left,
                              weight: controller.technology.value?.id ==
                                      technology.id
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: controller.technology.value?.id ==
                                      technology.id
                                  ? appColorPrimary
                                  : appColorWhite,
                            ),
                          );
                        },
                      ).toList(),
                    );
                    return items;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                child: () {
                  List<SupplierModel> suppliers = controller.filterSuppliers();
                  return queryBdpWidget(
                    (!controller.loading.value && suppliers.isNotEmpty),
                    Column(
                      children: suppliers.asMap().entries.map(
                        (supplier) {
                          return supplierItem(
                            supplier.value,
                            mt: supplier.key == 0 ? 0 : 15,
                            action: () {
                              controller.setSupplier(supplier.value);
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
      ),
      bottomNavigationBar: const BottomBdpView(),
    );
  }
}
