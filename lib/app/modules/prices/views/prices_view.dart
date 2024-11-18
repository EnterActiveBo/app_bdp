import 'package:appbdp/app/common/utils.dart';
import 'package:appbdp/app/common/widgets/bottom_bdp_view.dart';
import 'package:appbdp/app/common/widgets/element_widgets.dart';
import 'package:appbdp/app/common/widgets/header_bdp_view.dart';
import 'package:appbdp/app/common/widgets/query_widgets.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/gatip_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../controllers/prices_controller.dart';

class PricesView extends GetView<PricesController> {
  const PricesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderBdpView(
        primary: true,
        title: "Mapa de Complejidades",
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 15,
            ),
            child: Column(
              children: [
                titleBdp(
                  "Información de Precios mayoristas de productos agrícolas",
                ),
                const SizedBox(
                  height: 20,
                ),
                DropdownSearch<PricesProductModel>(
                  selectedItem: controller.product.value,
                  items: (filter, loadProps) {
                    return controller.products;
                  },
                  compareFn: (item1, item2) => item1.isEqual(item2),
                  itemAsString: (item) => item.name,
                  filterFn: (item, filter) => searchString(item.name, filter),
                  popupProps: PopupProps.menu(
                    showSearchBox: true,
                    searchDelay: Duration.zero,
                    showSelectedItems: true,
                    emptyBuilder: (BuildContext context, String search) {
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
                  suffixProps: const DropdownSuffixProps(
                    clearButtonProps: ClearButtonProps(
                      isVisible: true,
                      color: appColorPrimary,
                    ),
                    dropdownButtonProps: DropdownButtonProps(
                      iconClosed: Icon(Icons.keyboard_arrow_down_outlined),
                      iconOpened: Icon(Icons.keyboard_arrow_up_outlined),
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll<Color>(
                          appColorThird,
                        ),
                        iconColor: WidgetStatePropertyAll<Color>(
                          appColorWhite,
                        ),
                      ),
                    ),
                  ),
                  decoratorProps: DropDownDecoratorProps(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: appBackgroundOpacity,
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 0,
                          color: appColorTransparent,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: appColorTransparent,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: appColorTransparent,
                          width: 1,
                        ),
                      ),
                      hintStyle: const TextStyle(
                        color: appColorPrimary,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 25,
                      ),
                    ),
                  ),
                  onChanged: (PricesProductModel? product) {
                    controller.setProduct(product);
                  },
                ),
                containerBdp(
                  mt: 15,
                  child: Column(
                    children: [
                      titleBdp(controller.product.value?.name ?? ""),
                      dividerBdp(),
                      SizedBox(
                        width: Get.width,
                        child: textBdp(
                          "Unidad de Medida:",
                          align: TextAlign.left,
                        ),
                      ),
                      iconTextActionBdp(
                        iconWidget: pointBdp(),
                        title: controller.getUnit(),
                        mt: 0,
                      ),
                      iconTextActionBdp(
                        iconWidget: pointBdp(),
                        title: controller.getUnitName(),
                        mt: 5,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: Get.width,
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: titleBdp(
                    "Promedio por Año",
                    align: TextAlign.left,
                  ),
                ),
                containerBdp(
                  child: queryBdpWidget(
                    !controller.loadingYears.value,
                    SfCartesianChart(
                      series: <CartesianSeries>[
                        LineSeries<PricesYearModel, int>(
                          name: "Gestión",
                          dataSource: controller.years.reversed
                              .take(4)
                              .toList()
                              .reversed
                              .toList(),
                          color: appColorSecondary,
                          xValueMapper: (PricesYearModel data, _) => data.year,
                          yValueMapper: (PricesYearModel data, _) =>
                              data.average,
                          markerSettings: const MarkerSettings(
                            isVisible: true,
                            color: appColorWhite,
                          ),
                        ),
                      ],
                      tooltipBehavior: TooltipBehavior(
                        enable: true,
                        builder: (
                          data,
                          point,
                          series,
                          pointIndex,
                          seriesIndex,
                        ) {
                          return tooltipBdp(
                            point.x.toString(),
                            "Promedio: ${point.y}",
                          );
                        },
                      ),
                    ),
                    loading: controller.loadingYears.value,
                  ),
                ),
                Container(
                  width: Get.width,
                  margin: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  child: titleBdp(
                    "Promedio por Ciudad Gestión ${controller.getLastCityYear()?.year}",
                    align: TextAlign.left,
                  ),
                ),
                containerBdp(
                  child: queryBdpWidget(
                    !controller.loadingCity.value,
                    SfCartesianChart(
                      primaryXAxis: const CategoryAxis(
                        majorGridLines: MajorGridLines(width: 0),
                        labelIntersectAction: AxisLabelIntersectAction.rotate90,
                        crossesAt: -2,
                        placeLabelsNearAxisLine: false,
                        maximumLabels: 10,
                      ),
                      series: <CartesianSeries<PricesCityModel, String>>[
                        () {
                          List<PricesCityModel> cities = [];
                          if (controller.cities.isNotEmpty) {
                            cities = controller.cities.where((c) {
                              return c.year ==
                                  controller.getLastCityYear()?.year;
                            }).toList();
                          }
                          return ColumnSeries<PricesCityModel, String>(
                            dataSource: cities,
                            color: appColorSecondary,
                            xValueMapper: (PricesCityModel data, _) {
                              return data.city;
                            },
                            yValueMapper: (PricesCityModel data, _) {
                              return data.average;
                            },
                          );
                        }(),
                      ],
                      tooltipBehavior: TooltipBehavior(
                        enable: true,
                        builder: (
                          data,
                          point,
                          series,
                          pointIndex,
                          seriesIndex,
                        ) {
                          return tooltipBdp(
                            point.x.toString(),
                            "Promedio: ${point.y}",
                          );
                        },
                      ),
                    ),
                    loading: controller.loadingCity.value,
                  ),
                ),
                Container(
                  width: Get.width,
                  margin: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  child: titleBdp(
                    "Valoración por Año",
                    align: TextAlign.left,
                  ),
                ),
                Row(
                  children: controller.accumulated.asMap().entries.map(
                    (tag) {
                      bool isSelected =
                          tag.value.label == controller.gaugeData.value?.label;
                      return tagContainer(
                        ml: tag.key == 0 ? 0 : 5,
                        pv: 5,
                        ph: 15,
                        radius: 5,
                        backgroundColor: isSelected
                            ? appColorThirdOpacity
                            : appBackgroundOpacity,
                        child: titleBdp(
                          tag.value.label,
                          size: 12,
                          color: isSelected ? appColorThird : appColorPrimary,
                        ),
                        action: () {
                          controller.setGaugeData(tag.value);
                        },
                      );
                    },
                  ).toList(),
                ),
                const SizedBox(
                  height: 20,
                ),
                containerBdp(
                  child: queryBdpWidget(
                    !controller.loadingAccumulated.value &&
                        controller.gaugeData.value is PricesAccumulatedModel,
                    SfRadialGauge(
                      axes: <RadialAxis>[
                        () {
                          double min = controller.gaugeData.value?.min ?? 0;
                          double max = controller.gaugeData.value?.max ?? 150;
                          if (min == max) {
                            max++;
                          }
                          double range = max - min;
                          return RadialAxis(
                            minimum: min,
                            maximum: max,
                            ranges: [
                              GaugeRange(
                                startValue: min,
                                endValue: min + (range / 3),
                                color: appColorThird,
                                startWidth: 10,
                                endWidth: 10,
                              ),
                              GaugeRange(
                                startValue: min + (range / 3),
                                endValue: min + ((range * 2) / 3),
                                color: appColorPrimary,
                                startWidth: 10,
                                endWidth: 10,
                              ),
                              GaugeRange(
                                startValue: min + ((range * 2) / 3),
                                endValue: max,
                                color: appColorSecondary,
                                startWidth: 10,
                                endWidth: 10,
                              ),
                            ],
                            pointers: <GaugePointer>[
                              NeedlePointer(
                                value:
                                    controller.gaugeData.value?.average ?? 90,
                              ),
                            ],
                            annotations: <GaugeAnnotation>[
                              GaugeAnnotation(
                                widget: Text(
                                  controller.gaugeData.value?.average
                                          .toString() ??
                                      "90",
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                angle: 90,
                                positionFactor: 0.5,
                              ),
                            ],
                          );
                        }(),
                      ],
                    ),
                    loading: controller.loadingAccumulated.value,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomBdpView(),
    );
  }
}
