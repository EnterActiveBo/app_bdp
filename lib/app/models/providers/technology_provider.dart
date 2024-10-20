import 'package:appbdp/app/common/http_config.dart';
import 'package:appbdp/app/constants/api.const.dart';
import 'package:appbdp/app/models/supplier_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TechnologyProvider extends GetConnect {
  GetStorage box = GetStorage('App');

  @override
  void onInit() {
    httpClient.baseUrl = "${urlV1}technologies";
    httpDefaultConfiguration(httpClient, box);
    httpClient.defaultDecoder = (map) {
      if (map['data'] is List) {
        return List<TechnologyModel>.from(
          map['data'].map(
            (item) {
              return TechnologyModel.fromJson(item);
            },
          ).toList(),
        );
      }
    };
  }

  Future<List<TechnologyModel>?> getTechnologies() async {
    final response = await get('/');
    return response.body;
  }
}
