import 'package:appbdp/app/common/http_config.dart';
import 'package:appbdp/app/constants/api.const.dart';
import 'package:appbdp/app/models/resource_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ResourceProvider extends GetConnect {
  GetStorage box = GetStorage('App');

  @override
  void onInit() {
    httpClient.baseUrl = "${urlV1}resources/";
    httpDefaultConfiguration(httpClient, box);
    httpClient.defaultDecoder = (map) {
      if (map['data'] is Map<String, dynamic>) {
        return ResourceModel.fromJson(map['data']);
      }
      if (map['data'] is List) {
        return List<ResourceModel>.from(
          map['data'].map(
            (item) {
              return ResourceModel.fromJson(item);
            },
          ).toList(),
        );
      }
    };
  }

  Future<List<ResourceModel>?> getResources(String categoryId) async {
    final response = await get(categoryId);
    return response.body;
  }
}
