import 'package:appbdp/app/common/utils.dart';
import 'package:appbdp/app/common/widgets/bottom_bdp_view.dart';
import 'package:appbdp/app/common/widgets/element_widgets.dart';
import 'package:appbdp/app/common/widgets/header_bdp_view.dart';
import 'package:appbdp/app/common/widgets/input_widgets.dart';
import 'package:appbdp/app/common/widgets/items_widgets.dart';
import 'package:appbdp/app/common/widgets/query_widgets.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/gatip_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../controllers/production_controller.dart';

class ProductionView extends GetView<ProductionController> {
  const ProductionView({super.key});
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
                  "Información de Producción",
                ),
                const SizedBox(
                  height: 20,
                ),
                DropdownSearch<ProductionItemModel>(
                  selectedItem: controller.items.firstWhere((i) => i.selected),
                  items: (filter, loadProps) {
                    return controller.items;
                  },
                  compareFn: (item1, item2) => item1.isEqual(item2),
                  itemAsString: (item) => item.name,
                  filterFn: (item, filter) => searchString(item.name, filter),
                  popupProps: PopupProps.menu(
                    showSearchBox: false,
                    showSelectedItems: true,
                    fit: FlexFit.loose,
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
                  ),
                  suffixProps: dropdownSuffixProps(
                    showClear: false,
                  ),
                  decoratorProps: DropDownDecoratorProps(
                    decoration: dropDownDecoration(),
                  ),
                  onChanged: (ProductionItemModel? item) {
                    if (item != null) {
                      controller.setItem(item);
                    }
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: Get.width,
                  child: titleBdp(
                    "COMPOSICIÓN DE LA SUPERFICIE DE PRODUCCIÓN",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                containerBdp(
                  pv: 10,
                  ph: 10,
                  child: queryBdpWidget(
                    !controller.loadingChart.value &&
                        controller.chartData.isNotEmpty,
                    SfCircularChart(
                      legend: const Legend(
                        isVisible: true,
                        shouldAlwaysShowScrollbar: true,
                        overflowMode: LegendItemOverflowMode.wrap,
                        position: LegendPosition.bottom,
                        textStyle: TextStyle(
                          fontSize: 10,
                        ),
                      ),
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
                            "${priceFormat((point.y ?? 0) + 0.0)} ${controller.unitSelected()?.unit ?? ""}",
                          );
                        },
                      ),
                      annotations: <CircularChartAnnotation>[
                        CircularChartAnnotation(
                          height: '100%',
                          width: '100%',
                          widget: PhysicalModel(
                            shape: BoxShape.circle,
                            elevation: 10,
                            color: appBackground,
                            child: Container(),
                          ),
                        ),
                        CircularChartAnnotation(
                          width: '100%',
                          widget: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              titleBdp(
                                priceFormat(controller.getTotal()),
                                size: 11,
                                max: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              titleBdp(
                                controller.unitSelected()?.unit ?? "",
                                size: 9,
                                max: 1,
                                color: appColorThird,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        )
                      ],
                      series: <CircularSeries>[
                        DoughnutSeries<ProductionCompositionModel, String>(
                          dataSource: controller.chartData,
                          xValueMapper: (ProductionCompositionModel data, _) {
                            return data.detail;
                          },
                          yValueMapper: (ProductionCompositionModel data, _) {
                            return data.quantity;
                          },
                          dataLabelMapper:
                              (ProductionCompositionModel data, _) {
                            double percent = data.quantity * 100;
                            percent /= controller.getTotal();
                            return "${priceFormat(percent)} %";
                          },
                          dataLabelSettings: const DataLabelSettings(
                            isVisible: true,
                            labelPosition: ChartDataLabelPosition.outside,
                            textStyle: TextStyle(
                              color: appColorPrimary,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                      palette: const [
                        Colors.green,
                        Colors.orange,
                        Colors.purple,
                        Colors.blue,
                        Colors.brown,
                        Colors.lime,
                        Colors.teal,
                        Colors.deepOrange,
                        Colors.indigo,
                      ],
                    ),
                    loading: controller.loadingChart.value,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: Get.width,
                  child: titleBdp(
                    "PRODUCCIÓN Y UBICACIÓN DE LOS 5 PRINCIPALES PRODUCTOS",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                queryBdpWidget(
                  !controller.loadingLocation.value &&
                      controller.locations.isNotEmpty,
                  locationItems(
                    controller.locations,
                    unit: controller.unitSelected()?.unit,
                  ),
                  loading: controller.loadingLocation.value,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomBdpView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.showFilterDialog();
        },
        backgroundColor: appColorSecondary,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.tune_outlined,
          color: appColorWhite,
        ),
      ),
    );
  }
}
