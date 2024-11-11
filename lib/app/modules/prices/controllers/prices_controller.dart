import 'package:appbdp/app/common/storage_box.dart';
import 'package:appbdp/app/models/gatip_model.dart';
import 'package:appbdp/app/models/providers/gatip_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PricesController extends GetxController {
  GetStorage box = GetStorage('App');
  final GatipProvider gatipProvider = Get.find<GatipProvider>();
  String productsKey = 'gatip_products';
  final Rx<PricesProductModel?> product = (null as PricesProductModel?).obs;
  final RxList<PricesProductModel> products =
      (List<PricesProductModel>.of([])).obs;
  final RxList<PricesYearModel> years = (List<PricesYearModel>.of([])).obs;
  final loadingYears = true.obs;
  final RxList<PricesCityModel> cities = (List<PricesCityModel>.of([])).obs;
  final loadingCity = true.obs;
  final Rx<PricesAccumulatedModel?> gaugeData =
      (null as PricesAccumulatedModel?).obs;
  final RxList<PricesAccumulatedModel> accumulated =
      (List<PricesAccumulatedModel>.of([])).obs;
  final loadingAccumulated = true.obs;
  final Map<String, String> units = {
    "@": "Arroba",
    "Kg.": "Kilos",
    "100 unid.": "100 unidades",
    "CAJA 100 unid.": "Caja de 100 unidades",
    "unid.": "Unidades",
    "BIDON 900 cc.": "Bidón de 900 centímetros cúbicos",
    "Lt.": "Litros",
    "46 Kg.": "46 kilogramos",
    "qq.": "Quintales",
    "SACO qq.": "Quintal",
    "BOLSA 946 ml.": "Bolsa de 946 mililitros",
    "LATA 2500 grs.": "Lata de 2500 gramos",
    "LATA 17 Kg.": "Lata de 17 Kilogramos",
    "CAJA 17 Kg.": "Caja de 17 Kilogramos",
    "50 Kg.": "50 kilogramos",
    "BOLSA @": "Bolsa de arroba",
  };

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
    loadingYears.value = true;
    loadingCity.value = true;
    loadingAccumulated.value = true;
    super.onClose();
  }

  initData() {
    initProducts();
  }

  initProducts() {
    products.value = gatipProductsStored(box);
    getProducts();
  }

  getProducts() async {
    final response = await gatipProvider.getPricesProducts();
    if (response is List<PricesProductModel>) {
      products.value = response;
      box.write(productsKey, response);
    }
    setProduct(products.first);
  }

  setProduct(PricesProductModel? product) {
    this.product.value = product;
    if (this.product.value is PricesProductModel) {
      getYears(this.product.value!.code);
      getCities(this.product.value!.code);
      getAccumulated(this.product.value!.code);
    }
  }

  getYears(int productCode) async {
    loadingYears.value = true;
    final response = await gatipProvider.getPricesYear(productCode);
    loadingYears.value = false;
    if (response is List<PricesYearModel>) {
      years.value = response;
      years.refresh();
    }
  }

  getCities(int productCode) async {
    loadingCity.value = true;
    final response = await gatipProvider.getPricesCity(productCode);
    loadingCity.value = false;
    if (response is List<PricesCityModel>) {
      cities.value = response;
      cities.refresh();
    }
  }

  getAccumulated(int productCode) async {
    loadingAccumulated.value = true;
    final response = await gatipProvider.getPricesAccumulated(productCode);
    loadingAccumulated.value = false;
    if (response is List<PricesAccumulatedModel>) {
      List<PricesAccumulatedModel> data = [];
      gaugeData.value = response.first;
      data.add(response.first);
      data.addAll(response.reversed.take(3).toList());
      accumulated.value = data;
      accumulated.refresh();
      gaugeData.refresh();
    }
  }

  setGaugeData(PricesAccumulatedModel data) async {
    gaugeData.value = data;
  }

  String? getUnit() {
    return years.isNotEmpty ? years.first.unit : null;
  }

  String? getUnitName() {
    return units[getUnit()];
  }

  PricesCityModel? getLastCityYear() {
    return cities.isNotEmpty ? cities.last : null;
  }
}
