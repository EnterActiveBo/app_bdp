import 'package:appbdp/app/common/widgets/bottom_bdp_view.dart';
import 'package:appbdp/app/common/widgets/element_widgets.dart';
import 'package:appbdp/app/common/widgets/header_bdp_view.dart';
import 'package:appbdp/app/common/widgets/items_widgets.dart';
import 'package:appbdp/app/common/widgets/query_widgets.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/support_model.dart';
import 'package:appbdp/app/models/user_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/supports_controller.dart';

class SupportsView extends GetView<SupportsController> {
  const SupportsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderBdpView(
        primary: true,
        title: "Soporte en Línea",
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
              titleBdp("Listado de Casos"),
              const SizedBox(
                height: 20,
              ),
              () {
                List<SupportModel> items = controller.supports;
                return queryBdpWidget(
                  !controller.loading.value && items.isNotEmpty,
                  LazyLoadScrollView(
                    child: SingleChildScrollView(
                      child: Column(
                        children: items.asMap().entries.map(
                          (item) {
                            return supportItem(
                              item.value,
                              mt: item.key == 0 ? 0 : 10,
                              action: () {
                                controller.setSupport(
                                  item.value,
                                );
                              },
                            );
                          },
                        ).toList(),
                      ),
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
      ),
      bottomNavigationBar: const BottomBdpView(),
      floatingActionButton: () {
        if (controller.user.value is UserModel &&
            controller.user.value?.role.name == 'client') {
          return buttonCustom(
            backgroundColor: appColorThird,
            w: 140,
            pv: 5,
            ph: 15,
            radius: 30,
            child: Row(
              children: [
                const Icon(
                  Icons.add_outlined,
                  color: appColorWhite,
                ),
                const SizedBox(
                  width: 5,
                ),
                titleBdp(
                  "Crear Nuevo",
                  color: appColorWhite,
                  size: 13,
                ),
              ],
            ),
            action: () {
              controller.showNewDialog();
            },
          );
        }
        return null;
      }(),
    );
  }
}
