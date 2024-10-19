import 'package:appbdp/app/common/http_config.dart';
import 'package:appbdp/app/constants/api.const.dart';
import 'package:appbdp/app/models/supplier_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SupplierProvider extends GetConnect {
  GetStorage box = GetStorage('App');

  @override
  void onInit() {
    httpClient.baseUrl = "${urlV1}suppliers";
    httpDefaultConfiguration(httpClient, box);
    httpClient.defaultDecoder = (map) {
      if (map['data'] is Map<String, dynamic>) {
        return SupplierModel.fromJson(map['data']);
      }
      if (map['data'] is List) {
        return List<SupplierModel>.from(
          map['data'].map(
            (item) {
              return SupplierModel.fromJson(item);
            },
          ).toList(),
        );
      }
    };
  }

  Future<List<SupplierModel>?> getSuppliers() async {
    final response = await get('/');
    return response.body;
  }
}
