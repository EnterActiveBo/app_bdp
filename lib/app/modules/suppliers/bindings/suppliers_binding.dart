import 'package:appbdp/app/models/providers/supplier_provider.dart';
import 'package:appbdp/app/models/providers/technology_provider.dart';
import 'package:appbdp/app/modules/supplier/controllers/supplier_controller.dart';
import 'package:get/get.dart';

import '../controllers/suppliers_controller.dart';

class SuppliersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TechnologyProvider>(
      () => TechnologyProvider(),
    );
    Get.lazyPut<SupplierProvider>(
      () => SupplierProvider(),
    );
    Get.lazyPut<SupplierController>(
      () => SupplierController(),
    );
    Get.put<SuppliersController>(
      SuppliersController(),
    );
  }
}
