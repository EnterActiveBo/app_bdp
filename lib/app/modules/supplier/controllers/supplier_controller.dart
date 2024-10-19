import 'package:appbdp/app/models/supplier_model.dart';
import 'package:get/get.dart';

class SupplierController extends GetxController {
  final Rx<SupplierModel?> supplier = (null as SupplierModel?).obs;
  final Rx<OfficeModel?> central = (null as OfficeModel?).obs;
  final RxList<OfficeModel> offices = (List<OfficeModel>.of([])).obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  setSupplier(SupplierModel item) {
    supplier.value = item;
    offices.value = [];
    central.value = item.offices.firstWhere(
      (office) => office.head,
      orElse: () => item.offices.first,
    );
    if (central.value is OfficeModel) {
      offices.add(central.value!);
    }
    offices.addAll(
      item.offices.where(
        (office) {
          return office.id != central.value?.id;
        },
      ).toList(),
    );
  }
}
