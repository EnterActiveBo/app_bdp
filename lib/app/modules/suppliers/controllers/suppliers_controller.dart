import 'package:appbdp/app/common/storage_box.dart';
import 'package:appbdp/app/common/utils.dart';
import 'package:appbdp/app/models/providers/supplier_provider.dart';
import 'package:appbdp/app/models/supplier_model.dart';
import 'package:appbdp/app/modules/supplier/controllers/supplier_controller.dart';
import 'package:appbdp/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SuppliersController extends GetxController {
  GetStorage box = GetStorage('App');
  final SupplierProvider supplierProvider = Get.find();
  final SupplierController supplierController = Get.find();
  String supplierKey = 'suppliers';
  final RxList<SupplierModel> suppliers = (List<SupplierModel>.of([])).obs;
  final RxList<TechnologyModel> technologies =
      (List<TechnologyModel>.of([])).obs;
  final Rx<String?> search = (null as String?).obs;
  final Rx<TechnologyModel?> technology = (null as TechnologyModel?).obs;
  final loading = true.obs;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    loading.value = true;
    search.value = null;
  }

  initData() {
    suppliers.value = suppliersStored(box);
    getSuppliers();
    getTechnologies();
  }

  getSuppliers() async {
    List<SupplierModel>? suppliersResponse =
        await supplierProvider.getSuppliers();
    loading.value = false;
    if (suppliersResponse is List<SupplierModel>) {
      suppliers.value = suppliersResponse;
      box.write(supplierKey, suppliersResponse);
      getTechnologies();
    }
  }

  getTechnologies() {
    List<TechnologyModel> tech = [];
    suppliers.forEach((supplier) {
      tech.addAll(supplier.technologies);
    });
    technologies.value = tech;
  }

  List<SupplierModel> filterSuppliers() {
    return suppliers.where((supplier) {
      bool filter = true;
      if (search.value is String) {
        filter &= searchString(
          supplier.title,
          search.value,
        );
        if (supplier.detail is String) {
          filter |= searchString(
            supplier.detail ?? "",
            search.value,
          );
        }
      }
      if (technology.value is TechnologyModel) {
        filter &= supplier.technologies
            .where(
              (tech) => tech.id == technology.value?.id,
            )
            .isNotEmpty;
      }
      return filter;
    }).toList();
  }

  setSearch(String? value) {
    search.value = value == "" ? null : value;
  }

  setTechnology(TechnologyModel? value) {
    technology.value = value;
  }

  setSupplier(SupplierModel item) {
    supplierController.setSupplier(item);
    Get.toNamed(Routes.SUPPLIER);
  }
}
