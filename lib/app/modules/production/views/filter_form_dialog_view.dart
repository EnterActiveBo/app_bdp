import 'package:appbdp/app/common/utils.dart';
import 'package:appbdp/app/common/widgets/input_widgets.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/gatip_model.dart';
import 'package:appbdp/app/modules/production/controllers/production_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class FilterFormDialogView extends GetView<ProductionController> {
  const FilterFormDialogView({super.key});
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    FocusNode submitFocus = FocusNode();

    return SingleChildScrollView(
      child: Dialog(
        backgroundColor: appColorTransparent,
        child: Container(
          decoration: BoxDecoration(
            color: appColorWhite,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16),
            boxShadow: defaultBoxShadow(),
          ),
          width: Get.width,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: appColorPrimary,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      titleBdp(
                        "Filtrar Producción",
                        align: TextAlign.left,
                      ).expand(),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: const Icon(
                            Icons.close,
                            color: appErrorColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        titleBdp(
                          "Departamento",
                          weight: FontWeight.w400,
                          size: 15,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        DropdownSearch<ProductionDepartmentModel>(
                          selectedItem: controller.departmentSelected(),
                          items: (filter, loadProps) {
                            return controller.departments;
                          },
                          compareFn: (item1, item2) => item1.isEqual(item2),
                          itemAsString: (item) => item.name,
                          filterFn: (item, filter) => searchString(
                            item.name,
                            filter,
                          ),
                          popupProps: PopupProps.menu(
                            showSearchBox: true,
                            showSelectedItems: true,
                            fit: FlexFit.loose,
                            emptyBuilder: (
                              BuildContext context,
                              String search,
                            ) {
                              return Container(
                                height: 40,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 10,
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  "No se encontraron resultados para la búsqueda",
                                ),
                              );
                            },
                            searchFieldProps: const TextFieldProps(
                              decoration: InputDecoration(),
                            ),
                          ),
                          suffixProps: dropdownSuffixProps(),
                          decoratorProps: DropDownDecoratorProps(
                            decoration: dropDownDecoration(),
                          ),
                          onChanged: (ProductionDepartmentModel? item) {
                            controller.setDepartment(item);
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        titleBdp(
                          "Region",
                          weight: FontWeight.w400,
                          size: 15,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        DropdownSearch<ProductionRegionModel>(
                          selectedItem: controller.regionSelected(),
                          items: (filter, loadProps) {
                            return controller.regions;
                          },
                          compareFn: (item1, item2) => item1.isEqual(item2),
                          itemAsString: (item) => item.name,
                          filterFn: (item, filter) => searchString(
                            item.name,
                            filter,
                          ),
                          popupProps: PopupProps.menu(
                            showSearchBox: true,
                            showSelectedItems: true,
                            emptyBuilder: (
                              BuildContext context,
                              String search,
                            ) {
                              return Container(
                                height: 40,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 10,
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  "No se encontraron resultados para la búsqueda",
                                ),
                              );
                            },
                            searchFieldProps: const TextFieldProps(
                              decoration: InputDecoration(),
                            ),
                          ),
                          suffixProps: dropdownSuffixProps(),
                          decoratorProps: DropDownDecoratorProps(
                            decoration: dropDownDecoration(),
                          ),
                          onChanged: (ProductionRegionModel? item) {
                            controller.setRegion(item);
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        titleBdp(
                          "Municipio",
                          weight: FontWeight.w400,
                          size: 15,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        DropdownSearch<ProductionMunicipalityModel>(
                          selectedItem: controller.municipalitySelected(),
                          items: (filter, loadProps) {
                            return controller.municipalities;
                          },
                          compareFn: (item1, item2) => item1.isEqual(item2),
                          itemAsString: (item) => item.name,
                          filterFn: (item, filter) => searchString(
                            item.name,
                            filter,
                          ),
                          popupProps: PopupProps.menu(
                            showSearchBox: true,
                            showSelectedItems: true,
                            emptyBuilder: (
                              BuildContext context,
                              String search,
                            ) {
                              return Container(
                                height: 40,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 10,
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  "No se encontraron resultados para la búsqueda",
                                ),
                              );
                            },
                            searchFieldProps: const TextFieldProps(
                              decoration: InputDecoration(),
                            ),
                          ),
                          suffixProps: dropdownSuffixProps(),
                          decoratorProps: DropDownDecoratorProps(
                            decoration: dropDownDecoration(),
                          ),
                          onChanged: (ProductionMunicipalityModel? item) {
                            controller.setMunicipality(item);
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        titleBdp(
                          "Producto",
                          weight: FontWeight.w400,
                          size: 15,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        DropdownSearch<ProductionProductModel>(
                          selectedItem: controller.productSelected(),
                          items: (filter, loadProps) {
                            return controller.products;
                          },
                          compareFn: (item1, item2) => item1.isEqual(item2),
                          itemAsString: (item) => item.name,
                          filterFn: (item, filter) => searchString(
                            item.name,
                            filter,
                          ),
                          popupProps: PopupProps.menu(
                            showSearchBox: true,
                            showSelectedItems: true,
                            emptyBuilder: (
                              BuildContext context,
                              String search,
                            ) {
                              return Container(
                                height: 40,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 10,
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  "No se encontraron resultados para la búsqueda",
                                ),
                              );
                            },
                            searchFieldProps: const TextFieldProps(
                              decoration: InputDecoration(),
                            ),
                          ),
                          suffixProps: dropdownSuffixProps(),
                          decoratorProps: DropDownDecoratorProps(
                            decoration: dropDownDecoration(),
                          ),
                          onChanged: (ProductionProductModel? item) {
                            controller.setProduct(item);
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        titleBdp(
                          "Unidad de Medida",
                          weight: FontWeight.w400,
                          size: 15,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        DropdownSearch<ProductionUnitModel>(
                          selectedItem: controller.unitSelected(),
                          items: (filter, loadProps) {
                            return controller.units;
                          },
                          compareFn: (item1, item2) => item1.isEqual(item2),
                          itemAsString: (item) => item.unit,
                          filterFn: (item, filter) => searchString(
                            item.unit,
                            filter,
                          ),
                          popupProps: PopupProps.menu(
                            showSearchBox: false,
                            showSelectedItems: true,
                            fit: FlexFit.loose,
                            emptyBuilder: (
                              BuildContext context,
                              String search,
                            ) {
                              return Container(
                                height: 40,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 10,
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  "No se encontraron resultados para la búsqueda",
                                ),
                              );
                            },
                            searchFieldProps: const TextFieldProps(
                              decoration: InputDecoration(),
                            ),
                          ),
                          suffixProps: dropdownSuffixProps(
                            showClear: false,
                          ),
                          decoratorProps: DropDownDecoratorProps(
                            decoration: dropDownDecoration(),
                          ),
                          onChanged: (ProductionUnitModel? item) {
                            controller.setUnit(item);
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        buttonBdp(
                          "Filtrar",
                          () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              controller.filter();
                            }
                          },
                          focusNode: submitFocus,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
