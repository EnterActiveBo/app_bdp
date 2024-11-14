import 'package:appbdp/app/common/http_config.dart';
import 'package:appbdp/app/constants/api.const.dart';
import 'package:appbdp/app/models/gatip_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GatipProvider extends GetConnect {
  GetStorage box = GetStorage('App');

  @override
  void onInit() {
    httpClient.baseUrl = urlV1;
    httpDefaultConfiguration(httpClient, box);
  }

  Future<List<PricesProductModel>?> getPricesProducts() async {
    final response = await get('gatip/prices/products');
    if (response.body != null && response.body['data'] is List) {
      return List<PricesProductModel>.from(
        response.body['data'].map(
          (item) {
            return PricesProductModel.fromJson(item);
          },
        ),
      );
    }
    return null;
  }

  Future<List<PricesYearModel>?> getPricesYear(int productCode) async {
    final response = await get('gatip/prices/$productCode/year');
    if (response.body != null && response.body['data'] is List) {
      return List<PricesYearModel>.from(
        response.body['data'].map(
          (item) {
            return PricesYearModel.fromJson(item);
          },
        ),
      );
    }
    return null;
  }

  Future<List<PricesCityModel>?> getPricesCity(int productCode) async {
    final response = await get('gatip/prices/$productCode/city');
    if (response.body != null && response.body['data'] is List) {
      return List<PricesCityModel>.from(
        response.body['data'].map(
          (item) {
            return PricesCityModel.fromJson(item);
          },
        ),
      );
    }
    return null;
  }

  Future<List<PricesAccumulatedModel>?> getPricesAccumulated(
    int productCode,
  ) async {
    final response = await get('gatip/prices/$productCode/accumulated');
    if (response.body != null && response.body['data'] is List) {
      return List<PricesAccumulatedModel>.from(
        response.body['data'].map(
          (item) {
            return PricesAccumulatedModel.fromJson(item);
          },
        ),
      );
    }
    return null;
  }

  Future<List<ProductionCompositionModel>?> getProductionComposition({
    Map<String, dynamic>? query,
  }) async {
    final response = await get(
      'gatip/production/composition',
      query: query,
    );
    if (response.body != null && response.body['data'] is List) {
      return List<ProductionCompositionModel>.from(
        response.body['data'].map(
          (item) {
            return ProductionCompositionModel.fromJson(item);
          },
        ),
      );
    }
    return null;
  }

  Future<List<ProductionLocationModel>?> getProductionLocation({
    Map<String, dynamic>? query,
  }) async {
    final response = await get(
      'gatip/production/location',
      query: query,
    );
    if (response.body != null && response.body['data'] is List) {
      return List<ProductionLocationModel>.from(
        response.body['data'].map(
          (item) {
            return ProductionLocationModel.fromJson(item);
          },
        ),
      );
    }
    return null;
  }

  Future<List<ProductionUnitModel>?> getProductionUnits({
    Map<String, dynamic>? query,
  }) async {
    final response = await get(
      'gatip/production/units',
      query: query,
    );
    if (response.body != null && response.body['data'] is List) {
      return List<ProductionUnitModel>.from(
        response.body['data'].map(
          (item) {
            return ProductionUnitModel.fromJson(item);
          },
        ),
      );
    }
    return null;
  }

  Future<List<ProductionDepartmentModel>?> getProductionDepartments({
    Map<String, dynamic>? query,
  }) async {
    final response = await get(
      'gatip/production/departments',
      query: query,
    );
    if (response.body != null && response.body['data'] is List) {
      return List<ProductionDepartmentModel>.from(
        response.body['data'].map(
          (item) {
            return ProductionDepartmentModel.fromJson(item);
          },
        ),
      );
    }
    return null;
  }

  Future<List<ProductionMunicipalityModel>?> getProductionMunicipalities({
    Map<String, dynamic>? query,
  }) async {
    final response = await get(
      'gatip/production/municipalities',
      query: query,
    );
    if (response.body != null && response.body['data'] is List) {
      return List<ProductionMunicipalityModel>.from(
        response.body['data'].map(
          (item) {
            return ProductionMunicipalityModel.fromJson(item);
          },
        ),
      );
    }
    return null;
  }

  Future<List<ProductionRegionModel>?> getProductionRegions({
    Map<String, dynamic>? query,
  }) async {
    final response = await get(
      'gatip/production/regions',
      query: query,
    );
    if (response.body != null && response.body['data'] is List) {
      return List<ProductionRegionModel>.from(
        response.body['data'].map(
          (item) {
            return ProductionRegionModel.fromJson(item);
          },
        ),
      );
    }
    return null;
  }

  Future<List<ProductionProductModel>?> getProductionProducts({
    Map<String, dynamic>? query,
  }) async {
    final response = await get(
      'gatip/production/products',
      query: query,
    );
    if (response.body != null && response.body['data'] is List) {
      return List<ProductionProductModel>.from(
        response.body['data'].map(
          (item) {
            return ProductionProductModel.fromJson(item);
          },
        ),
      );
    }
    return null;
  }

  Future<WeatherModel?> getAgroClimatic() async {
    final response = await get(
      'gatip/agro-climatic',
    );
    if (response.body != null && response.body['data'] != null) {
      return WeatherModel.fromJson(response.body['data']);
    }
    return null;
  }
}
