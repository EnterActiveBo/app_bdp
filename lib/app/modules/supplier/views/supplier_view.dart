import 'package:appbdp/app/common/widgets/bottom_bdp_view.dart';
import 'package:appbdp/app/common/widgets/header_bdp_view.dart';
import 'package:appbdp/app/common/widgets/items_widgets.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/supplier_controller.dart';

class SupplierView extends GetView<SupplierController> {
  const SupplierView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: HeaderBdpView(
          primary: true,
          title:
              controller.supplier.value?.title ?? "Directorio de Proveedores",
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                imageDetailItem(
                  title: controller.supplier.value?.title,
                  detail: controller.supplier.value?.detail,
                  imageUrl: controller.supplier.value?.image?.url,
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: controller.offices.asMap().entries.map(
                    (office) {
                      return officeItem(
                        office.value,
                        mt: office.key == 0 ? 0 : 15,
                      );
                    },
                  ).toList(),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: const BottomBdpView(),
      ),
    );
  }
}
