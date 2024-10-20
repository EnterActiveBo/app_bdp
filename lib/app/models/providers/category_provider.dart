import 'package:appbdp/app/common/http_config.dart';
import 'package:appbdp/app/constants/api.const.dart';
import 'package:appbdp/app/models/resource_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CategoryProvider extends GetConnect {
  GetStorage box = GetStorage('App');

  @override
  void onInit() {
    httpClient.baseUrl = "${urlV1}categories";
    httpDefaultConfiguration(httpClient, box);
    httpClient.defaultDecoder = (map) {
      if (map['data'] is Map<String, dynamic>) {
        return CategoryResourceModel.fromJson(map['data']);
      }
      if (map['data'] is List) {
        return List<CategoryResourceModel>.from(
          map['data'].map(
            (item) {
              return CategoryResourceModel.fromJson(item);
            },
          ).toList(),
        );
      }
    };
  }

  Future<List<CategoryResourceModel>?> getCategories() async {
    final response = await get('/');
    return response.body;
  }
}
