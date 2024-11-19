import 'package:appbdp/app/common/widgets/bottom_bdp_view.dart';
import 'package:appbdp/app/common/widgets/element_widgets.dart';
import 'package:appbdp/app/common/widgets/header_bdp_view.dart';
import 'package:appbdp/app/common/widgets/items_widgets.dart';
import 'package:appbdp/app/common/widgets/query_widgets.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/course_model.dart';
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
        () {
          List<SupplierModel> suppliers = controller.filterSuppliers();
          List<Widget> itemsWidgets = [];
          controller.technologies.asMap().entries.forEach(
            (technology) {
              List<SupplierModel> suppliersWidgets = suppliers
                  .where(
                    (s) => s.haveTechnology(technology.value),
                  )
                  .toList();
              if (suppliersWidgets.isNotEmpty) {
                itemsWidgets.add(
                  Container(
                    margin: EdgeInsets.only(
                      top: technology.key == 0 ? 0 : 15,
                      bottom: 15,
                    ),
                    alignment: Alignment.centerLeft,
                    child: titleBdp(
                      technology.value.title,
                      align: TextAlign.left,
                    ),
                  ),
                );
                itemsWidgets.addAll(
                  suppliersWidgets.asMap().entries.map(
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
                );
              }
            },
          );
          return Padding(
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
                      controller.technology.value is TechnologyModel ||
                      controller.department.value is TargetModel,
                  searchAction: (value) {
                    controller.setSearch(value);
                  },
                  action: () {
                    if (controller.search.value is String) {
                      controller.setSearch(null);
                      search.text = "";
                    }
                    controller.setTechnology(null);
                    controller.setDepartment(null);
                  },
                  filterWidget: Row(
                    children: [
                      PopupMenuButton(
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
                      PopupMenuButton(
                        tooltip: "Seleccionar Departamento",
                        icon: iconRounded(
                          Icons.location_on_outlined,
                        ),
                        onSelected: (TargetModel? value) {
                          controller.setDepartment(value);
                        },
                        itemBuilder: (context) {
                          List<PopupMenuEntry<TargetModel?>> items = [];
                          items.addAll(
                            controller.getDepartments().map(
                              (department) {
                                return PopupMenuItem(
                                  value: department,
                                  child: titleBdp(
                                    department.name,
                                    size: 14,
                                    align: TextAlign.left,
                                    weight: controller.department.value?.id ==
                                            department.id
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: controller.department.value?.id ==
                                            department.id
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
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: () {
                    List<String> filters = [];
                    if (controller.technology.value is TechnologyModel) {
                      filters.add(
                        controller.technology.value!.getTitleTruncated(),
                      );
                    }
                    if (controller.department.value is TargetModel) {
                      filters.add(controller.department.value!.name);
                    }
                    return textRichBdp(
                      "Filtro: ",
                      filters.isNotEmpty ? filters.join(" | ") : "Ninguno",
                      titleSize: 17,
                      titleColor: appColorThird,
                      detailSize: 17,
                    );
                  }(),
                ),
                SingleChildScrollView(
                  child: queryBdpWidget(
                    (!controller.loading.value && itemsWidgets.isNotEmpty),
                    Column(
                      children: itemsWidgets,
                    ),
                    loading: controller.loading.value,
                  ),
                ).expand(),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const BottomBdpView(),
    );
  }
}
