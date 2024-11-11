import 'package:appbdp/app/models/gatip_model.dart';
import 'package:appbdp/app/models/providers/gatip_provider.dart';
import 'package:appbdp/app/modules/production/views/filter_form_dialog_view.dart';
import 'package:get/get.dart';

class ProductionController extends GetxController {
  final GatipProvider gatipProvider = Get.find<GatipProvider>();
  final RxList<ProductionItemModel> items = (List<ProductionItemModel>.of(
    [
      ProductionItemModel(name: "AGRICOLA", selected: true),
      ProductionItemModel(name: "PECUARIO", selected: false),
    ],
  )).obs;
  final RxList<ProductionUnitModel> units = (List<ProductionUnitModel>.of(
    [],
  )).obs;
  final RxList<ProductionDepartmentModel> departments =
      (List<ProductionDepartmentModel>.of(
    [],
  )).obs;
  final RxList<ProductionRegionModel> regions = (List<ProductionRegionModel>.of(
    [],
  )).obs;
  final RxList<ProductionMunicipalityModel> municipalities =
      (List<ProductionMunicipalityModel>.of(
    [],
  )).obs;
  final RxList<ProductionProductModel> products =
      (List<ProductionProductModel>.of(
    [],
  )).obs;
  final RxList<ProductionCompositionModel> chartData =
      (List<ProductionCompositionModel>.of([])).obs;
  final loadingChart = true.obs;
  final RxList<ProductionLocationModel> locations =
      (List<ProductionLocationModel>.of([])).obs;
  final loadingLocation = true.obs;
  final totalChart = "TM".obs;

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
    loadingChart.value = true;
    loadingLocation.value = true;
  }

  initData() {
    getDepartments();
    getUnits();
    getRegions();
    getMunicipalities();
    getProducts();
    getComposition();
    getLocations();
  }

  getUnits() async {
    final response = await gatipProvider.getProductionUnits(
      query: getQuery(),
    );
    if (response is List<ProductionUnitModel>) {
      units.value = response;
      units.first.selected = true;
      units.refresh();
    }
  }

  setUnit(ProductionUnitModel? value) {
    units.value = units.map(
      (i) {
        i.selected = i.unit == value?.unit;
        return i;
      },
    ).toList();
    units.refresh();
  }

  ProductionUnitModel? unitSelected() {
    return units.firstWhereOrNull(
          (element) => element.selected == true,
        ) ??
        units.firstOrNull;
  }

  getDepartments() async {
    final response = await gatipProvider.getProductionDepartments();
    if (response is List<ProductionDepartmentModel>) {
      departments.value = response;
      departments.refresh();
    }
  }

  setDepartment(ProductionDepartmentModel? value) async {
    departments.value = departments.map(
      (i) {
        i.selected = i.name == value?.name;
        return i;
      },
    ).toList();
    departments.refresh();
  }

  ProductionDepartmentModel? departmentSelected() {
    return departments.firstWhereOrNull(
      (element) => element.selected == true,
    );
  }

  getRegions() async {
    final response = await gatipProvider.getProductionRegions(
      query: getQuery(),
    );
    if (response is List<ProductionRegionModel>) {
      regions.value = response;
      regions.refresh();
    }
  }

  setRegion(ProductionRegionModel? value) async {
    regions.value = regions.map(
      (i) {
        i.selected = i.code == value?.code;
        return i;
      },
    ).toList();
    regions.refresh();
  }

  ProductionRegionModel? regionSelected() {
    return regions.firstWhereOrNull(
      (item) => item.selected,
    );
  }

  getMunicipalities() async {
    final response = await gatipProvider.getProductionMunicipalities(
      query: getQuery(),
    );
    if (response is List<ProductionMunicipalityModel>) {
      municipalities.value = response;
      municipalities.refresh();
    }
  }

  setMunicipality(ProductionMunicipalityModel? value) async {
    municipalities.value = municipalities.map(
      (i) {
        i.selected = i.code == value?.code;
        return i;
      },
    ).toList();
    municipalities.refresh();
  }

  ProductionMunicipalityModel? municipalitySelected() {
    return municipalities.firstWhereOrNull(
      (item) => item.selected,
    );
  }

  getProducts() async {
    final response = await gatipProvider.getProductionProducts(
      query: getQuery(),
    );
    if (response is List<ProductionProductModel>) {
      products.value = response;
      products.refresh();
    }
  }

  setProduct(ProductionProductModel? value) async {
    products.value = products.map(
      (i) {
        i.selected = i.name == value?.name;
        return i;
      },
    ).toList();
    products.refresh();
  }

  ProductionProductModel? productSelected() {
    return products.firstWhereOrNull(
      (item) => item.selected,
    );
  }

  getComposition() async {
    loadingChart.value = true;
    final response = await gatipProvider.getProductionComposition(
      query: getQuery(),
    );
    loadingChart.value = false;
    if (response is List<ProductionCompositionModel>) {
      chartData.value = response;
      chartData.refresh();
    }
  }

  double getTotal() {
    double total = chartData.fold(
      0,
      (prev, element) => prev + element.quantity,
    );
    return total <= 0 ? 1 : total;
  }

  getLocations() async {
    loadingLocation.value = true;
    final response = await gatipProvider.getProductionLocation(
      query: getQuery(),
    );
    loadingLocation.value = false;
    if (response is List<ProductionLocationModel>) {
      locations.value = response;
      locations.refresh();
    }
  }

  setItem(ProductionItemModel value) async {
    items.value = items.map(
      (i) {
        i.selected = i.name == value.name;
        return i;
      },
    ).toList();
    items.refresh();
    loadingChart.value = true;
    loadingLocation.value = true;
    await getUnits();
    await getComposition();
    await getLocations();
  }

  String itemSelected() {
    return items
        .firstWhere(
          (element) => element.selected == true,
        )
        .name;
  }

  Map<String, dynamic> getQuery() {
    Map<String, dynamic> query = {
      "table": itemSelected(),
      "unit": unitSelected()?.unit,
      "department": departmentSelected()?.value,
      "region": regionSelected()?.code,
      "municipality": municipalitySelected()?.code,
      "product": productSelected()?.name,
    };
    query.removeWhere((key, value) => value == null);
    return query;
  }

  showFilterDialog() {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
    Get.dialog(
      barrierDismissible: false,
      const FilterFormDialogView(),
    );
  }

  filter() async {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
    loadingChart.value = true;
    loadingLocation.value = true;
    ProductionDepartmentModel? department = departmentSelected();
    ProductionRegionModel? region = regionSelected();
    ProductionMunicipalityModel? municipality = municipalitySelected();
    ProductionProductModel? product = productSelected();
    ProductionUnitModel? unit = unitSelected();
    await getDepartments();
    setDepartment(department);
    await getRegions();
    setRegion(region);
    await getMunicipalities();
    setMunicipality(municipality);
    await getProducts();
    setProduct(product);
    await getUnits();
    setUnit(unit);
    await getComposition();
    await getLocations();
  }
}
